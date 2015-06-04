object Form1: TForm1
  Left = 211
  Top = 128
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Beatnik'
  ClientHeight = 450
  ClientWidth = 436
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 19
    Width = 43
    Height = 13
    Caption = 'Input file:'
  end
  object Label2: TLabel
    Left = 16
    Top = 59
    Width = 54
    Height = 13
    Caption = 'Output File:'
  end
  object Label3: TLabel
    Left = 16
    Top = 161
    Width = 38
    Height = 13
    Caption = 'Header:'
  end
  object Label4: TLabel
    Left = 72
    Top = 94
    Width = 89
    Height = 13
    Caption = 'Channel separator:'
  end
  object Edit1: TEdit
    Left = 72
    Top = 16
    Width = 265
    Height = 21
    TabOrder = 0
  end
  object InputFileButton: TButton
    Left = 350
    Top = 14
    Width = 65
    Height = 25
    Hint = 'Choose input file'
    Caption = 'Choose...'
    TabOrder = 1
    OnClick = InputFileButtonClick
  end
  object Edit2: TEdit
    Left = 72
    Top = 56
    Width = 265
    Height = 21
    TabOrder = 2
  end
  object OutputFileButton: TButton
    Left = 350
    Top = 54
    Width = 65
    Height = 25
    Hint = 'Choose output file'
    Caption = 'Choose...'
    TabOrder = 3
    OnClick = OutputFileButtonClick
  end
  object ConvertButton: TButton
    Left = 260
    Top = 406
    Width = 73
    Height = 33
    Hint = 'Click to convert'
    Caption = 'Convert'
    TabOrder = 4
    OnClick = ConvertButtonClick
  end
  object CancelButton: TButton
    Left = 340
    Top = 406
    Width = 75
    Height = 33
    Hint = 'Click to exit'
    Caption = 'Cancel'
    TabOrder = 5
    OnClick = CancelButtonClick
  end
  object Memo1: TMemo
    Left = 16
    Top = 185
    Width = 401
    Height = 209
    Enabled = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object ProgressBar1: TProgressBar
    Left = 16
    Top = 128
    Width = 401
    Height = 17
    Smooth = True
    TabOrder = 7
  end
  object RadioButton1: TRadioButton
    Left = 184
    Top = 93
    Width = 73
    Height = 17
    Caption = 'Comma'
    Checked = True
    TabOrder = 8
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 251
    Top = 92
    Width = 57
    Height = 17
    Caption = 'Tab'
    TabOrder = 9
    OnClick = RadioButton2Click
  end
  object OpenDialog1: TOpenDialog
    Left = 328
    Top = 152
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'csv'
    Left = 360
    Top = 152
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 392
    Top = 152
  end
end
