inherited SgtsRbkInstrumentUnitEditForm: TSgtsRbkInstrumentUnitEditForm
  Left = 549
  Top = 218
  Width = 341
  Height = 202
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1077#1076#1080#1085#1080#1094#1099' '#1087#1088#1080#1073#1086#1088#1072
  Constraints.MinHeight = 160
  Constraints.MinWidth = 330
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 137
    Width = 333
  end
  inherited ToolBar: TToolBar
    Height = 98
  end
  inherited PanelEdit: TPanel
    Width = 298
    Height = 98
    object LabelInstrument: TLabel
      Left = 41
      Top = 23
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1088#1080#1073#1086#1088':'
      FocusControl = EditInstrument
    end
    object LabelMeasureUnit: TLabel
      Left = 23
      Top = 42
      Width = 59
      Height = 26
      Alignment = taRightJustify
      Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
      FocusControl = EditMeasureUnit
      WordWrap = True
    end
    object LabelPriority: TLabel
      Left = 130
      Top = 77
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1086#1088#1103#1076#1086#1082':'
      FocusControl = EditPriority
    end
    object EditInstrument: TEdit
      Left = 92
      Top = 19
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonInstrument: TButton
      Left = 269
      Top = 19
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1088#1080#1073#1086#1088
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object EditMeasureUnit: TEdit
      Left = 92
      Top = 46
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object ButtonMeasureUnit: TButton
      Left = 269
      Top = 46
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1077#1076#1080#1085#1080#1094#1091' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object EditPriority: TEdit
      Left = 185
      Top = 73
      Width = 78
      Height = 21
      TabOrder = 4
    end
  end
  inherited PanelButton: TPanel
    Top = 98
    Width = 333
    inherited ButtonCancel: TButton
      Left = 249
    end
    inherited ButtonOk: TButton
      Left = 167
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
