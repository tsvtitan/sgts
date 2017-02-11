inherited SgtsExportSqlForm: TSgtsExportSqlForm
  Left = 435
  Top = 250
  Caption = #1069#1082#1089#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 273
  ClientWidth = 392
  Constraints.MinHeight = 300
  Constraints.MinWidth = 400
  OnCloseQuery = FormCloseQuery
  ExplicitLeft = 435
  ExplicitTop = 250
  ExplicitWidth = 400
  ExplicitHeight = 300
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 392
    Height = 66
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object LabelFileDesc: TLabel
      Left = 23
      Top = 13
      Width = 80
      Height = 13
      Alignment = taRightJustify
      Caption = #1060#1072#1081#1083' '#1086#1087#1080#1089#1072#1085#1080#1081':'
      FocusControl = ButtonFileDesc
    end
    object LabelFileResult: TLabel
      Left = 11
      Top = 40
      Width = 92
      Height = 13
      Alignment = taRightJustify
      Caption = #1060#1072#1081#1083' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072':'
      FocusControl = ButtonFileResult
    end
    object EditFileDesc: TEdit
      Left = 110
      Top = 10
      Width = 231
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonFileDesc: TButton
      Left = 347
      Top = 10
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1092#1072#1081#1083' '#1086#1087#1080#1089#1072#1085#1080#1081
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = ButtonFileDescClick
    end
    object EditFileResult: TEdit
      Left = 110
      Top = 37
      Width = 231
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object ButtonFileResult: TButton
      Left = 347
      Top = 37
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1092#1072#1081#1083' '#1088#1077#1079#1091#1083#1100#1090#1072#1090
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = ButtonFileResultClick
    end
  end
  object PanelGrid: TPanel
    Left = 0
    Top = 66
    Width = 392
    Height = 168
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    TabOrder = 1
    object GroupBoxOption: TGroupBox
      Left = 3
      Top = 3
      Width = 386
      Height = 162
      Align = alClient
      Caption = ' '#1053#1072#1089#1090#1088#1086#1081#1082#1072' '
      TabOrder = 0
      object PanelOption: TPanel
        Left = 2
        Top = 15
        Width = 382
        Height = 145
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        TabOrder = 0
      end
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 234
    Width = 392
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      392
      39)
    object ButtonExport: TButton
      Left = 204
      Top = 8
      Width = 100
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1069#1082#1089#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Default = True
      TabOrder = 0
      OnClick = ButtonExportClick
    end
    object ButtonClose: TButton
      Left = 311
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = ButtonCloseClick
    end
  end
  object OpenDialog: TOpenDialog
    Filter = #1060#1072#1081#1083#1099' '#1086#1087#1080#1089#1072#1085#1080#1081' (*.des)|*.des|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Left = 53
    Top = 124
  end
  object DataSource: TDataSource
    Left = 245
    Top = 124
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.rsl'
    Filter = #1060#1072#1081#1083#1099' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072' (*.rsl)|*.rsl|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Left = 141
    Top = 124
  end
  object PopupMenu: TPopupMenu
    Left = 320
    Top = 132
    object MenuItemCheckAll: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1075#1072#1083#1086#1095#1082#1086#1081' '#1074#1089#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
      OnClick = MenuItemCheckAllClick
    end
    object MenuItemUncheckAll: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1089#1077
      Hint = #1059#1073#1088#1072#1090#1100' '#1075#1072#1083#1086#1095#1082#1080' '#1085#1072' '#1074#1089#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1072#1093
      OnClick = MenuItemUncheckAllClick
    end
  end
end
