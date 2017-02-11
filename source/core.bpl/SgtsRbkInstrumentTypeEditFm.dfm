inherited SgtsRbkInstrumentTypeEditForm: TSgtsRbkInstrumentTypeEditForm
  Left = 426
  Top = 226
  Width = 327
  Height = 240
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1080#1087' '#1087#1088#1080#1073#1086#1088#1072
  Constraints.MinHeight = 240
  Constraints.MinWidth = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 175
    Width = 319
  end
  inherited ToolBar: TToolBar
    Height = 136
  end
  inherited PanelEdit: TPanel
    Width = 284
    Height = 136
    object LabelName: TLabel
      Left = 4
      Top = 16
      Width = 79
      Height = 13
      Alignment = taRightJustify
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
      FocusControl = EditName
    end
    object LabelNote: TLabel
      Left = 30
      Top = 43
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
      FocusControl = MemoNote
    end
    object EditName: TEdit
      Left = 91
      Top = 12
      Width = 184
      Height = 21
      TabOrder = 0
      Text = #1053#1086#1074#1099#1081' '#1090#1080#1087' '#1087#1088#1080#1073#1086#1088#1072
    end
    object MemoNote: TMemo
      Left = 91
      Top = 40
      Width = 184
      Height = 89
      TabOrder = 1
    end
  end
  inherited PanelButton: TPanel
    Top = 136
    Width = 319
    inherited ButtonCancel: TButton
      Left = 238
    end
    inherited ButtonOk: TButton
      Left = 156
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
