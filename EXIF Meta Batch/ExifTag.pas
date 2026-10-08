unit ExifTag;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Jpeg, StdCtrls, ExtCtrls, Math;

type
  TExifTag = record
    ID: word;           // data type (e.g., $010F = device manufacturer)
    Typ: word;          // format of type: 2 = Pchar; 3 = Word, 4 = Cardinal...
    Count: cardinal;    // number of data items of the defined type
    Offset: cardinal;   // Data value, or the offset to this value if it cannot be stored in 4 bytes.
  end;

  TExifFileStream = class(TFileStream)
  private
    FMotorolaOrder: boolean;
    FExifStart: cardinal;
    FNbDirEntries: word;
    FIfd0Start: cardinal;
    function ReadString(Count: integer): string;
    function ReadWord: word;
    function ReadLong: cardinal;
    function ReadTag: TExifTag;
    function HasExif: boolean;
    function HasThumbNail(var ThumbStart, ThumbLen: cardinal): boolean;
    function GetThumbNail(ThumbStart, ThumbLen: cardinal; Bitmap: TBitmap): boolean;
  public
    constructor Create(const FileName: string; Mode: Word);
  end;

  TExifTagItem = record
     Name: string;
     Id: word;
     Typ: word;
     Count: cardinal;
     Dir: byte; // 0 = IFD0 directory, 1 = IFD0 subdirectory
     Value: variant;
     Value2: variant;
  end;

  TExifTagsArray = array[0..23] of TExifTagItem;

  TImageMetaData = class(Tobject)
  private
    FFileStream: TExifFileStream;
    TagsArray: TExifTagsArray;
    TagThumb1: TExifTag;
    TagThumb2: TExifTag;
    TagThumb3: TExifTag;
    TagThumb4: TExifTag;
    TagThumb5: TExifTag;
    TagSubdir: TExifTag;
    procedure ReadTagValues(ExifTag: TExifTag);
  public
    constructor Create;
    function ReadExif(FileName: string; ThumbNail: TBitmap): boolean;
    procedure InitializeTags;
    function SaveToJpeg(Bitmap: TBitmap; FileName: string; ThumbMaxSize: integer): boolean;
    procedure DisplayTags(Memo: TMemo);
    procedure GetExifTag(TagID: word; var Value1, Value2: variant);
    procedure SetExifTag(TagID: word; Value1, Value2: variant);
    procedure SetDescription(Value: string);

    procedure SetMaker(Value: string);
    procedure SetCopyright(Value: string);
    procedure SetModel(Value: string);
    procedure SetUserComment(Value: string);
    procedure SetArtist(Value: string);
    procedure SetExifVersion(Value: string);
    procedure SetLensMake(Value: string);
    procedure SetSoftware(Value: string);
    procedure SetDate(Value: string);
    procedure SetAperture(Value: string);
    procedure SetSpeed(Value: string);
    procedure SetExpoProgram(Value: string);
  end;


const  // This simply makes handling tags easier.
  TagID_Description = $010E;
  TagID_Maker = $010F;
  TagID_Model = $0110;
  TagID_Date = $0132;
  TagID_Speed = $829A;
  TagID_Aperture = $829D;
  TagID_ExpoProgram = $8822;
  TagID_Iso = $8827;
  TagID_OriginalDate = $9003;
  TagID_MeteringMode = $9207;
  TagID_Focal = $920A;
  TagID_ImageWidth = $A002;
  TagID_ImageHeight = $A003;
  TagID_WhiteBalance = $A403;
  TagID_Focal35mm = $A405;
  TagID_Contrast = $A408;
  TagID_Saturation = $A409;
  TagID_Sharpness = $A40A; // emphasis
  TagID_Copyright = $8298;
  TagID_UserComment = $9286;
  TagID_Artist = $013B;
  TagID_ExifVersion = $9000;
  TagID_LensMake = $A433;
  TagID_Software = $0131;

  TagID_SubDir = $8769;       // IFD0 subdirectory
  TagID_ThumbOffset = $0201; // offset to thumbnail
  TagID_ThumbLen = $0202;   // thumbnail size

type
  TRGBTripleArray = ARRAY[0..32767] of TRGBTriple;
  PRGBTripleArray = ^TRGBTripleArray;
  TRGBArray = array[0..0] of TRGBTriple;
  pRGBArray = ^TRGBArray;

implementation

uses
  Unit1;

procedure FlipBitmapH(Bmp: TBitmap; Horizontal: Boolean);
var
  Temp: TBitmap;
  W, H: Integer;
  SrcRect, DstRect: TRect;
begin
  W := Bmp.Width;
  H := Bmp.Height;
  SrcRect := Rect(0, 0, W, H);
  
  if Horizontal then
    DstRect := Rect(W, 0, 0, H)  // Flips horizontally (left/right reversed)
  else
    DstRect := Rect(0, H, W, 0); // Flips vertically (top/bottom reversed)

  Temp := TBitmap.Create;
  try
    Temp.Width := W;
    Temp.Height := H;
    Temp.Canvas.CopyRect(DstRect, Bmp.Canvas, SrcRect);
    Bmp.Assign(Temp);
  finally
    Temp.Free;
  end;
end;

