unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Jpeg, StdCtrls, ExtCtrls, ExifReader, IPTC, ShellApi,
  ExifTag, XPMan, ComCtrls, Menus, Spin, IniFiles, Buttons, Mask;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Panel3: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Edit9: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Bevel1: TBevel;
    Label49: TLabel;
    Label50: TLabel;
    ProgressBar1: TProgressBar;
    Label51: TLabel;
    Label52: TLabel;
    CheckBox1: TCheckBox;
    PopupMenu1: TPopupMenu;
    S1: TMenuItem;
    SaveDialog1: TSaveDialog;
    R1: TMenuItem;
    C1: TMenuItem;
    P1: TMenuItem;
    Panel2: TPanel;
    Label53: TLabel;
    Button2: TButton;
    ListBox1: TListBox;
    Button4: TButton;
    Splitter1: TSplitter;
    ComboBox1: TComboBox;
    SpinEdit1: TSpinEdit;
    Image1: TImage;
    Label54: TLabel;
    Label55: TLabel;
    ComboBox2: TComboBox;
    Label56: TLabel;
    ScrollBar1: TScrollBar;
    Label57: TLabel;
    Label58: TLabel;
    GroupBox1: TGroupBox;
    SpinEdit2: TSpinEdit;
    Label59: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    S2: TMenuItem;
    ScrollBar4: TScrollBar;
    Label67: TLabel;
    Label68: TLabel;
    CheckBox4: TCheckBox;
    Label69: TLabel;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Button1: TButton;
    Label70: TLabel;
    Label71: TLabel;
    N1: TMenuItem;
    N2: TMenuItem;
    SpeedButton1: TSpeedButton;
    Button3: TButton;
    Label72: TLabel;
    Label73: TLabel;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    Edit10: TEdit;
    Label74: TLabel;
    Button8: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure R1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure S2Click(Sender: TObject);
    procedure ScrollBar4Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Edit9KeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Declarations privates }
    FSplitFileSize: Int64;
    flbHorzScrollWidth: Integer;
    procedure GetSplitFileSize;
    procedure WMDROPFILES(var Msg: TMessage);
    procedure LBWindowProc(var Message: TMessage);
    procedure AddFile(sFileName: string);
  public
    { Declarations public }
    abort : boolean;
    procedure WriteOptions;
    procedure ReadOptions;
    procedure WriteRemember;
    procedure ReadRemember;
  end;

var
  Form1: TForm1;
  ImageMetaData: TIMageMetaData;
  BitmapSource: TBitmap;
  OldLBWindowProc: TWndMethod;
  OrigBmp: TBitmap;
  TIF : TIniFile;

implementation

{$R *.dfm}
function MainDir : string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TForm1.WriteOptions;    // ################### Options Write
var
  OPT :string;
