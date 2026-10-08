object Form1: TForm1
  Left = 309
  Top = 145
  Width = 892
  Height = 661
  Caption = 'EXIF Meta batch'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 603
    Width = 876
    Height = 19
    Panels = <
      item
        Text = 'Count :'
        Width = 50
      end
      item
        Text = '0'
        Width = 50
      end
      item
        Text = 'Name :'
        Width = 50
      end
      item
        Width = 200
      end
      item
        Text = 'Size :'
        Width = 40
      end
      item
        Text = '0.0 kb'
        Width = 120
      end
      item
        Text = 'Dimension :'
        Width = 75
      end
      item
        Text = '0x0'
        Width = 100
      end
      item
        Text = 'ThumbNail :'
        Width = 75
      end
      item
        Width = 50
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 876
    Height = 57
    Align = alTop
    TabOrder = 1
    DesignSize = (
      876
      57)
    object Label70: TLabel
      Left = 24
      Top = 8
      Width = 211
      Height = 39
      Caption = 'Exif Meta batch'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Impact'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label71: TLabel
      Left = 240
      Top = 29
      Width = 353
      Height = 13
      Caption = 
        'Load multiple JPEG files and generate "EXIF ??" information for ' +
        'all of them.'
    end
    object SpeedButton1: TSpeedButton
      Left = 840
      Top = 24
      Width = 23
      Height = 22
      Anchors = [akTop, akRight]
      Caption = 'i'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton1Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 57
    Width = 876
    Height = 546
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 257
      Top = 0
      Width = 5
      Height = 546
    end
    object PageControl1: TPageControl
      Left = 262
      Top = 0
      Width = 614
      Height = 546
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      TabStop = False
      object TabSheet1: TTabSheet
        Caption = 'Meta'
        object Label1: TLabel
          Left = 32
          Top = 49
          Width = 59
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Description :'
          ParentBiDiMode = False
        end
        object Label4: TLabel
          Left = 48
          Top = 97
          Width = 42
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Camera :'
          ParentBiDiMode = False
        end
        object Label5: TLabel
          Left = 28
          Top = 73
          Width = 62
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Copyright '#169' :'
          ParentBiDiMode = False
        end
        object Label6: TLabel
          Left = 17
          Top = 121
          Width = 74
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Camera Model :'
          ParentBiDiMode = False
        end
        object Label7: TLabel
          Left = 59
          Top = 145
          Width = 31
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Autor :'
          ParentBiDiMode = False
        end
        object Label8: TLabel
          Left = 42
          Top = 169
          Width = 48
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Software :'
          ParentBiDiMode = False
        end
        object Label9: TLabel
          Left = 40
          Top = 193
          Width = 50
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Comment :'
          ParentBiDiMode = False
        end
        object Label3: TLabel
          Left = 29
          Top = 217
          Width = 61
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Exif Version :'
          ParentBiDiMode = False
        end
        object Label2: TLabel
          Left = 20
          Top = 267
          Width = 69
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Created Date :'
          ParentBiDiMode = False
        end
        object Label10: TLabel
          Left = 330
          Top = 48
          Width = 93
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Original Date Time :'
          ParentBiDiMode = False
        end
        object Label11: TLabel
          Left = 328
          Top = 64
          Width = 95
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Created Date Time :'
          ParentBiDiMode = False
        end
        object Label12: TLabel
          Left = 366
          Top = 80
          Width = 57
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Orientation :'
          ParentBiDiMode = False
        end
        object Label13: TLabel
          Left = 373
          Top = 96
          Width = 50
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Exposure :'
          ParentBiDiMode = False
        end
        object Label14: TLabel
          Left = 330
          Top = 112
          Width = 92
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Exposure Program :'
          ParentBiDiMode = False
        end
        object Label15: TLabel
          Left = 380
          Top = 128
          Width = 42
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'F-Stops :'
          ParentBiDiMode = False
        end
        object Label16: TLabel
          Left = 347
          Top = 200
          Width = 74
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Shutter Speed :'
          ParentBiDiMode = False
        end
        object Label17: TLabel
          Left = 375
          Top = 216
          Width = 46
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Aperture :'
          ParentBiDiMode = False
        end
        object Label18: TLabel
          Left = 352
          Top = 232
          Width = 69
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Max Aperture :'
          ParentBiDiMode = False
        end
        object Label19: TLabel
          Left = 333
          Top = 248
          Width = 88
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Compressed BPP :'
          ParentBiDiMode = False
        end
        object Label20: TLabel
          Left = 366
          Top = 144
          Width = 56
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'ISO speed :'
          ParentBiDiMode = False
        end
        object Label21: TLabel
          Left = 377
          Top = 264
          Width = 44
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Pixel (X) :'
          ParentBiDiMode = False
        end
        object Label22: TLabel
          Left = 377
          Top = 280
          Width = 44
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Pixel (Y) :'
          ParentBiDiMode = False
        end
        object Label23: TLabel
          Left = 352
          Top = 296
          Width = 69
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'X-Resolution: :'
          ParentBiDiMode = False
        end
        object Label24: TLabel
          Left = 355
          Top = 312
          Width = 66
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Y-Resolution :'
          ParentBiDiMode = False
        end
        object Label25: TLabel
          Left = 344
          Top = 328
          Width = 77
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Metering Mode :'
          ParentBiDiMode = False
        end
        object Label26: TLabel
          Left = 335
          Top = 344
          Width = 86
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Metering Method :'
          ParentBiDiMode = False
        end
        object Label27: TLabel
          Left = 355
          Top = 360
          Width = 66
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Light Source :'
          ParentBiDiMode = False
        end
        object Label28: TLabel
          Left = 390
          Top = 376
          Width = 31
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Flash :'
          ParentBiDiMode = False
        end
        object Label29: TLabel
          Left = 432
          Top = 48
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label30: TLabel
          Left = 432
          Top = 64
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label31: TLabel
          Left = 432
          Top = 80
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label32: TLabel
          Left = 432
          Top = 96
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label33: TLabel
          Left = 432
          Top = 112
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label34: TLabel
          Left = 432
          Top = 128
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label35: TLabel
          Left = 432
          Top = 200
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label36: TLabel
          Left = 432
          Top = 216
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label37: TLabel
          Left = 432
          Top = 232
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label38: TLabel
          Left = 432
          Top = 248
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label39: TLabel
          Left = 432
          Top = 144
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label40: TLabel
          Left = 432
          Top = 264
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label41: TLabel
          Left = 432
          Top = 280
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label42: TLabel
          Left = 432
          Top = 296
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label43: TLabel
          Left = 432
          Top = 312
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label44: TLabel
          Left = 432
          Top = 328
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label45: TLabel
          Left = 432
          Top = 344
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label46: TLabel
          Left = 432
          Top = 360
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label47: TLabel
          Left = 432
          Top = 376
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label48: TLabel
          Left = 48
          Top = 320
          Width = 39
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Picture :'
          ParentBiDiMode = False
        end
        object Bevel1: TBevel
          Left = 96
          Top = 320
          Width = 201
          Height = 153
          Shape = bsFrame
        end
        object Label49: TLabel
          Left = 96
          Top = 24
          Width = 76
          Height = 13
          Caption = 'Owner Data :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label50: TLabel
          Left = 328
          Top = 24
          Width = 78
          Height = 13
          Caption = 'Camera Data:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label51: TLabel
          Left = 40
          Top = 488
          Width = 47
          Height = 13
          Caption = 'Progress :'
        end
        object Label52: TLabel
          Left = 328
          Top = 176
          Width = 248
          Height = 13
          Caption = 'These entries will be removed automatically'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Image1: TImage
          Left = 101
          Top = 326
          Width = 189
          Height = 140
          Center = True
          Stretch = True
        end
        object Label65: TLabel
          Left = 184
          Top = 392
          Width = 23
          Height = 13
          Caption = 'View'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clSilver
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label66: TLabel
          Left = 312
          Top = 488
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label74: TLabel
          Left = 23
          Top = 242
          Width = 67
          Height = 13
          BiDiMode = bdRightToLeft
          Caption = 'Original Date :'
          ParentBiDiMode = False
        end
        object Edit1: TEdit
          Left = 96
          Top = 48
          Width = 201
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 0
        end
        object Edit2: TEdit
          Left = 96
          Top = 96
          Width = 201
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 1
        end
        object Edit3: TEdit
          Left = 96
          Top = 72
          Width = 201
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 2
        end
        object Edit4: TEdit
          Left = 96
          Top = 120
          Width = 201
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 3
        end
        object Edit5: TEdit
          Left = 96
          Top = 144
          Width = 201
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 4
        end
        object Edit6: TEdit
          Left = 96
          Top = 168
          Width = 201
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 5
        end
        object Edit7: TEdit
          Left = 96
          Top = 192
          Width = 201
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 6
        end
        object Edit8: TEdit
          Left = 96
          Top = 216
          Width = 201
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 7
        end
        object Edit9: TEdit
          Left = 96
          Top = 264
          Width = 201
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 8
          OnKeyPress = Edit9KeyPress
        end
        object ProgressBar1: TProgressBar
          Left = 96
          Top = 488
          Width = 201
          Height = 17
          TabOrder = 9
        end
        object CheckBox1: TCheckBox
          Left = 432
          Top = 24
          Width = 107
          Height = 14
          Caption = 'Remove data tags'
          TabOrder = 10
          OnClick = CheckBox1Click
        end
        object Button5: TButton
          Left = 217
          Top = 21
          Width = 40
          Height = 20
          Hint = 'Reload your own data.'
          Caption = 'reload'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          TabStop = False
          OnClick = Button5Click
        end
        object Button6: TButton
          Left = 258
          Top = 21
          Width = 40
          Height = 20
          Hint = 'Clear Exif ?? data..'
          Caption = 'clear'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 12
          TabStop = False
          OnClick = Button6Click
        end
        object Button7: TButton
          Left = 176
          Top = 21
          Width = 40
          Height = 20
          Hint = 'Save tags to options'
          Caption = 'save'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 13
          TabStop = False
          OnClick = Button7Click
        end
        object CheckBox7: TCheckBox
          Left = 96
          Top = 288
          Width = 85
          Height = 17
          Caption = 'Remove tags'
          TabOrder = 14
          OnClick = CheckBox7Click
        end
        object CheckBox8: TCheckBox
          Left = 200
          Top = 288
          Width = 75
          Height = 17
          Caption = 'Upper case'
          TabOrder = 15
          OnClick = CheckBox8Click
        end
        object Edit10: TEdit
          Left = 96
          Top = 240
          Width = 153
          Height = 19
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 16
        end
        object Button8: TButton
          Left = 256
          Top = 240
          Width = 41
          Height = 20
          Hint = 'Image modification date'
          Caption = 'Today'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 17
          OnClick = Button8Click
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Options'
        ImageIndex = 1
        object Label54: TLabel
          Left = 77
          Top = 52
          Width = 38
          Height = 13
          Caption = 'Format :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label55: TLabel
          Left = 29
          Top = 116
          Width = 85
          Height = 13
          Caption = 'Thumb Max Size :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label56: TLabel
          Left = 72
          Top = 84
          Width = 42
          Height = 13
          Caption = 'Pixel bit :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label57: TLabel
          Left = 29
          Top = 192
          Width = 85
          Height = 13
          Caption = 'Compress quality :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label58: TLabel
          Left = 352
          Top = 192
          Width = 38
          Height = 13
          Caption = 'Label58'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label60: TLabel
          Left = 59
          Top = 224
          Width = 55
          Height = 13
          Caption = 'Brightness :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label61: TLabel
          Left = 69
          Top = 256
          Width = 45
          Height = 13
          Caption = 'Contrast :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label62: TLabel
          Left = 352
          Top = 224
          Width = 17
          Height = 13
          Caption = '0 %'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label63: TLabel
          Left = 352
          Top = 256
          Width = 17
          Height = 13
          Caption = '0 %'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label64: TLabel
          Left = 221
          Top = 115
          Width = 25
          Height = 13
          Caption = 'bytes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label67: TLabel
          Left = 80
          Top = 288
          Width = 34
          Height = 13
          Caption = 'Sharp :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label68: TLabel
          Left = 352
          Top = 288
          Width = 17
          Height = 13
          Caption = '0 %'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label72: TLabel
          Left = 120
          Top = 24
          Width = 107
          Height = 16
          Caption = 'Format settings'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label73: TLabel
          Left = 120
          Top = 168
          Width = 107
          Height = 16
          Caption = 'Picture settings'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ComboBox1: TComboBox
          Left = 120
          Top = 48
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          TabStop = False
          Text = 'JPG'
          Items.Strings = (
            'JPG'
            'JPEG'
            'JFIF')
        end
        object SpinEdit1: TSpinEdit
          Left = 120
          Top = 112
          Width = 97
          Height = 22
          TabStop = False
          MaxLength = 4
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 200
        end
        object ComboBox2: TComboBox
          Left = 120
          Top = 80
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 2
          TabOrder = 2
          TabStop = False
          Text = '32'
          Items.Strings = (
            '8'
            '24'
            '32'
            'Device (Camera)'
            'Custom')
        end
        object ScrollBar1: TScrollBar
          Left = 120
          Top = 192
          Width = 217
          Height = 17
          Min = 1
          PageSize = 0
          Position = 1
          TabOrder = 3
          TabStop = False
          OnChange = ScrollBar1Change
        end
        object GroupBox1: TGroupBox
          Left = 120
          Top = 368
          Width = 217
          Height = 105
          Caption = ' Scale Jpeg '
          TabOrder = 4
          object Label59: TLabel
            Left = 32
            Top = 62
            Width = 54
            Height = 13
            Caption = 'Scale size :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label69: TLabel
            Left = 160
            Top = 64
            Width = 39
            Height = 13
            Caption = 'px width'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object SpinEdit2: TSpinEdit
            Left = 96
            Top = 59
            Width = 57
            Height = 22
            TabStop = False
            MaxValue = 2000
            MinValue = 1
            ParentShowHint = False
            ShowHint = False
            TabOrder = 0
            Value = 300
          end
          object CheckBox2: TCheckBox
            Left = 16
            Top = 24
            Width = 62
            Height = 17
            TabStop = False
            Caption = 'Activate'
            ParentShowHint = False
            ShowHint = False
            TabOrder = 1
            OnClick = CheckBox2Click
          end
        end
        object CheckBox3: TCheckBox
          Left = 448
          Top = 192
          Width = 70
          Height = 17
          TabStop = False
          Caption = 'Grayscale'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 5
          OnClick = CheckBox3Click
        end
        object ScrollBar2: TScrollBar
          Left = 120
          Top = 224
          Width = 217
          Height = 17
          Min = -100
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBar2Change
        end
        object ScrollBar3: TScrollBar
          Left = 120
          Top = 256
          Width = 217
          Height = 17
          Min = -100
          PageSize = 0
          TabOrder = 7
          OnChange = ScrollBar3Change
        end
        object ScrollBar4: TScrollBar
          Left = 120
          Top = 288
          Width = 217
          Height = 17
          Min = -100
          PageSize = 0
          TabOrder = 8
          OnChange = ScrollBar4Change
        end
        object CheckBox4: TCheckBox
          Left = 448
          Top = 216
          Width = 58
          Height = 17
          TabStop = False
          Caption = 'Negativ'
          TabOrder = 9
          OnClick = CheckBox4Click
        end
        object CheckBox5: TCheckBox
          Left = 448
          Top = 240
          Width = 97
          Height = 17
          Caption = 'Mirror Vertival'
          TabOrder = 10
          OnClick = CheckBox5Click
        end
        object CheckBox6: TCheckBox
          Left = 448
          Top = 264
          Width = 100
          Height = 17
          Caption = 'Mirror Horizontall'
          TabOrder = 11
          OnClick = CheckBox6Click
        end
        object Button3: TButton
          Left = 120
          Top = 320
          Width = 75
          Height = 20
          Caption = 'Reset'
          TabOrder = 12
          TabStop = False
          OnClick = Button3Click
        end
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 257
      Height = 546
      Align = alLeft
      TabOrder = 1
      DesignSize = (
        257
        546)
      object Label53: TLabel
        Left = 16
        Top = 8
        Width = 182
        Height = 13
        Caption = 'Picture files : JPEG - JPG - JFIF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Button2: TButton
        Left = 8
        Top = 502
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Open'
        TabOrder = 0
        TabStop = False
        OnClick = Button2Click
      end
      object ListBox1: TListBox
        Left = 8
        Top = 24
        Width = 241
        Height = 455
        TabStop = False
        Anchors = [akLeft, akTop, akRight, akBottom]
        Enabled = False
        ItemHeight = 13
        MultiSelect = True
        PopupMenu = PopupMenu1
        TabOrder = 1
        OnClick = ListBox1Click
        OnDblClick = ListBox1DblClick
        OnDrawItem = ListBox1DrawItem
      end
      object Button4: TButton
        Left = 169
        Top = 502
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Batch'
        TabOrder = 2
        TabStop = False
        OnClick = Button4Click
      end
      object Button1: TButton
        Left = 88
        Top = 502
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Abort'
        TabOrder = 3
        TabStop = False
        OnClick = Button1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Jpeg (*.jpg; *.jpeg; *,jfif)|*.jpg; *.jpeg; *.jfif'
    Left = 24
    Top = 128
  end
  object PopupMenu1: TPopupMenu
    Left = 56
    Top = 128
    object S1: TMenuItem
      Caption = 'Save'
      OnClick = S1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object R1: TMenuItem
      Caption = 'Remove'
      OnClick = R1Click
    end
    object C1: TMenuItem
      Caption = 'Clear'
      OnClick = C1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object P1: TMenuItem
      Caption = 'Properties'
      OnClick = P1Click
    end
    object S2: TMenuItem
      Caption = 'Show'
      OnClick = S2Click
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Jpeg (*.jpg)|*.jpg'
    Left = 88
    Top = 128
  end
end