procedure flip_vertikal(Quelle, Ziel: TBitMap);
begin
  Ziel.Assign(nil);
  Ziel.Width  := Quelle.Width;
  Ziel.Height := Quelle.Height;
  StretchBlt(Ziel.Canvas.Handle, 0, 0, Ziel.Width, Ziel.Height, Quelle.Canvas.Handle,
    Quelle.Width, 0, Quelle.Width, Quelle.Height, srccopy);
end;

function NagtivRGB(MyBitmap: TBitmap): TBitmap;
var
  x, y: Integer;
  ByteArray: PByteArray;
begin
  MyBitmap.PixelFormat := pf24Bit;
  for y := 0 to MyBitmap.Height - 1 do
  begin
    ByteArray := MyBitmap.ScanLine[y];
    for x := 0 to MyBitmap.Width * 3 - 1 do
    begin
      ByteArray[x] := 255 - ByteArray[x];
    end;
  end;
  Result := MyBitmap;
end;

procedure BmpAccentuation(Bmp : TBitmap; Correction: integer);
type
  TRGBArray = array[Word] of TRGBTriple;
  PRGBArray = ^TRGBArray;
var
  Filter: array[0..8] of integer; // matrice de 3 * 3 pixels
  Red, Green, Blue, NewR, NewG, NewB, I,
  PosX, PosY, mX, mY, dX, dY, Diviseur : integer;
  TabScanlineBmp : array of PRGBArray;
  TabScanlineFinalBmp : array of PRGBArray;
  FinalBmp : TBitmap;
begin
   for I:= 0 to High(Filter) do
     if I in [0,2,6,8] then Filter[I]:= - Correction
     else if I = 4 then Filter[I]:= (Correction * 4) + 128 // +128 permet une correction bien étalée
     else Filter[I]:= 0;
   Diviseur:= Filter[4] - (Correction * 4);

   FinalBmp := TBitmap.Create;

   try
      FinalBmp.Assign(Bmp);
      SetLength(TabScanlineBmp, Bmp.Height);
      SetLength(TabScanlineFinalBmp, Bmp.Height);
      for I := 0 to Bmp.Height-1 do
      begin
          TabScanlineBmp[I] := Bmp.Scanline[I];
          TabScanlineFinalBmp[I] := FinalBmp.Scanline[I];
      end;

      for PosY := 0 to Bmp.Height - 1 do
          for PosX := 0 to Bmp.Width - 1 do
          begin
             NewR :=0;
             NewG :=0;
             NewB :=0;
             for dY := -1 to 1 do
                for dX := -1 to 1 do
                begin
                   // position of the pixel to be processed
                   mY := PosY + dY;
                   mX := PosX + dX;
                   // Checking the limits to avoid side effects
                   // Reading the RGB components of each pixel
                   if  (mY >= 1) and (mY <= BMP.Height - 1)
                     and (mX >= 1) and (mX <= BMP.Width - 1) then
                        begin
                           Red := TabScanlineBmp[mY,mX].RGBTRed;
                           Green := TabScanlineBmp[mY,mX].RGBTGreen;
                           Blue := TabScanlineBmp[mY,mX].RGBTBlue;
                        end
                   else
                        begin
                           Red := TabScanlineBmp[PosY,PosX].RGBTRed;
                           Green := TabScanlineBmp[PosY,PosX].RGBTGreen;
                           Blue := TabScanlineBmp[PosY,PosX].RGBTBlue;
                         end;

                   I := 4 + (dY * 3) + dX; // I can vary from 0 to 8
                   NewR := NewR + Red * Filter[I];
                   NewG := NewG + Green * Filter[I];
                   NewB := NewB + Blue * Filter[I];
                end;

             NewR := NewR div Diviseur;
             NewG := NewG div Diviseur;
             NewB := NewB div Diviseur;
             if NewR > 255 then NewR := 255 else if NewR < 0 then NewR := 0;
             if NewG > 255 then NewG := 255 else if NewG < 0 then NewG := 0;
             if NewB > 255 then NewB := 255 else if NewB < 0 then NewB := 0;
             TabScanlineFinalBmp[PosY,PosX].RGBTRed   := NewR;
             TabScanlineFinalBmp[PosY,PosX].RGBTGreen := NewG;
             TabScanlineFinalBmp[PosY,PosX].RGBTBlue  := NewB;
      end;
      Bmp.Assign(FinalBmp);
   finally
      FinalBmp.Free;
      Finalize(TabScanlineBmp);
      Finalize(TabScanlineFinalBmp);
   end;
end;

function IntToByte(i : integer) : byte;
begin
  if (i>255) then
  Result := 255
    else
  if (i < 0) then
  Result := 0
    else
  Result := i;
end;

{Brightness}
procedure Brightness(Src : TBitmap; Amount : integer);
var
  x, y : integer;
  SrcLine : pRGBArray;
  SrcGap : integer;
begin
  Src.PixelFormat := pf24bit;
  SrcLine := Src.ScanLine[0];
  SrcGap := Integer(Src.ScanLine[1]) - Integer(SrcLine);
  
  {$ifopt R+}
  {$define RangeCheck}
  {$endif} {$R-}

  for y := 0 to pred(Src.Height) do
  begin
    for x := 0 to pred(Src.Width) do
    begin
      SrcLine[x].rgbtRed := IntToByte(SrcLine[x].rgbtRed +
      MulDiv(SrcLine[x].rgbtRed, Amount, 100));
      SrcLine[x].rgbtGreen := IntToByte(SrcLine[x].rgbtGreen +
      MulDiv(SrcLine[x].rgbtGreen, Amount, 100));
      SrcLine[x].rgbtBlue := IntToByte(SrcLine[x].rgbtBlue +
      MulDiv(SrcLine[x].rgbtBlue, Amount, 100));
    end; {for}
  SrcLine := pRGBArray(Integer(SrcLine) + SrcGap);
  end; {for}

  {$ifdef RangeCheck}
  {$R+}
  {$undef RangeCheck}
  {$endif}
