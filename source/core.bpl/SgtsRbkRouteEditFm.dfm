inherited SgtsRbkRouteEditForm: TSgtsRbkRouteEditForm
  Left = 565
  Top = 185
  Width = 356
  Height = 247
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1084#1072#1088#1096#1088#1091#1090#1072
  Constraints.MinHeight = 195
  Constraints.MinWidth = 325
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 182
    Width = 348
  end
  inherited ToolBar: TToolBar
    Height = 143
  end
  inherited PanelEdit: TPanel
    Width = 313
    Height = 143
    object LabelName: TLabel
      Left = 18
      Top = 11
      Width = 79
      Height = 13
      Alignment = taRightJustify
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
      FocusControl = EditName
    end
    object LabelDate: TLabel
      Left = 13
      Top = 106
      Width = 82
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1084#1072#1088#1096#1088#1091#1090#1072':'
      FocusControl = DateTimePicker
    end
    object LabelDescription: TLabel
      Left = 43
      Top = 35
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
      FocusControl = MemoDescription
    end
    object EditName: TEdit
      Left = 104
      Top = 7
      Width = 199
      Height = 21
      TabOrder = 0
      Text = #1053#1086#1074#1099#1081' '#1084#1072#1088#1096#1088#1091#1090
    end
    object DateTimePicker: TDateTimePicker
      Left = 104
      Top = 102
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 2
    end
    object MemoDescription: TMemo
      Left = 104
      Top = 32
      Width = 199
      Height = 66
      TabOrder = 1
    end
    object CheckBoxIsActive: TCheckBox
      Left = 104
      Top = 127
      Width = 97
      Height = 17
      Caption = #1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  inherited PanelButton: TPanel
    Top = 143
    Width = 348
    inherited ButtonCancel: TButton
      Left = 269
    end
    inherited ButtonOk: TButton
      Left = 187
    end
  end
  inherited MainMenu: TMainMenu
    Left = 152
    Top = 40
  end
  inherited ImageList: TImageList
    Left = 184
    Top = 42
  end
end
