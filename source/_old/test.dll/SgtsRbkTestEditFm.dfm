inherited SgtsRbkTestEditForm: TSgtsRbkTestEditForm
  Left = 426
  Top = 226
  Caption = #1058#1077#1089#1090#1086#1074#1072#1103' '#1092#1086#1088#1084#1072' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
  ClientHeight = 193
  ClientWidth = 318
  Constraints.MinHeight = 240
  Constraints.MinWidth = 320
  ExplicitWidth = 326
  ExplicitHeight = 247
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 174
    Width = 318
    ExplicitTop = 174
    ExplicitWidth = 318
  end
  inherited ToolBar: TToolBar
    Height = 135
    ExplicitHeight = 135
  end
  inherited PanelEdit: TPanel
    Width = 283
    Height = 135
    ExplicitWidth = 283
    ExplicitHeight = 135
    object LabelName: TLabel
      Left = 0
      Top = 24
      Width = 77
      Height = 13
      Alignment = taRightJustify
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
      FocusControl = EditName
    end
    object LabelNote: TLabel
      Left = 29
      Top = 43
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
      FocusControl = MemoNote
    end
    object EditName: TEdit
      Left = 90
      Top = 12
      Width = 184
      Height = 21
      TabOrder = 0
      Text = #1053#1086#1074#1099#1081' '#1091#1088#1086#1074#1077#1085#1100
    end
    object MemoNote: TMemo
      Left = 90
      Top = 40
      Width = 184
      Height = 89
      TabOrder = 1
    end
  end
  inherited PanelButton: TPanel
    Top = 135
    Width = 318
    ExplicitTop = 135
    ExplicitWidth = 318
    inherited ButtonCancel: TButton
      Left = 237
      ExplicitLeft = 237
    end
    inherited ButtonOk: TButton
      Left = 155
      ExplicitLeft = 155
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
