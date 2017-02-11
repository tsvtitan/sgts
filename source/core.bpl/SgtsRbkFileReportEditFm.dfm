inherited SgtsRbkFileReportEditForm: TSgtsRbkFileReportEditForm
  Left = 426
  Top = 226
  Width = 450
  Height = 340
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1092#1072#1081#1083#1086#1074#1086#1075#1086' '#1086#1090#1095#1077#1090#1072
  Constraints.MinHeight = 340
  Constraints.MinWidth = 450
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 275
    Width = 442
  end
  inherited ToolBar: TToolBar
    Height = 236
  end
  inherited PanelEdit: TPanel
    Width = 407
    Height = 236
    object LabelName: TLabel
      Left = 5
      Top = 16
      Width = 77
      Height = 13
      Alignment = taRightJustify
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
      FocusControl = EditName
    end
    object LabelNote: TLabel
      Left = 29
      Top = 41
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
      FocusControl = MemoNote
    end
    object LabelFileName: TLabel
      Left = 13
      Top = 162
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = #1060#1072#1081#1083' '#1086#1090#1095#1077#1090#1072':'
      FocusControl = EditFileName
    end
    object LabelPriority: TLabel
      Left = 221
      Top = 214
      Width = 87
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1086#1088#1103#1076#1086#1082' '#1074' '#1084#1077#1085#1102':'
      FocusControl = EditPriority
    end
    object LabelModule: TLabel
      Left = 39
      Top = 136
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = #1052#1086#1076#1091#1083#1100':'
      FocusControl = ComboBoxModule
    end
    object LabelMenu: TLabel
      Left = 49
      Top = 188
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = #1052#1077#1085#1102':'
      FocusControl = EditMenu
    end
    object EditName: TEdit
      Left = 90
      Top = 12
      Width = 304
      Height = 21
      TabOrder = 0
      Text = #1053#1086#1074#1099#1081' '#1092#1072#1081#1083#1086#1074#1099#1081' '#1086#1090#1095#1077#1090
    end
    object MemoNote: TMemo
      Left = 90
      Top = 38
      Width = 304
      Height = 89
      TabOrder = 1
    end
    object EditFileName: TEdit
      Left = 90
      Top = 158
      Width = 278
      Height = 21
      TabOrder = 3
    end
    object ButtonFileName: TButton
      Left = 373
      Top = 158
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1092#1072#1081#1083' '#1086#1090#1095#1077#1090#1072
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object EditPriority: TEdit
      Left = 316
      Top = 210
      Width = 78
      Height = 21
      TabOrder = 6
    end
    object ComboBoxModule: TComboBox
      Left = 90
      Top = 132
      Width = 304
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = ComboBoxModuleChange
    end
    object EditMenu: TEdit
      Left = 90
      Top = 184
      Width = 304
      Height = 21
      TabOrder = 5
    end
  end
  inherited PanelButton: TPanel
    Top = 236
    Width = 442
    inherited ButtonCancel: TButton
      Left = 361
    end
    inherited ButtonOk: TButton
      Left = 279
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