end;

{Contrast}
procedure Contrast(Src : TBitmap; Amount : integer);
var
  x, y : integer;
  r, g, b : integer;
  rr, gg, bb : integer;
  SrcLine : pRGBArray;
  SrcGap : integer;
begin
  Src.PixelFormat := pf24bit;
  SrcLine := Src.ScanLine[0];
  SrcGap := Integer(Src.ScanLine[1]) - Integer(SrcLine);

  {$ifopt R+}
  {$define RangeCheck}
  {$endif}
  {$R-}

  for y := 0 to pred(Src.Height) do
  begin
    for x := 0 to pred(Src.Width) do
    begin
      r := SrcLine[x].rgbtRed;
      g := SrcLine[x].rgbtGreen;
      b := SrcLine[x].rgbtBlue;
      rr := MulDiv(abs(127-r), Amount, 100);
      gg := MulDiv(abs(127-g), Amount, 100);
      bb := MulDiv(abs(127-b), Amount, 100);

      if (r>127) then
        r := r+rr
      else
        r := r-rr;
      if (g>127) then
        g := g+gg
      else
        g := g-gg;
      if (b>127) then
        b := b+bb
      else
        b := b-bb;

      SrcLine[x].rgbtRed := IntToByte(r);
      SrcLine[x].rgbtGreen := IntToByte(g);
      SrcLine[x].rgbtBlue := IntToByte(b);
    end; {for}
    SrcLine := pRGBArray(Integer(SrcLine) + SrcGap);
  end; {for}
  {$ifdef RangeCheck}
  {$R+}
  {$undef RangeCheck}
  {$endif}
end;

procedure Grayscale(Bitmap: TBitmap);
var
  X, Y: Integer;
  Row: PRGBTripleArray;
  Gray: Byte;
begin
  Bitmap.PixelFormat := pf24bit; // Ensure 24-bit RGB format
  
  for Y := 0 to Bitmap.Height - 1 do
  begin
    Row := Bitmap.ScanLine[Y];
    for X := 0 to Bitmap.Width - 1 do
    begin
      // Standard luminance formula (ITU-R BT.601 / NTSC weights)
      Gray := (Integer(Row[X].rgbtRed) * 299 +
               Integer(Row[X].rgbtGreen) * 587 + 
               Integer(Row[X].rgbtBlue) * 114) div 1000;
               
      Row[X].rgbtRed := Gray;
      Row[X].rgbtGreen := Gray;
      Row[X].rgbtBlue := Gray;
    end;
  end;
end;

{ The SwapBytes procedure is by Florenth. Thanks to him. }
procedure SwapBytes(var Data; Count: Byte);
var
  B: PByte;
  E: PByte;
  T: Byte;
begin
  B := PByte(@Data);
  E := PByte(Integer(B) + Count - 1);
  while Integer(B) < Integer(E) do
  begin
    T := E^;
    E^:= B^;
    B^:= T;
    Inc(B);
    Dec(E);
  end;
end;

function SwapLong(Value: Cardinal): Cardinal;
begin
   SwapBytes(Value, SizeOf(Cardinal));
   Result:= Value;
end;

function SwapWord(Value: Word): Word;
begin
   SwapBytes(Value, SizeOf(Word));
   Result:= Value;
end;

{TExifFileStream}

constructor TExifFileStream.Create(const FileName: string; Mode: Word);
begin
  inherited Create(FileName, Mode);
  FMotorolaOrder:= false;
  FNbDirEntries:= 0;
  FExifStart:= 0;
  FIfd0Start:= 0;
end;

function TExifFileStream.ReadString(Count: integer): string;
begin
  SetLength(Result, Count);
  ReadBuffer(Result[1], Count);
end;

function TExifFileStream.ReadWord: word;
begin
  ReadBuffer(Result, SizeOf(Result));
  if FMotorolaOrder then Result:= SwapWord(Result);
end;

function TExifFileStream.ReadLong: cardinal;
begin
  ReadBuffer(Result, SizeOf(Result));
  if FMotorolaOrder then Result:= SwapLong(Result);
end;

function TExifFileStream.ReadTag: TExifTag;
begin
   ReadBuffer(Result,SizeOf(Result));
   if FMotorolaOrder then
      with Result do
      begin
         ID:= SwapWord(Id);
         Typ:= SwapWord(Typ);
         Count:= SwapLong(Count);
         if Typ = 3 then Offset:= (Offset shr 8) and $FF
             else Offset:= SwapLong(Offset);
      end;
end;

function TExifFileStream.HasExif: boolean;
const
  IOrder: string = #$49#$49#$2A#$00;
  MOrder: string = #$4D#$4D#$00#$2A;
var
  BufByte: byte;
  S: string;
  ExifOffset: cardinal;
  I: integer;
