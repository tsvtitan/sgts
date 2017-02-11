inherited SgtsRbkPointInstrumentEditForm: TSgtsRbkPointInstrumentEditForm
  Left = 494
  Top = 196
  Width = 330
  Height = 230
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1088#1080#1073#1086#1088#1086#1074' '#1090#1086#1095#1077#1082
  Constraints.MinHeight = 230
  Constraints.MinWidth = 330
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 165
    Width = 322
  end
  inherited ToolBar: TToolBar
    Height = 126
  end
  inherited PanelEdit: TPanel
    Width = 287
    Height = 126
    object LabelInstrument: TLabel
      Left = 30
      Top = 72
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1088#1080#1073#1086#1088':'
      FocusControl = EditInstrument
    end
    object LabelPoint: TLabel
      Left = 37
      Top = 18
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = #1058#1086#1095#1082#1072':'
      FocusControl = EditPoint
      WordWrap = True
    end
    object LabelPriority: TLabel
      Left = 118
      Top = 99
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1086#1088#1103#1076#1086#1082':'
      FocusControl = EditPriority
    end
    object LabelParam: TLabel
      Left = 18
      Top = 45
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088':'
      FocusControl = EditParam
      WordWrap = True
    end
    object EditInstrument: TEdit
      Left = 81
      Top = 68
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 4
    end
    object ButtonInstrument: TButton
      Left = 258
      Top = 68
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1088#1080#1073#1086#1088
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
    object EditPoint: TEdit
      Left = 81
      Top = 14
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonPoint: TButton
      Left = 258
      Top = 14
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1090#1086#1095#1082#1091
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object EditPriority: TEdit
      Left = 174
      Top = 95
      Width = 78
      Height = 21
      TabOrder = 6
    end
    object EditParam: TEdit
      Left = 81
      Top = 41
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object ButtonParam: TButton
      Left = 258
      Top = 41
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
  end
  inherited PanelButton: TPanel
    Top = 126
    Width = 322
    inherited ButtonCancel: TButton
      Left = 238
      Top = 7
    end
    inherited ButtonOk: TButton
      Left = 156
      Top = 7
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
