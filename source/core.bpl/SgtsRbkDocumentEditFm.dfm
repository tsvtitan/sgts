inherited SgtsRbkDocumentEditForm: TSgtsRbkDocumentEditForm
  Left = 426
  Top = 226
  Width = 377
  Height = 259
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
  Constraints.MinHeight = 240
  Constraints.MinWidth = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 194
    Width = 369
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
    Width = 334
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
    object LabelFileName: TLabel
      Left = 3
      Top = 136
      Width = 89
      Height = 13
      Alignment = taRightJustify
      Caption = #1060#1072#1081#1083' '#1076#1086#1082#1091#1084#1077#1085#1090#1072':'
      FocusControl = EditFileName
    end
    object EditName: TEdit
      Left = 100
      Top = 12
      Width = 221
      Height = 21
      TabOrder = 0
      Text = #1053#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
    end
    object MemoNote: TMemo
      Left = 100
      Top = 38
      Width = 221
      Height = 89
      TabOrder = 1
    end
    object EditFileName: TEdit
      Left = 100
      Top = 132
      Width = 194
      Height = 21
      TabOrder = 2
    end
    object ButtonFileName: TButton
      Left = 300
      Top = 132
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1092#1072#1081#1083' '#1095#1077#1088#1090#1077#1078#1072
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
  end
  inherited PanelButton: TPanel
    Top = 155
    Width = 369
    inherited ButtonCancel: TButton
      Left = 288
    end
    inherited ButtonOk: TButton
      Left = 206
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
