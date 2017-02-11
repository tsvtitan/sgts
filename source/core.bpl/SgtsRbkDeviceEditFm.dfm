inherited SgtsRbkDeviceEditForm: TSgtsRbkDeviceEditForm
  Left = 426
  Top = 226
  Width = 337
  Height = 259
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
  Constraints.MinHeight = 240
  Constraints.MinWidth = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 194
    Width = 329
  end
  inherited ToolBar: TToolBar
    Width = 35
    Height = 155
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
    Width = 294
    Height = 155
    object LabelName: TLabel
      Left = 13
      Top = 16
      Width = 79
      Height = 13
      Alignment = taRightJustify
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
      FocusControl = EditName
    end
    object LabelNote: TLabel
      Left = 39
      Top = 41
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
      FocusControl = MemoNote
    end
    object LabelDateEnter: TLabel
      Left = 28
      Top = 137
      Width = 62
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1074#1074#1086#1076#1072':'
      FocusControl = DateTimePicker
    end
    object EditName: TEdit
      Left = 100
      Top = 12
      Width = 184
      Height = 21
      TabOrder = 0
      Text = #1053#1086#1074#1086#1077' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1086
    end
    object MemoNote: TMemo
      Left = 100
      Top = 38
      Width = 184
      Height = 89
      TabOrder = 1
    end
    object DateTimePicker: TDateTimePicker
      Left = 100
      Top = 132
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 2
    end
  end
  inherited PanelButton: TPanel
    Top = 155
    Width = 329
    inherited ButtonCancel: TButton
      Left = 248
    end
    inherited ButtonOk: TButton
      Left = 166
    end
  end
  inherited MainMenu: TMainMenu
    Left = 176
    Top = 40
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
