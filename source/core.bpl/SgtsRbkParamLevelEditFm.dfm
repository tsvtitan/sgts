inherited SgtsRbkParamLevelEditForm: TSgtsRbkParamLevelEditForm
  Left = 471
  Top = 308
  Width = 324
  Height = 225
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1091#1088#1086#1074#1085#1103' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
  Constraints.MinHeight = 160
  Constraints.MinWidth = 300
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 160
    Width = 316
  end
  inherited ToolBar: TToolBar
    Height = 121
  end
  inherited PanelEdit: TPanel
    Width = 281
    Height = 121
    object LabelParam: TLabel
      Left = 10
      Top = 17
      Width = 54
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088':'
      FocusControl = EditParam
    end
    object LabelLevel: TLabel
      Left = 17
      Top = 44
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = #1059#1088#1086#1074#1077#1085#1100':'
      FocusControl = EditLevel
      WordWrap = True
    end
    object LabelMin: TLabel
      Left = 19
      Top = 71
      Width = 124
      Height = 13
      Alignment = taRightJustify
      Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077':'
      FocusControl = EditMin
    end
    object LabelMax: TLabel
      Left = 13
      Top = 98
      Width = 130
      Height = 13
      Alignment = taRightJustify
      Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077':'
      FocusControl = EditMax
    end
    object EditParam: TEdit
      Left = 74
      Top = 13
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonParam: TButton
      Left = 251
      Top = 13
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object EditLevel: TEdit
      Left = 74
      Top = 40
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object ButtonLevel: TButton
      Left = 251
      Top = 40
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object EditMin: TEdit
      Left = 151
      Top = 67
      Width = 94
      Height = 21
      TabOrder = 4
    end
    object EditMax: TEdit
      Left = 151
      Top = 94
      Width = 94
      Height = 21
      TabOrder = 5
    end
  end
  inherited PanelButton: TPanel
    Top = 121
    Width = 316
    inherited ButtonCancel: TButton
      Left = 232
    end
    inherited ButtonOk: TButton
      Left = 150
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
