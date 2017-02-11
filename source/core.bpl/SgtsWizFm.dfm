inherited SgtsWizForm: TSgtsWizForm
  Left = 384
  Top = 168
  Anchors = [akRight, akBottom]
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsDialog
  Caption = #1055#1086#1084#1086#1097#1085#1080#1082
  ClientHeight = 361
  ClientWidth = 502
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  DesignSize = (
    502
    361)
  PixelsPerInch = 96
  TextHeight = 13
  object BevelBottom: TBevel
    Left = 0
    Top = 318
    Width = 502
    Height = 2
    Align = alBottom
    Shape = bsBottomLine
  end
  object BevelTop: TBevel
    Left = 0
    Top = 46
    Width = 502
    Height = 2
    Align = alTop
    Shape = bsBottomLine
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 320
    Width = 502
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      502
      41)
    object ButtonPrior: TButton
      Left = 256
      Top = 9
      Width = 75
      Height = 23
      Anchors = [akRight, akBottom]
      Caption = 'ButtonPrior'
      TabOrder = 0
      OnClick = ButtonPriorClick
    end
    object ButtonNext: TButton
      Left = 331
      Top = 9
      Width = 75
      Height = 23
      Anchors = [akRight, akBottom]
      Caption = 'ButtonNext'
      Default = True
      TabOrder = 1
      OnClick = ButtonNextClick
    end
    object ButtonCancel: TButton
      Left = 419
      Top = 9
      Width = 75
      Height = 23
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'ButtonCancel'
      TabOrder = 2
      OnClick = ButtonCancelClick
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 502
    Height = 46
    Align = alTop
    BevelOuter = bvNone
    Color = clWindow
    TabOrder = 0
    object ImageLogo: TImage
      Left = 463
      Top = 7
      Width = 32
      Height = 32
    end
    object LabelCaption: TLabel
      Left = 8
      Top = 5
      Width = 75
      Height = 13
      Caption = 'LabelCaption'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelHint: TLabel
      Left = 24
      Top = 24
      Width = 45
      Height = 13
      Caption = 'LabelHint'
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 48
    Width = 502
    Height = 270
    Align = alClient
    Style = tsButtons
    TabOrder = 1
  end
  object LabelCompany: TStaticText
    Left = 8
    Top = 312
    Width = 74
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'LabelCompany'
    TabOrder = 3
  end
end
