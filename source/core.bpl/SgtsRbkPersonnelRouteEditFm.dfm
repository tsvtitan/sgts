inherited SgtsRbkPersonnelRouteEditForm: TSgtsRbkPersonnelRouteEditForm
  Left = 471
  Top = 308
  Width = 344
  Height = 227
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1084#1072#1088#1096#1088#1091#1090#1072' '#1087#1077#1088#1089#1086#1085#1099
  Constraints.MinHeight = 160
  Constraints.MinWidth = 300
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 162
    Width = 336
  end
  inherited ToolBar: TToolBar
    Width = 35
    Height = 123
    inherited ToolButtonOk: TToolButton
      Wrap = True
    end
    inherited ToolButtonCancel: TToolButton
      Left = 0
      Top = 30
    end
    inherited ToolButtonDefault: TToolButton
      Top = 60
    end
  end
  inherited PanelEdit: TPanel
    Left = 35
    Width = 301
    Height = 123
    object LabelRoute: TLabel
      Left = 39
      Top = 23
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Caption = #1052#1072#1088#1096#1088#1091#1090':'
      FocusControl = EditRoute
    end
    object LabelPersonnel: TLabel
      Left = 17
      Top = 50
      Width = 70
      Height = 13
      Alignment = taRightJustify
      Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100':'
      FocusControl = EditPersonnel
      WordWrap = True
    end
    object LabelDeputy: TLabel
      Left = 17
      Top = 77
      Width = 70
      Height = 13
      Alignment = taRightJustify
      Caption = #1047#1072#1084#1077#1089#1090#1080#1090#1077#1083#1100':'
      FocusControl = EditDeputy
      WordWrap = True
    end
    object LabelDatePurpose: TLabel
      Left = 69
      Top = 104
      Width = 91
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103':'
      FocusControl = DateTimePickerPurpose
    end
    object EditRoute: TEdit
      Left = 97
      Top = 19
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonRoute: TButton
      Left = 274
      Top = 19
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1084#1072#1088#1096#1088#1091#1090
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object EditPersonnel: TEdit
      Left = 97
      Top = 46
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object ButtonPersonnel: TButton
      Left = 274
      Top = 46
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object EditDeputy: TEdit
      Left = 97
      Top = 73
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 4
    end
    object ButtonDeputy: TButton
      Left = 274
      Top = 73
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1079#1072#1084#1077#1089#1090#1080#1090#1077#1083#1103
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
    object DateTimePickerPurpose: TDateTimePicker
      Left = 169
      Top = 100
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 6
    end
  end
  inherited PanelButton: TPanel
    Top = 123
    Width = 336
    inherited ButtonCancel: TButton
      Left = 252
    end
    inherited ButtonOk: TButton
      Left = 170
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
