object SgtsBaseFieldNamesForm: TSgtsBaseFieldNamesForm
  Left = 560
  Top = 338
  BorderStyle = bsDialog
  Caption = #1055#1086#1083#1103
  ClientHeight = 281
  ClientWidth = 365
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PanelButton: TPanel
    Left = 0
    Top = 242
    Width = 365
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      365
      39)
    object ButtonCancel: TButton
      Left = 283
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = ButtonCancelClick
    end
    object ButtonOk: TButton
      Left = 201
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1050
      Default = True
      TabOrder = 0
      OnClick = ButtonOkClick
    end
  end
  object PanelGrid: TPanel
    Left = 0
    Top = 0
    Width = 365
    Height = 242
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    TabOrder = 0
    object Bevel: TBevel
      Left = 3
      Top = 209
      Width = 359
      Height = 5
      Align = alBottom
      Shape = bsSpacer
    end
    object GridPattern: TDBGrid
      Left = 3
      Top = 3
      Width = 359
      Height = 206
      Align = alClient
      DataSource = DataSource
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object DBNavigator: TDBNavigator
      Left = 3
      Top = 214
      Width = 359
      Height = 25
      DataSource = DataSource
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
      Align = alBottom
      Flat = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
  end
  object DataSource: TDataSource
    Left = 90
    Top = 67
  end
end