begin
  Result:= false;
  if ReadString(2) = #$FF#$D8 then  // It's a JPEG file, starting with $FF$D8
  begin
      // searching for the Exif marker APP1 (= $FF$E1)
      I:= 0;
      while (I < 5) and (Position < Size - 100) do
      begin
          ReadBuffer(BufByte, SizeOf(BufByte));
          if BufByte = $FF then
          begin
              Inc(I);
              ReadBuffer(BufByte, SizeOf(BufByte));
              if BufByte = $E1 then  // we found the marker
              begin
                  { We skip the header $45$78$69$66$00$00 + the 2 bytes
                    containing the length of the APP1 section }
                  Seek(8, soFromCurrent);
                  // reading the alignment
                  S:= ReadString(4);
                  if S = IOrder then FMotorolaOrder:= false
                     else if S = MOrder then FMotorolaOrder:= true
                        else
                          Exit;
                  // It remembers the starting point of the Exif data: all offsets are calculated.
                  // starting at $49 or $4D
                  FExifStart:= Position -4;
                  // reading the offset to the IFD0 directory (usually = 8)
                  ExifOffset:= ReadLong;
                  Position:= FExifStart + ExifOffset;
                  // reading the number of entries of IFD0
                  FNbDirEntries:= ReadWord;
                  Result:= (FNbDirEntries > 0);
                  FIfd0Start:= Position; // departure of IFD0 entries;
                  Exit;
              end;
          end;
      end;
  end
  else
  begin
      Position:= 0;
      S:= ReadString(4);
      if S = IOrder then FMotorolaOrder:= false  // Intel alignment TIFF file
          else if S = MOrder then FMotorolaOrder:= true  // Motorola alignment TIFF file
             else
                Exit;
      ExifOffset:= ReadLong;
      Position:= ExifOffset;
      FNbDirEntries:= ReadWord;
      FExifStart:= 0;
      Result:= (FNbDirEntries > 0);
      FIfd0Start:= Position; // departure of IFD0 entries;
  end;
end;

function TExifFileStream.HasThumbNail(var ThumbStart, ThumbLen: cardinal): boolean;
var
  ExifTag: TExifTag;
  Ifd1: cardinal;
  I: integer;
  NbEntries: word;
