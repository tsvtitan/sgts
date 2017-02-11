inherited SgtsRbkPointPassportEditForm: TSgtsRbkPointPassportEditForm
  Left = 450
  Top = 209
  Width = 354
  Height = 245
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1072#1089#1087#1086#1088#1090#1072' '#1090#1086#1095#1082#1080
  Constraints.MinHeight = 210
  Constraints.MinWidth = 310
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 180
    Width = 346
  end
  inherited ToolBar: TToolBar
    Width = 35
    Height = 141
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
    Width = 311
    Height = 141
    object LabelDescription: TLabel
      Left = 24
      Top = 67
      Width = 73
      Height = 13
      Alignment = taRightJustify
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081':'
      FocusControl = MemoDescription
    end
    object LabelPoint: TLabel
      Left = 64
      Top = 16
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = #1058#1086#1095#1082#1072':'
      FocusControl = EditPoint
    end
    object LabelDateCheckup: TLabel
      Left = 22
      Top = 42
      Width = 75
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1086#1089#1084#1086#1090#1088#1072':'
      FocusControl = DateTimePickerCheckup
    end
    object MemoDescription: TMemo
      Left = 105
      Top = 64
      Width = 198
      Height = 75
      TabOrder = 3
    end
    object EditPoint: TEdit
      Left = 105
      Top = 12
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonPoint: TButton
      Left = 282
      Top = 12
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1091#1102' '#1090#1086#1095#1082#1091
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object DateTimePickerCheckup: TDateTimePicker
      Left = 105
      Top = 38
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 2
    end
  end
  inherited PanelButton: TPanel
    Top = 141
    Width = 346
    DesignSize = (
      346
      39)
    inherited ButtonCancel: TButton
      Left = 265
    end
    inherited ButtonOk: TButton
      Left = 183
    end
  end
  inherited MainMenu: TMainMenu
    Left = 176
    Top = 48
  end
  inherited ImageList: TImageList
    Left = 216
    Top = 50
  end
end