begin
   OPT := 'Options';

   if not DirectoryExists(MainDir + 'Data\Options\')
   then ForceDirectories(MainDir + 'Data\Options\');

   TIF := TIniFile.Create(MainDir + 'Data\Options\Options.ini');
   with TIF do
   begin
    WriteInteger(OPT,'Format',Combobox1.ItemIndex);
    WriteInteger(OPT,'Bit',Combobox2.ItemIndex);
    WriteInteger(OPT,'ThumbSize',SpinEdit1.Value);
    WriteInteger(OPT,'Compress',ScrollBar1.Position);
    WriteInteger(OPT,'Brightness',ScrollBar2.Position);
    WriteInteger(OPT,'Contrast',ScrollBar3.Position);
    WriteInteger(OPT,'Sharp',ScrollBar4.Position);
    WriteBool(OPT,'RemoveTags',CheckBox1.Checked);
    WriteBool(OPT,'Scale',CheckBox2.Checked);
    WriteInteger(OPT,'ScaleSize',SpinEdit2.Value);
    WriteBool(OPT,'Grayscale',CheckBox3.Checked);
    WriteBool(OPT,'Negativ',CheckBox4.Checked);
    WriteBool(OPT,'MirrorV',CheckBox5.Checked);
    WriteBool(OPT,'MirrorH',CheckBox6.Checked);
   Free;
   end;
end;

procedure TForm1.ReadOptions;    // ################### Options Read
var OPT:string;
begin
  OPT := 'Options';
  if FileExists(MainDir + 'Data\Options\Options.ini') then
  begin
    TIF:=TIniFile.Create(MainDir + 'Data\Options\Options.ini');
    with TIF do
    begin
      Combobox1.ItemIndex:=ReadInteger(OPT,'Format',ComboBox1.ItemIndex);
      Combobox2.ItemIndex:=ReadInteger(OPT,'Bit',ComboBox2.ItemIndex);
      SpinEdit1.Value:=ReadInteger(OPT,'ThumbSize',SpinEdit1.Value);
      ScrollBar1.Position:=ReadInteger(OPT,'Compress',ScrollBar1.Position);
      ScrollBar2.Position:=ReadInteger(OPT,'Brightness',ScrollBar2.Position);
      ScrollBar3.Position:=ReadInteger(OPT,'Contrast',ScrollBar3.Position);
      ScrollBar4.Position:=ReadInteger(OPT,'Sharp',ScrollBar4.Position);
      CheckBox1.Checked:=ReadBool(OPT,'RemoveTags',CheckBox1.Checked);
      CheckBox2.Checked:=ReadBool(OPT,'Scale',CheckBox2.Checked);
      SpinEdit2.Value:=ReadInteger(OPT,'ScaleSize',SpinEdit2.Value);
      CheckBox3.Checked:=ReadBool(OPT,'Grayscale',CheckBox3.Checked);
      CheckBox4.Checked:=ReadBool(OPT,'Negativ',CheckBox4.Checked);
      CheckBox5.Checked:=ReadBool(OPT,'MirrorV',CheckBox5.Checked);
      CheckBox6.Checked:=ReadBool(OPT,'MirrorH',CheckBox6.Checked);
    Free;
  end;
  end;
end;

procedure TForm1.WriteRemember;    // ################### Options Write Remember
var
  OPT :string;
begin
   OPT := 'Options';

   if not DirectoryExists(MainDir + 'Data\Options\')
   then ForceDirectories(MainDir + 'Data\Options\');

   TIF := TIniFile.Create(MainDir + 'Data\Options\Remember.ini');
   with TIF do
   begin
      WriteString(OPT,'Description',Edit1.Text);
      WriteString(OPT,'Copyright',Edit3.Text);
      WriteString(OPT,'Camera',Edit2.Text);
      WriteString(OPT,'Model',Edit4.Text);
      WriteString(OPT,'Autor',Edit5.Text);
      WriteString(OPT,'Software',Edit6.Text);
      WriteString(OPT,'Comment',Edit7.Text);
      WriteString(OPT,'ExifVersion',Edit8.Text);
      WriteString(OPT,'DateTime',Edit9.Text);
    Free;
   end;
end;

// Reminder regarding the last few days' entries
procedure TForm1.ReadRemember;    // ################### Options Read Remember
var OPT:string;
begin
  OPT := 'Options';
  if FileExists(MainDir + 'Data\Options\Remember.ini') then
  begin
    TIF:=TIniFile.Create(MainDir + 'Data\Options\Remember.ini');
    with TIF do
    begin
        Edit1.Text:=ReadString(OPT,'Description',Edit1.Text);
        Edit3.Text:=ReadString(OPT,'Copyright',Edit3.Text);
        Edit2.Text:=ReadString(OPT,'Camera',Edit2.Text);
        Edit4.Text:=ReadString(OPT,'Model',Edit4.Text);
        Edit5.Text:=ReadString(OPT,'Autor',Edit5.Text);
        Edit6.Text:=ReadString(OPT,'Software',Edit6.Text);
        Edit7.Text:=ReadString(OPT,'Comment',Edit7.Text);
        Edit8.Text:=ReadString(OPT,'ExifVersion',Edit8.Text);
        Edit9.Text:=ReadString(OPT,'DateTime',Edit9.Text);
      Free;
  end;
  end;
end;

// resize the graphic by a percentage
procedure StretchGraphic(const src, dest: TGraphic;
  DestWidth, DestHeight: integer; Smooth: Boolean = true);
var
  temp, aCopy: TBitmap;
  faktor: double;
begin
  Assert(Assigned(src) and Assigned(dest));
  if (src.Width = 0) or (src.Height = 0) then
    raise Exception.CreateFmt('Invalid source dimensions: %d x %d',[src.Width, src.Height]);
  if src.Width > DestWidth then
    begin
      faktor := DestWidth / src.Width;
      if (src.Height * faktor) > DestHeight then
        faktor := DestHeight / src.Height;
    end
  else
    begin
      faktor := DestHeight / src.Height;
      if (src.Width * faktor) > DestWidth then
        faktor := DestWidth / src.Width;
    end;
  try
    aCopy := TBitmap.Create;
    try
      aCopy.PixelFormat := pf24Bit;
      aCopy.Assign(src);
      temp := TBitmap.Create;
      try
        temp.Width := round(src.Width * faktor);
        temp.Height := round(src.Height * faktor);
        if Smooth then
          SetStretchBltMode(temp.Canvas.Handle, HALFTONE);
        StretchBlt(temp.Canvas.Handle, 0, 0, temp.Width, temp.Height,
          aCopy.Canvas.Handle, 0, 0, aCopy.Width, aCopy.Height, SRCCOPY);
        dest.Assign(temp);
      finally
        temp.Free;
      end;
    finally
      aCopy.Free;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar(E.Message), nil, MB_OK or MB_ICONERROR);
  end;
end;

// precise determination of the file size
function GetFileSize(const AFile: string): Int64;
var
  SR: TSearchRec;
begin
  if FindFirst(AFile, 0, SR) = 0 then begin
    Int64Rec(Result).Lo := SR.FindData.nFileSizeLow;
    Int64Rec(Result).Hi := SR.FindData.nFileSizeHigh;
    SysUtils.FindClose(SR);
  end else
    Result := -1;
end;

// convert the file size from an integer to a precise decimal number
procedure TForm1.GetSplitFileSize;
begin
  FSplitFileSize := GetFileSize(ListBox1.Items.Strings[ListBox1.ItemIndex]);
  StatusBar1.Panels[5].Text := Format(' %.0n bytes', [FSplitFileSize * 1.0])
end;

procedure TForm1.AddFile(sFileName: string);
begin
  ListBox1.Items.Add(sFilename);
end;

procedure TForm1.LBWindowProc(var Message: TMessage);
begin
  if Message.Msg = WM_DROPFILES then
    // handle WM_DROPFILES message
    WMDROPFILES(Message);
  OldLBWindowProc(Message);
  // call default ListBox1 WindowProc method to handle all other messages
end;

// Execution of Windows property options
procedure PropertiesDialog(const aFilename: string);
var
  sei: ShellExecuteInfo;
begin
  FillChar(sei, SizeOf(sei), 0);
  sei.cbSize := SizeOf(sei);
  sei.lpFile := PChar(aFilename);
  sei.lpVerb := 'properties';
  sei.fMask  := SEE_MASK_INVOKEIDLIST;
  ShellExecuteEx(@sei);
end;

// enable drag-and-drop
procedure TForm1.WMDROPFILES(var Msg: TMessage);
var
  pcFileName: PChar;
  i, iSize, iFileCount: integer;
begin
  pcFileName := ''; // to avoid compiler warning message
  iFileCount := DragQueryFile(Msg.wParam, $FFFFFFFF, pcFileName, 255);
  for i := 0 to iFileCount - 1 do
  begin
    iSize := DragQueryFile(Msg.wParam, i, nil, 0) + 1;
    pcFileName := StrAlloc(iSize);
    DragQueryFile(Msg.wParam, i, pcFileName, iSize);
    if FileExists(pcFileName) then
      AddFile(pcFileName); // method to add each file
    StrDispose(pcFileName);
  end;
  DragFinish(Msg.wParam);
end;

// Find files and add them to the list.
procedure GetAllFilesExtra(List: TStrings);
var
  Path: String;
  Search: TSearchRec;
begin
  Path := ExtractFilePath(ParamStr(0));

  if FindFirst(Path + '*.*', faAnyFile, Search) = 0 then
  try
    repeat
      if (Search.Attr <> faDirectory) and (Search.Name[1] <> '.') then
        List.Add(Path + Search.Name);
    until FindNext(Search) <> 0;
  finally
    FindClose(Search);
  end;
end;

// Identify and assign the correct icon.
procedure IcoToBmpA(Ico: TIcon; Bmp: TBitmap; SmallIcon: Boolean);
var 
  WH: Byte; // Width and Height
begin
  with Bmp do 
  begin
    Canvas.Brush.Color := clFuchsia;
    TransparentColor := clFuchsia;

    Width := 16; Height := 16;
    Canvas.Draw(0, 0, Ico);

    if SmallIcon then
      WH := 16
    else
      WH := 32;
    Canvas.StretchDraw(Rect(0, 0, WH, WH), Bmp); 
    Width := WH; Height := WH; 

    Transparent :=  True;
  end;
end;

// Determine the icon of a file
procedure GetIconFromFileB(const FileName: String; Icon: TIcon;
  SmallIcon: Boolean);
var 
  sfi: TSHFILEINFO; 
const 
  uFlags : array[Boolean] of DWord = (SHGFI_LARGEICON, SHGFI_SMALLICON); 
begin 
  if SHGetFileInfo(PChar(FileName), 0, sfi, SizeOf(sfi), SHGFI_ICON or
     uFlags[SmallIcon]) <> 0 then 
    Icon.Handle := sfi.hIcon;
end;

// rendering the list box, including the icon shell
procedure DrawListBoxExtra(Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
const
  Col1: array [Boolean] of TColor = ($00F8F8F8, clWindow);
  Col2: array [Boolean] of TColor = (clInactiveCaptionText, clWindowText);
var
  Icon: TIcon;
  Bmp: TBitmap;
begin
  with (Control as TListbox) do 
  begin
    Icon := TIcon.Create;
    Bmp := TBitmap.Create;
    try
      if odSelected in State then 
        Canvas.Font.Color := clCaptionText
      else 
      begin
        Bmp.Canvas.Brush.Color := Canvas.Brush.Color;
        Canvas.Brush.Color := Col1[Odd(Index)];
        Canvas.Font.Color := Col2[(Control as TListBox).Enabled];
      end;
      GetIconFromFileB(Items[Index], Icon, True);
      IcoToBmpA(Icon, Bmp, True);
      Canvas.TextRect(Rect, Rect.Left + Bmp.Width + 2, Rect.Top + 2, Items[Index]);
      Canvas.Draw(Rect.Left, Rect.Top, Bmp);
    finally
      Bmp.Free;
      Icon.Free;
    end;
  end;
end;

// convert jpeg to bitmap
procedure JpegToBmp(const Filename: String);
var
  jpeg: TJPEGImage;
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  jpeg := TJPEGImage.Create;
  try
    jpeg.LoadFromFile(Filename);
    try
      bmp.Assign(jpeg);
      Form1.Image1.Picture.Bitmap.Assign(bmp);
      finally
    bmp.free;
   end;
   finally
   jpeg.free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // meta data memory access
  ImageMetaData:= TImageMetaData.Create;
  BitmapSource:= TBitmap.Create;
  ListBox1.Style := lbOwnerDrawFixed;
  ListBox1.ItemHeight := 16;
  Listbox1.Perform(LB_SetHorizontalExtent, 1000, Longint(0));
  OldLBWindowProc := ListBox1.WindowProc; // store defualt WindowProc
  ListBox1.WindowProc := LBWindowProc;    // replace default WindowProc
  DragAcceptFiles(ListBox1.Handle, True); // now ListBox1 accept dropped files
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 ImageMetaData.Free;
 BitmapSource.Free;
 WriteOptions;
end;

// List listbox entries neatly
procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
 Len: Integer;
 NewText: String;
begin
  NewText := Listbox1.Items[Index];

  with Listbox1.Canvas do
  begin
    FillRect(Rect);
    TextOut(Rect.Left + 1, Rect.Top, NewText);
    Len:=TextWidth(NewText) + Rect.Left + 10;
    if Len>flbHorzScrollWidth then
    begin
      flbHorzScrollWidth:=Len;
      Listbox1.Perform(LB_SETHORIZONTALEXTENT, flbHorzScrollWidth, 0 );
    end;
  end;

  DrawListBoxExtra(Control, Index, Rect, State);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  ListBox1.WindowProc := OldLBWindowProc;
  DragAcceptFiles(ListBox1.Handle, False);
end;

// load pictures
procedure TForm1.Button2Click(Sender: TObject);
begin
  // Enable multi-select in the file dialog
  OpenDialog1.Options := OpenDialog1.Options + [ofAllowMultiSelect];
  
  if OpenDialog1.Execute then
  begin
    ListBox1.Items.BeginUpdate;
    try
      // Clear existing entries or omit this line to append them
      ListBox1.Items.Clear;
      
      // Add all selected files to the ListBox
      ListBox1.Items.AddStrings(OpenDialog1.Files);
    finally
      ListBox1.Items.EndUpdate;
      StatusBar1.Panels[1].Text := IntToStr(ListBox1.Items.Count);
      ListBox1.Enabled := true;
    end;
  end;
end;

// Reading all EXIF ??tags and image properties
procedure TForm1.ListBox1Click(Sender: TObject);
var
  ex : TExif;
  Bmp: TBitmap;
  Jpg: TJpegImage;
begin
  Screen.Cursor := crHourGlass;
  ex := TExif.Create;
  Bmp:= TBitmap.Create;
  Jpg:= TJpegImage.Create;

      try
         with ImageMetaData do
            if ReadExif(ListBox1.Items.Strings[ListBox1.ItemIndex], Bmp) then
            begin
               JpegToBmp(ListBox1.Items.Strings[ListBox1.ItemIndex]);
               Image1.Refresh;
            end
            else
            begin
              JpegToBmp(ListBox1.Items.Strings[ListBox1.ItemIndex]);
            end;
         Jpg.LoadFromFile(ListBox1.Items.Strings[ListBox1.ItemIndex]);
         BitmapSource.Assign(Jpg);
      finally
         Bmp.Free;
         Jpg.Free;
      end;


  try
    ex.ReadFromFile(ListBox1.Items.Strings[ListBox1.ItemIndex]);
    if ex.Valid then
    begin

      Edit2.Text := ex.Make;        // camera
      Edit4.Text := ex.Model;       // camera model
      Edit1.Text := ex.ImageDesc;   // description
      Edit3.Text := ex.Copyright;   // copyright
      Edit9.Text := ex.DateTime;    // date/time
      Edit7.Text := ex.UserComments;  // comments
      Edit6.Text := ex.Software;    // software
      Edit5.Text := ex.Artist;      // author
      Edit8.Text := ex.Version;     // exif version
      Edit10.Text := ex.DateTimeOriginal;
      //Edit9.Text := ex.DateTimeDigitized;     

      if ex.Version <> '' then
      begin
        Edit8.Text := ex.Version;
      end else begin
        Edit8.Text := '0230 (v2.3)';
      end;

      Label29.Caption := ex.DateTimeOriginal;
      Label30.Caption := ex.DateTimeDigitized;
      Label31.Caption := (Format('%d (%s)',[Byte(ex.Orientation), ex.OrientationDesc]));
      Label32.Caption := ex.Exposure;
      Label33.Caption := (Format('%d (%s)',[ex.ExposureProgram, ex.ExposureProgramDesc]));
      Label34.Caption := ex.FStops;
      Label35.Caption := ex.ShutterSpeed;
      Label36.Caption := ex.Aperture;
      Label37.Caption := ex.MaxAperture;
      Label38.Caption := ex.CompressedBPP;
      Label39.Caption := IntToStr(ex.ISO);
      Label40.Caption := IntToStr(ex.PixelXDimension);
      Label41.Caption := IntToStr(ex.PixelYDimension);
      Label42.Caption := IntToStr(ex.XResolution);
      Label43.Caption := IntToStr(ex.YResolution);
      Label44.Caption := IntToStr(ex.MeteringMode);
      Label45.Caption := ex.MeteringMethod;
      Label46.Caption := (Format('%d (%s)',[ex.LightSource, ex.LightSourceDesc]));
      Label47.Caption := (Format('%d (%s)',[ex.Flash, ex.FlashDesc]));

    end else
      //  type error message
  finally
    ex.Free;
    if Label29.Caption = '' then Label29.Caption := Edit10.Text;
    if Label30.Caption = '' then Label30.Caption := Edit9.Text;
    StatusBar1.Panels[3].Text := ExtractFileName(ListBox1.Items.Strings[ListBox1.ItemIndex]);

    StatusBar1.Panels[7].Text := IntToStr(Image1.Picture.Graphic.Width) + 'x' +
                                 IntToStr(Image1.Picture.Graphic.Height);

    GetSplitFileSize;
  end;
  Screen.Cursor := crDefault;
end;

// start batch process
procedure TForm1.Button4Click(Sender: TObject);
var
  Value1, Value2: variant;
  Bmp, BmpResize: TBitmap;
  Jpg: TJpegImage;
  i : integer;
begin
  if ListBox1.Items.Count = 0 then
    begin
      Beep;
      MessageDlg('Upload images for this process.',mtInformation, [mbOK], 0);
      Exit;
    end;

  // Loop through all components of the form.
  for i := 0 to ComponentCount - 1 do
  begin
    // Check whether the component is a TEdit.
    if Components[i] is TEdit then
    begin
      // Append text if the field is not empty
      if Length(TEdit(Components[i]).Text) < 4 then
      begin
        if TEdit(Components[i]).Text <> '' then
        TEdit(Components[i]).Text := TEdit(Components[i]).Text + '   ';
      end;
    end;
  end;

  abort := false;
  Button4.Enabled := false;
  Button2.Enabled := false;
  Screen.Cursor := crHourGlass;
  ProgressBar1.Max := ListBox1.Items.Count;
  for i := 0 to ListBox1.Items.Count -1 do   // MainLoop
  BEGIN
    if abort = true then
    begin
      Screen.Cursor := crDefault;
      Button4.Enabled := true;
      Button2.Enabled := true;
      StatusBar1.Panels[3].Text := 'batch abort';
      Exit;
    end;

    Bmp := TBitmap.Create;
    BmpResize := TBitmap.Create;
    Jpg:= TJpegImage.Create;
      try
         with ImageMetaData do
            if ReadExif(ListBox1.Items.Strings[i], Bmp) then
            begin
               JpegToBmp(ListBox1.Items.Strings[i]);
               Image1.Refresh;
               Application.ProcessMessages;
            end
            else
            begin
               Image1.Picture.Bitmap:= nil;
            end;

         Jpg.LoadFromFile(ListBox1.Items.Strings[i]);
         BitmapSource.Assign(Jpg);

         case Form1.ComboBox2.ItemIndex of
          0 : BitmapSource.PixelFormat := pf8bit;
          1 : BitmapSource.PixelFormat := pf24bit;
          2 : BitmapSource.PixelFormat := pf32bit;
          3 : BitmapSource.PixelFormat := pfDevice;
          4 : BitmapSource.PixelFormat := pfCustom;
         end;

         if CheckBox2.Checked = true then
         begin
           StretchGraphic(BitmapSource, BmpResize,
              SpinEdit2.Value, SpinEdit2.Value,  true);
           BitmapSource.Assign(BmpResize);
           BmpResize.Free;
         end;

      finally
         Bmp.Free;
         Jpg.Free;
      end;

  with ImageMetaData do
   begin
       if CheckBox1.Checked = true then
       begin
          InitializeTags;
       end;

       // assignment of the legend
       SetDescription(Edit1.Text);
       SetMaker(Edit2.Text);
       SetCopyright(Edit3.Text);
       SetModel(Edit4.Text);
       SetUserComment(Edit7.Text);
       SetArtist(Edit5.Text);
       SetSoftware(Edit6.Text);

       GetExifTag(TagID_OriginalDate, Value1, Value2);
       SetExifTag(TagID_OriginalDate, Edit10.Text, '');

       GetExifTag(TagID_Date, Value1, Value2);
       SetExifTag(TagID_Date, Value1, '');

       GetExifTag(TagID_Aperture, Value1, Value2);
       SetExifTag(TagID_Aperture, Value2, Value2);

       SetExifVersion(IntToStr(TagID_ExifVersion));

       try
        SaveToJpeg(BitmapSource, ExtractFilePath(Application.ExeName) + '\Export\' +
                                  ExtractFileName(ListBox1.Items.Strings[i]) +
                                  '.' + ComboBox1.Text,
                                  SpinEdit1.Value);
       finally
         ProgressBar1.Position := i;
         Label66.Caption := IntToStr(ProgressBar1.Position);
         StatusBar1.Panels[3].Text := ExtractFileName(ListBox1.Items.Strings[i]);
         Application.ProcessMessages;
       end;
   end;

  END; // MainLoop
  ProgressBar1.Position := ProgressBar1.Max;
  StatusBar1.Panels[3].Text := 'batch finish';
  Button4.Enabled := true;
  Button2.Enabled := true;
  Screen.Cursor := crDefault;
end;

// saving individual files
procedure TForm1.S1Click(Sender: TObject);
var
  Bmp, BmpResize: TBitmap;
  Jpg: TJpegImage;
  Value1, Value2: variant;
  i : integer;
begin
  if SaveDialog1.Execute then
  BEGIN

  // Loop through all components of the form.
  for i := 0 to ComponentCount - 1 do
  begin
    // Check whether the component is a TEdit.
    if Components[i] is TEdit then
    begin
      // Append text if the field is not empty
      if Length(TEdit(Components[i]).Text) < 4 then
      begin
        if TEdit(Components[i]).Text <> '' then
        TEdit(Components[i]).Text := TEdit(Components[i]).Text + '   ';
      end;
    end;
  end;

  Bmp:= TBitmap.Create;
  Jpg:= TJpegImage.Create;
  try
    with ImageMetaData do
            if ReadExif(ListBox1.Items.Strings[ListBox1.ItemIndex], Bmp) then
            begin
               JpegToBmp(ListBox1.Items.Strings[ListBox1.ItemIndex]);
               Image1.Refresh;
            end
            else
            begin
               Image1.Picture.Bitmap:= nil;
            end;

         Jpg.LoadFromFile(ListBox1.Items.Strings[ListBox1.ItemIndex]);
         BitmapSource.Assign(Jpg);

         case Form1.ComboBox2.ItemIndex of
          0 : BitmapSource.PixelFormat := pf8bit;
          1 : BitmapSource.PixelFormat := pf24bit;
          2 : BitmapSource.PixelFormat := pf32bit;
          3 : BitmapSource.PixelFormat := pfDevice;
          4 : BitmapSource.PixelFormat := pfCustom;
         end;

         if CheckBox2.Checked = true then
         begin
           StretchGraphic(BitmapSource, BmpResize,
              SpinEdit2.Value, SpinEdit2.Value,  true);
           BitmapSource.Assign(BmpResize);
           BmpResize.Free;
         end;
         
      finally
         Bmp.Free;
         Jpg.Free;
      end;

  with ImageMetaData do
   begin
       if CheckBox1.Checked = true then
       begin
          InitializeTags;
       end;

       // assignment of the legend
       SetDescription(Edit1.Text);
       SetMaker(Edit2.Text);
       SetCopyright(Edit3.Text);
       SetModel(Edit4.Text);
       SetUserComment(Edit7.Text);
       SetArtist(Edit5.Text);
       SetSoftware(Edit6.Text);

       GetExifTag(TagID_Date, Value1, Value2);
       SetExifTag(TagID_Date, Value1, '');

       GetExifTag(TagID_Date, Value1, Value2);
       SetExifTag(TagID_Date, Value1, '');

       GetExifTag(TagID_Aperture, Value1, Value2);
       SetExifTag(TagID_Aperture, Value2, Value2);

       SetExifVersion(IntToStr(TagID_ExifVersion));

       SaveToJpeg(BitmapSource, SaveDialog1.FileName +
                        '.' + ComboBox1.Text, SpinEdit1.Value);
   end;
   END;
  StatusBar1.Panels[3].Text := 'save done.';
end;

// Removing multiple entries
procedure TForm1.R1Click(Sender: TObject);
var
  I : Integer;
begin
  ListBox1.Items.BeginUpdate; // Prevents the UI from flickering
  try
    for I := ListBox1.Items.Count - 1 downto 0 do
    begin
      if ListBox1.Selected[I] then
        ListBox1.Items.Delete(I);
    end;
  finally
    StatusBar1.Panels[1].Text := IntToStr(ListBox1.Items.Count);
    ListBox1.Items.EndUpdate; // Re-enables UI rendering
  end;
end;

// clear all informations
procedure TForm1.C1Click(Sender: TObject);
var
  i : integer;
begin
  ListBox1.Clear;
  StatusBar1.Panels[1].Text := IntToStr(ListBox1.Items.Count);
  StatusBar1.Panels[1].Text := '0';
  StatusBar1.Panels[3].Text := 'clear';
  StatusBar1.Panels[5].Text := '0.0 kb';
  StatusBar1.Panels[7].Text := '0x0';
  Image1.Picture.Graphic := nil;
  ProgressBar1.Position := 0;
  Label66.Caption := '0';
  ListBox1.Enabled := false;

  for i := 1 to 9 do
     begin
        TEdit(findcomponent('Edit' + inttostr(i))).Clear;
     end;

  for i := 29 to 47 do
     begin
        TLabel(findcomponent('Label' + inttostr(i))).Caption := '';
     end;
end;

procedure TForm1.P1Click(Sender: TObject);
begin
  PropertiesDialog(ListBox1.Items.Strings[ListBox1.ItemIndex]);
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  Label58.Caption := IntToStr(ScrollBar1.Position) + ' %';
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
  Label62.Caption := IntToStr(ScrollBar2.Position) + ' %';
end;

procedure TForm1.ScrollBar3Change(Sender: TObject);
begin
  Label63.Caption := IntToStr(ScrollBar3.Position) + ' %';
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open',
      PChar(ListBox1.Items.Strings[ListBox1.ItemIndex]), nil, nil, SW_SHOWNORMAL) ;
end;

procedure TForm1.S2Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open',
      PChar(ListBox1.Items.Strings[ListBox1.ItemIndex]), nil, nil, SW_SHOWNORMAL) ;
end;

procedure TForm1.ScrollBar4Change(Sender: TObject);
begin
  Label68.Caption := IntToStr(ScrollBar4.Position) + ' %';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  abort := true;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ReadOptions;
  CheckBox2.OnClick(sender);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  MessageDlg('Exif Meta batch v1.0' + chr(10) +
             'Copyright © hackbard' + chr(10) +
             'github.com | Release 2026',mtInformation, [mbOK], 0);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i : integer;
begin
  for i := 2 to 4 do
     begin
        TScrollBar(findcomponent('ScrollBar' + inttostr(i))).Position := 0;
     end;
  ScrollBar1.Position := 85;
  StatusBar1.SetFocus;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked = true then
    SpinEdit2.Enabled := true
  else
    SpinEdit2.Enabled := false;


  StatusBar1.SetFocus;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  StatusBar1.SetFocus;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  StatusBar1.SetFocus;
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  StatusBar1.SetFocus;
end;

procedure TForm1.CheckBox6Click(Sender: TObject);
begin
  StatusBar1.SetFocus;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  StatusBar1.SetFocus;
  ReadRemember;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  i : integer;
begin
  for i := 1 to 9 do
     begin
        TEdit(findcomponent('Edit' + inttostr(i))).Clear;
     end;
  StatusBar1.SetFocus;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  StatusBar1.SetFocus;
  WriteRemember;
end;

procedure TForm1.Edit9KeyPress(Sender: TObject; var Key: Char);
begin
  If not (Key in [#46, #48..#57, #8]) then
    Key := #0;
end;

procedure TForm1.CheckBox7Click(Sender: TObject);
var
  i : integer;
begin

  if CheckBox7.Checked = true then
  begin
    for i := 1 to 9 do
       begin
          TEdit(findcomponent('Edit' + IntToStr(i))).Enabled := false;
          TEdit(findcomponent('Edit' + IntToStr(i))).Clear;
       end;

    for i := 1 to 9 do
       begin
          TLabel(findcomponent('Label' + IntToStr(i))).Enabled := false;
       end;

    for i := 10 to 28 do
       begin
          TLabel(findcomponent('Label' + IntToStr(i))).Enabled := false;
       end;
  end else begin
    for i := 1 to 9 do
       begin
          TEdit(findcomponent('Edit' + IntToStr(i))).Enabled := true;
          TEdit(findcomponent('Edit' + IntToStr(i))).Clear;
       end;

    for i := 1 to 9 do
       begin
          TLabel(findcomponent('Label' + IntToStr(i))).Enabled := true;
       end;

    for i := 10 to 28 do
       begin
          TLabel(findcomponent('Label' + IntToStr(i))).Enabled := true;
       end;
  end;
  StatusBar1.SetFocus;
end;

procedure TForm1.CheckBox8Click(Sender: TObject);
var
  i : integer;
begin
  if CheckBox8.Checked = true then
  begin
    for i := 1 to 9 do
    begin
      TEdit(findcomponent('Edit' + IntToStr(i))).Text := UpperCase(TEdit(findcomponent('Edit' + IntToStr(i))).Text);
    end;
  end else begin
    for i := 1 to 9 do
    begin
      TEdit(findcomponent('Edit' + IntToStr(i))).Text := LowerCase(TEdit(findcomponent('Edit' + IntToStr(i))).Text);
    end;
  end;
  StatusBar1.SetFocus;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  StatusBar1.SetFocus;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Edit10.Text := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
  StatusBar1.SetFocus;
end;

end.
