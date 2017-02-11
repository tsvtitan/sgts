inherited SgtsRbkParamInstrumentEditForm: TSgtsRbkParamInstrumentEditForm
  Left = 494
  Top = 196
  Width = 332
  Height = 200
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1088#1080#1073#1086#1088#1086#1074' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
  Constraints.MinHeight = 160
  Constraints.MinWidth = 300
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 135
    Width = 324
  end
  inherited ToolBar: TToolBar
    Height = 96
  end
  inherited PanelEdit: TPanel
    Width = 289
    Height = 96
    object LabelInstrument: TLabel
      Left = 30
      Top = 45
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1088#1080#1073#1086#1088':'
      FocusControl = EditInstrument
    end
    object LabelParam: TLabel
      Left = 17
      Top = 18
      Width = 54
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088':'
      FocusControl = EditParam
      WordWrap = True
    end
    object LabelPriority: TLabel
      Left = 118
      Top = 72
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1086#1088#1103#1076#1086#1082':'
      FocusControl = EditPriority
    end
    object EditInstrument: TEdit
      Left = 81
      Top = 41
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object ButtonInstrument: TButton
      Left = 258
      Top = 41
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1088#1080#1073#1086#1088
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object EditParam: TEdit
      Left = 81
      Top = 14
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonParam: TButton
      Left = 258
      Top = 14
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object EditPriority: TEdit
      Left = 173
      Top = 68
      Width = 78
      Height = 21
      TabOrder = 4
    end
  end
  inherited PanelButton: TPanel
    Top = 96
    Width = 324
    inherited ButtonCancel: TButton
      Left = 240
    end
    inherited ButtonOk: TButton
      Left = 158
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