begin
  Result:= false;
  ThumbStart:= 0;
  ThumbLen:= 0;

  try
     Position:= FIfd0Start + (FNbDirEntries * 12);
     Ifd1:= ReadLong; // we obtain the offset of IFD1 (thumbnail directory)
     Position:= FExifStart + Ifd1;
     NbEntries:= ReadWord; // number of entries of IFD1
     for I := 1 to NbEntries do
     begin
         ExifTag:= ReadTag;
         if ExifTag.Id = TagID_ThumbOffset then ThumbStart:= ExifTag.Offset;
         if ExifTag.Id = TagID_ThumbLen then ThumbLen:= ExifTag.Offset;
         if (ThumbStart > 0) and (ThumbLen > 0) then Break;
     end;
     if (ThumbStart > 0) and (ThumbLen > 0) then
     begin
         ThumbStart:= FExifStart + ThumbStart;
         Position:= ThumbStart;
         Result:= (ReadString(2) = #$FF#$D8); // the thumbnail is in JPEG format
     end;
  except
  end;
end;

function TExifFileStream.GetThumbNail(ThumbStart, ThumbLen: cardinal; Bitmap: TBitmap): boolean;
var
  Jpeg: TJpegImage;
  Stream: TMemoryStream;
begin
  Result:= false;
  Stream:= TMemoryStream.Create;
  Jpeg:= TJpegImage.Create;
  try
      try
         Position:= ThumbStart;
         Stream.CopyFrom(Self, ThumbLen);
         Stream.Position:= 0;
         Jpeg.LoadFromStream(Stream);
         Bitmap.Assign(Jpeg);
         Result:= true;
      except
        Form1.StatusBar1.Panels[9].Text := 'Get ThumbNail fail..';
      end;
  finally
     Stream.Free;
     JPeg.Free;
  end;
end;

{TImageMetaData}
constructor TImageMetaData.Create;
begin
  inherited Create;
  // définition des Tags utilisés
  with TagsArray[0]  do begin Name:= 'Description'; Id:= TagID_Description; Typ:= 2; Count:= 0; Dir:= 0; end;
  with TagsArray[1]  do begin Name:= 'Maker'; Id:= TagID_Maker; Typ:= 2; Count:= 0; Dir:= 0; end;
  with TagsArray[2]  do begin Name:= 'Model'; Id:= TagID_Model; Typ:= 2; Count:= 0; Dir:= 0; end;
  with TagsArray[3]  do begin Name:= 'Date'; Id:= TagID_Date; Typ:= 2; Count:= 20; Dir:= 0; end;
  with TagsArray[4]  do begin Name:= 'Speed'; Id:= TagID_Speed; Typ:= 5; Count:= 1; Dir:= 1; end;
  with TagsArray[5]  do begin Name:= 'Aperture'; Id:= TagID_Aperture; Typ:= 5; Count:= 1; Dir:= 1; end;
  with TagsArray[6]  do begin Name:= 'Program'; Id:= TagID_ExpoProgram; Typ:= 3; Count:= 1; Dir:= 1; end;
  with TagsArray[7]  do begin Name:= 'ISO'; Id:= TagID_Iso; Typ:= 3; Count:= 1; Dir:= 1; end;
  with TagsArray[8]  do begin Name:= 'Date original'; Id:= TagID_OriginalDate; Typ:= 2; Count:= 20; Dir:= 1; end;
  with TagsArray[9]  do begin Name:= 'Light measurement'; Id:= TagID_MeteringMode; Typ:= 3; Count:= 1; Dir:= 1; end;
  with TagsArray[10] do begin Name:= 'Focal length'; Id:= TagID_Focal; Typ:= 5; Count:= 1; Dir:= 1; end;
  with TagsArray[11] do begin Name:= 'Width'; Id:= TagID_ImageWidth; Typ:= 4; Count:= 1; Dir:= 1; end;
  with TagsArray[12] do begin Name:= 'Height'; Id:= TagID_ImageHeight; Typ:= 4; Count:= 1; Dir:= 1; end;
  with TagsArray[13] do begin Name:= 'White balance'; Id:= TagID_WhiteBalance; Typ:= 3; Count:= 1; Dir:= 1; end;
  with TagsArray[14] do begin Name:= '35mm equivalent focal length'; Id:= TagID_Focal35mm; Typ:= 3; Count:= 1; Dir:= 1; end;
  with TagsArray[15] do begin Name:= 'Contrast'; Id:= TagID_Contrast; Typ:= 3; Count:= 1; Dir:= 1; end;
  with TagsArray[16] do begin Name:= 'Saturation'; Id:= TagID_Saturation; Typ:= 3; Count:= 1; Dir:= 1; end;
  with TagsArray[17] do begin Name:= 'Emphasis'; Id:= TagID_Sharpness; Typ:= 3; Count:= 1; Dir:= 1; end;
  with TagsArray[18] do begin Name:= 'Copyright'; Id:= TagID_Copyright; Typ:= 2; Count:= 0; Dir:= 0; end;
  with TagsArray[19] do begin Name:= 'UserComment'; Id:= TagID_UserComment; Typ:= 2; Count:= 0; Dir:= 1; end;
  with TagsArray[20] do begin Name:= 'Artist'; Id:= TagID_Artist; Typ:= 2; Count:= 0; Dir:= 0; end;
  with TagsArray[21] do begin Name:= 'Exif Version'; Id:= TagID_ExifVersion; Typ:= 2; Count:= 1; Dir:= 1; end;
  with TagsArray[22] do begin Name:= 'Lens Make'; Id:= TagID_LensMake; Typ:= 2; Count:= 0; Dir:= 1; end;
  with TagsArray[23] do begin Name:= 'Software'; Id:= TagID_Software; Typ:= 2; Count:= 0; Dir:= 0; end;

  // Tags regarding the thumbnail
  with TagThumb1 do begin Id:= $0100; Typ:= 4; Count:= 1; end; // thumbnail width
  with TagThumb2 do begin Id:= $0101; Typ:= 4; Count:= 1; end; // thumbnail height
  with TagThumb3 do begin Id:= $0103; Typ:= 3; Count:= 1; end; // thumbnail compression
  with TagThumb4 do begin Id:= $0201; Typ:= 4; Count:= 1; end; // offset to thumbnail
  with TagThumb5 do begin Id:= $0202; Typ:= 4; Count:= 1; end; // thumbnail size
  with TagSubdir do begin Id:= $8769; Typ:= 4; Count:= 1; end; // Offset of the subdirectory
  // initialization of tag values
  InitializeTags;
end;

procedure TImageMetaData.InitializeTags;
var
  I: integer;
begin
  for I:= 0 to High(TagsArray) do
    with TagsArray[I] do
    begin
      Value:= '';
      Value2:= '';
  end;

  TagThumb1.Offset:= 0;
  TagThumb2.Offset:= 0;
  TagThumb3.Offset:= 6; // Thumbnail compression: 6 = JPEG
  TagThumb4.Offset:= 0;
  TagThumb5.Offset:= 0;
  TagSubdir.Offset:= 0;
end;

procedure TImageMetaData.ReadTagValues(ExifTag: TExifTag);
var
  I: integer;
  CurPos: Cardinal;
begin
  for I:= 0 to High(TagsArray) do
     if TagsArray[I].Id = ExifTag.Id then
     begin
         case TagsArray[I].Typ of
            2: begin
                   CurPos:= FFileStream.Position;
                   FFileStream.Position:= FFileStream.FExifStart + ExifTag.Offset;
                   TagsArray[I].Value:= FFileStream.ReadString(ExifTag.Count);
                   FFileStream.Position:= CurPos;
                end;
            3,4: TagsArray[I].Value:= ExifTag.Offset;
            5: begin
                   CurPos:= FFileStream.Position;
                   FFileStream.Position:= FFileStream.FExifStart + ExifTag.Offset;
                   TagsArray[I].Value:= FFileStream.ReadLong;
                   TagsArray[I].Value2:= FFileStream.ReadLong;
                   FFileStream.Position:= CurPos;
                end;
         end;
         Break;
     end;
end;

{ Reading Exif data
  The function can be called with ThumbNail = nil to avoid extracting the thumbnail }
function TImageMetaData.ReadExif(FileName: string; ThumbNail: TBitmap): boolean;
var
  Position: Cardinal;
  I,J: integer;
  ExifTag: TExifTag;
  SubDirEntries: word;
  ThumbStart, ThumbLen: cardinal;
begin
   Result:= false;
   InitializeTags;
   FFileStream:= TExifFileStream.Create(FileName, fmOpenRead);
   try
      try
         Result:= FFileStream.HasExif;
         if Result then
         begin
              for I:= 1 to FFileStream.FNbDirEntries do
              begin
                  ExifTag:= FFileStream.ReadTag;
                  if ExifTag.ID = TagID_SubDir then
                  begin
                      Position:= FFileStream.Position;
                      FFileStream.Position:= FFileStream.FExifStart + ExifTag.Offset;
                      SubDirEntries:= FFileStream.ReadWord;
                      for J := 1 to SubDirEntries do
                      begin
                          ExifTag := FFileStream.ReadTag;
                          ReadTagValues(ExifTag);
                      end;
                      FFileStream.Position:= Position;
                  end
                  else
                      ReadTagValues(ExifTag);
              end;
              if ThumbNail <> nil then
                 if FFileStream.HasThumbNail(ThumbStart, ThumbLen) then
                    FFileStream.GetThumbNail(ThumbStart, ThumbLen, ThumbNail);
         end;
      except
        Form1.StatusBar1.Panels[9].Text := 'Read stream fail..';
      end;
   finally
      FFileStream.Free;
   end;
end;

{ Saved with EXIF ??data
  If ThumbMaxSize = 0, the thumbnail will not be embedded}
function TImageMetaData.SaveToJpeg(Bitmap: TBitmap; FileName: string;
                                  ThumbMaxSize: integer): boolean;
const
  JpegHeader: array[0..19] of byte = ($FF,$D8,$FF,$E1, // FF E0 (for JFIF)
                                      0,0,
                                      $45,$78,$69,$66,0,0,
                                      $49,$49,$2A,0,$08,0,0,0);
var
  F, ImageStream, ThumbStream: TMemoryStream;
  N: integer;
  DirEntries, SubDirEntries, LenExif: word;
  JpegImage: TJpegImage;
  Ifd1Offset: cardinal;
  BufLong: cardinal;
  DirValuesOffset: cardinal;
  SubDirOffset: cardinal;

        procedure WriteEntries(Dir: byte);
        var
          I: integer;
          ExifTag: TExifTag;
        begin
            for I:= 0 to High(TagsArray) do
               if (TagsArray[I].Dir = Dir) and (string(TagsArray[I].Value) <> '') then
               begin
                   ExifTag.Id:= TagsArray[I].Id;
                   ExifTag.Typ:= TagsArray[I].Typ;
                   ExifTag.Count:= TagsArray[I].Count;
                   case TagsArray[I].Typ of
                      2: begin
                            ExifTag.Count:= Length(string(TagsArray[I].Value));
                            ExifTag.Offset:= DirValuesOffset;
                            DirValuesOffset:= DirValuesOffset + ExifTag.Count;
                         end;
                      3,4: ExifTag.Offset:= Cardinal(TagsArray[I].Value);
                      5: begin
                            ExifTag.Offset:= DirValuesOffset;
                            DirValuesOffset:= DirValuesOffset + 8;
                         end;
                   end;
                   F.WriteBuffer(ExifTag, SizeOf(ExifTag));
               end;
        end;

        procedure WriteOffsetValues(Dir: byte); // values ??^placed in offset
        var
          I: integer;
          Buf: cardinal;
          S: string;
        begin
            for I:= 0 to High(TagsArray) do
                if (TagsArray[I].Dir = Dir) and (string(TagsArray[I].Value) <> '') then
                begin
                    case TagsArray[I].Typ of
                       2: begin
                             S:= string(TagsArray[I].Value);
                             F.WriteBuffer(S[1], Length(S));
                          end;
                       5: begin
                             Buf:= Cardinal(TagsArray[I].Value);
                             F.WriteBuffer(buf,4);
                             Buf:= Cardinal(TagsArray[I].Value2);
                             F.WriteBuffer(Buf,4);
                          end;
                    end;
                end;
        end;

        procedure MakeThumbNail;
        var
           ThumbBitmap: TBitmap;
           ThumbJpeg: TJpegImage;
           Percent: double;
        begin
           ThumbBitmap:= TBitmap.Create;
           ThumbJpeg:= TJpegImage.Create;
           ThumbStream:= TMemoryStream.Create;
           try
               Percent:= Min(ThumbMaxSize / Bitmap.Width, ThumbMaxSize / Bitmap.Height);
               with ThumbBitmap do
               begin
                   Width:=  Round(Bitmap.Width * Percent);
                   Height:= Round(Bitmap.Height * Percent);
                   PixelFormat:= Bitmap.PixelFormat;
               end;
               SetStretchBltMode(ThumbBitmap.Canvas.Handle, HALFTONE);
               StretchBlt(ThumbBitmap.Canvas.Handle,
                          0, 0, ThumbBitmap.Width, ThumbBitmap.Height,
                          Bitmap.Canvas.Handle,
                          0, 0, Bitmap.Width, Bitmap.Height,
                          SRCCOPY);
               ThumbJpeg.Assign(ThumbBitmap);
               ThumbJpeg.SaveToStream(ThumbStream);
               TagThumb1.Offset:= ThumbBitmap.Width;
               TagThumb2.Offset:= ThumbBitmap.Height;
               TagThumb5.Offset:= ThumbStream.Size;
           finally
               ThumbBitmap.Free;
               ThumbJpeg.Free;
           end;
        end;

begin
  Result:= false;
  ThumbStream:= nil;
  ImageStream:= TMemoryStream.Create;
  F:= TMemoryStream.Create;
  JpegImage:= TJpegImage.Create;

  try
     try
        if ThumbMaxSize > 0 then MakeThumbNail;
        // counts the number of entries in the IFD0 directory and any subdirectory
        DirEntries:= 0;
        SubDirEntries:= 0;
        SubDirOffset:= 0;
        for N:= 0 to High(TagsArray) do
           if string(TagsArray[N].Value) <> '' then
              if TagsArray[N].Dir = 0 then Inc(DirEntries) else Inc(SubDirEntries);
        if SubDirEntries > 0 then Inc(DirEntries);
        if DirEntries = 0 then  // at least one entry is required
        begin
           SetDescription('  ' + #0);
           DirEntries:= 1;
        end;

        // writing the header
        F.WriteBuffer(JpegHeader, sizeof(JpegHeader));

        // writing the number of entries in the IFD0 directory
        F.WriteBuffer(DirEntries, 2);

        // calculation of the starting point of the values ??placed in offset
        DirValuesOffset:= 10 + (DirEntries * 12) + 4; // + 4 because we need to store the pointer to IFD1

        // writing entries to the main directory IFD0
        WriteEntries(0);

        // writing the entry pointing to the subdirectory
        // We memorize its position to correct the offset later.
        if SubDirEntries > 0 then
        begin
           F.WriteBuffer(TagSubDir, sizeof(TagSubDir));
           SubDirOffset:= F.Position - 4;
        end;

        // writing the offset of IFD1 (thumbnail)
        // We memorize its position to correct the offset later.
        Ifd1Offset:= F.Position;
        BufLong:= 1;
        F.WriteBuffer(BufLong, 4);

        // writing the values ??placed in offset of the main directory
        WriteOffsetValues(0);

        // subdirectory of IFD0
        if SubDirEntries > 0 then
        begin
           // correction of the subdirectory offset
           BufLong:= F.Position - 12;
           F.Position:= SubDirOffset;
           F.WriteBuffer(BufLong, SizeOf(BufLong));
           F.Position:= BufLong + 12;

           // writing the number of entries in the subdirectory
           F.WriteBuffer(SubDirEntries,2);

           // calculation of the starting point of the values ??placed in offset
           DirValuesOffset:= F.Position - 12 + (SubDirEntries * 12);

           // writing entries to the IFD0 subdirectory
           WriteEntries(1);

           // writing the values ??placed in offset
           WriteOffsetValues(1);
        end;

        // IFD1 = thumbnail directory
        if ThumbMaxSize > 0 then
        begin
            // correction of the offset at the beginning of IFD1
            BufLong:= F.Position-12;
            F.Position:= Ifd1Offset;
            F.WriteBuffer(BufLong, SizeOf(BufLong));
            F.Position:= BufLong + 12;

            // writing the number of entries of IFD1
            DirEntries:= 5;
            F.WriteBuffer(DirEntries, SizeOf(DirEntries));

            // writing IFD1 tags
            F.WriteBuffer(TagThumb1, SizeOf(TagThumb1));
            F.WriteBuffer(TagThumb2, SizeOf(TagThumb2));
            F.WriteBuffer(TagThumb3, SizeOf(TagThumb3));

            // +12 = -12 (header) + 24: writing of tagthumbs 4 and 5
            TagThumb4.Offset:= F.Position + 12;
            F.WriteBuffer(TagThumb4, SizeOf(TagThumb4));
            F.WriteBuffer(TagThumb5, SizeOf(TagThumb5));

            // writing the thumbnail
            ThumbStream.Position:= 0;
            F.CopyFrom(ThumbStream, ThumbStream.Size);
        end;

        // We've reached the end of the EXIF ??data; we're saving its length.
        LenExif:= SwapWord(F.Size - 2);

        // calculate grayscale
        if Form1.CheckBox3.Checked = true then
           Grayscale(Bitmap);

        // calculate brightness
        if Form1.ScrollBar2.Position <> 0 then
          Brightness(Bitmap, Form1.ScrollBar2.Position);

        // calculate contrast
        if Form1.ScrollBar3.Position <> 0 then
          Contrast(Bitmap, Form1.ScrollBar3.Position);

        // calculate sharpness
        if Form1.ScrollBar4.Position <> 0 then
          BmpAccentuation(Bitmap, Form1.ScrollBar4.Position);

        // calculate negativ foto
        if Form1.CheckBox4.Checked = true then
          NagtivRGB(Bitmap);

        // flip the picture vertical
        if Form1.CheckBox5.Checked = true then
          FlipBitmapH(Bitmap, true);

        // flip the picture horizontal
        if Form1.CheckBox6.Checked = true then
          FlipBitmapH(Bitmap, false);

        // writing the main image
        JpegImage.Assign(Bitmap);

        // jpeg compression
        JpegImage.CompressionQuality := Form1.ScrollBar1.Position;
        JpegImage.Compress;

        // copy pixels to m,emory stream
        JpegImage.SaveToStream(ImageStream);
        ImageStream.Position:= 0;
        F.CopyFrom(ImageStream, ImageStream.Size);

        // exif length correction
        F.Position:= 4;
        F.WriteBuffer(LenExif, SizeOf(LenExif));

        // all we have to do is save the file
        F.SaveToFile(FileName);
        Result:= true;
     except
      Form1.StatusBar1.Panels[9].Text := 'Meta fail..';
     end;
  finally
     if ThumbStream <> nil then ThumbStream.Free;
     JpegImage.Free;
     ImageStream.Free;
     F.Free;
  end;
end;

{ displays Exif data in a TMemo
  If the output is to be in a TMemo}
procedure TImageMetaData.DisplayTags(Memo: TMemo);
var
  I: integer;
  D: double;
  S: string;
begin
  try
     //Memo.Clear;
     for I:= 0 to High(TagsArray) do
       if string(TagsArray[I].Value) <> '' then
       begin
           S:= '';
           case TagsArray[I].Id of
              TagID_ExpoProgram: case Cardinal(TagsArray[I].Value) of
                                    1: S:= 'Manuel';
                                    2: S:= 'Normal';
                                    3: S:= 'Aperture priority';
                                    4: S:= 'Speed priority';
                                    7: S:= 'Portrait mode';
                                    8: S:= 'Landscape mode';
                                    else S:= 'Unknown';
                                  end;
              TagID_MeteringMode: case Cardinal(TagsArray[I].Value) of
                                    1: S:= 'Average';
                                    2: S:= 'Average with a predominance in the center';
                                    3: S:= 'Spot';
                                    4: S:= 'Multispot';
                                    5: S:= 'Matrix';
                                    6: S:= 'Partial';
                                    else S:= 'Unknown';
                                  end;
                     TagID_Speed: S:= IntToStr(TagsArray[I].Value) +
                                      '/' + IntToStr(TagsArray[I].Value2);
                TagID_WhiteBalance: if Cardinal(TagsArray[I].Value) = 0
                                      then S:= 'Auto' else S:= 'Manual';
                 TagID_Contrast,
               TagID_Saturation,
                TagID_Sharpness: case Cardinal(TagsArray[I].Value) of
                                   0: S:= 'Normal';
                                   1: S:= 'Softened';
                                   2: S:= 'Reinforced';
                                 end;
           end;
           if S = '' then
              case TagsArray[I].Typ of
                  2: S:= string(TagsArray[I].Value);
                3,4: S:= IntToStr(cardinal(TagsArray[I].Value));
                  5: begin
                        D:= cardinal(TagsArray[I].Value) / cardinal(TagsArray[I].Value2);
                        S:= FloatToStr(D);
                     end;
              end;
           S:= TagsArray[I].Name + ': ' + S;
           //Memo.Lines.Add(S);  // display exif information in memo
       end;
  except
    Form1.StatusBar1.Panels[9].Text := 'Display tag fail..';
  end;
end;

procedure TImageMetaData.GetExifTag(TagID: word; var Value1, Value2: variant);
var
  I: integer;
begin
  Value1:= '';
  Value2:= '';
  for I:= 0 to High(TagsArray) do
     if TagsArray[I].Id = TagID then
     begin
       Value1:= TagsArray[I].Value;
       Value2:= TagsArray[I].Value2;
       Break;
     end;
end;

procedure TImageMetaData.SetExifTag(TagID: word; Value1, Value2: variant);
var
  I: integer;
  S: string;
begin
  for I:= 0 to High(TagsArray) do
     if TagsArray[I].Id = TagID then
       case TagsArray[I].Typ of
          2: begin
               S:= String(Value1);
               if (S <> '') and (S[Length(S)] <> #0) then S:= S + #0;
               TagsArray[I].Value:= S;
             end;
         else
         begin
           TagsArray[I].Value:= Value1;
           TagsArray[I].Value2:= Value2;
         end;
        Break;
     end;
end;

procedure TImageMetaData.SetDescription(Value: string);
begin
   SetExifTag(TagID_Description, Value, '');
end;

procedure TImageMetaData.SetMaker(Value: string);
begin
   SetExifTag(TagID_Maker, Value, '');
end;

procedure TImageMetaData.SetCopyright(Value: string);
begin
   SetExifTag(TagID_Copyright, Value, '');
end;

procedure TImageMetaData.SetModel(Value: string);
begin
   SetExifTag(TagID_Model, Value, '');
end;

procedure TImageMetaData.SetSpeed(Value: string);
begin
   SetExifTag(TagID_Speed, Value, '');
end;

procedure TImageMetaData.SetExpoProgram(Value: string);
begin
   SetExifTag(TagID_ExpoProgram, Value, '');
end;

procedure TImageMetaData.SetUserComment(Value: string);
begin
   SetExifTag(TagID_UserComment, Value, '');
end;

procedure TImageMetaData.SetArtist(Value: string);
begin
   SetExifTag(TagID_Artist, Value, '');
end;

procedure TImageMetaData.SetExifVersion(Value: string);
begin
   SetExifTag(TagID_ExifVersion, Value, '');
end;

procedure TImageMetaData.SetLensMake(Value: string);
begin
   SetExifTag(TagID_LensMake, Value, '');
end;

procedure TImageMetaData.SetSoftware(Value: string);
begin
   SetExifTag(TagID_Software, Value, '');
end;

procedure TImageMetaData.SetDate(Value: string);
begin
   SetExifTag(TagID_Date, Value, '');
end;

procedure TImageMetaData.SetAperture(Value: string);
begin
   SetExifTag(TagID_Aperture, Value, '');
end;

end.
