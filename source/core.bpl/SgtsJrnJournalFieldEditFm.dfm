inherited SgtsJrnJournalFieldEditForm: TSgtsJrnJournalFieldEditForm
  Left = 502
  Top = 250
  Width = 659
  Height = 367
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1086#1083#1077#1074#1086#1075#1086' '#1078#1091#1088#1085#1072#1083#1072
  Constraints.MinHeight = 210
  Constraints.MinWidth = 310
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 302
    Width = 651
  end
  inherited ToolBar: TToolBar
    Height = 263
  end
  inherited PanelEdit: TPanel
    Width = 616
    Height = 263
    object LabelCycle: TLabel
      Left = 47
      Top = 37
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = #1062#1080#1082#1083':'
      FocusControl = EditCycle
    end
    object LabelPoint: TLabel
      Left = 18
      Top = 89
      Width = 59
      Height = 13
      Alignment = taRightJustify
      Caption = #1048#1079#1084'. '#1090#1086#1095#1082#1072':'
      FocusControl = EditPoint
    end
    object LabelParam: TLabel
      Left = 24
      Top = 115
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088':'
      FocusControl = EditParam
    end
    object LabelValue: TLabel
      Left = 25
      Top = 193
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077':'
      FocusControl = EditValue
    end
    object LabelWhoEnter: TLabel
      Left = 335
      Top = 35
      Width = 50
      Height = 13
      Alignment = taRightJustify
      Caption = #1050#1090#1086' '#1074#1074#1077#1083':'
      FocusControl = EditWhoEnter
    end
    object LabelDateEnter: TLabel
      Left = 320
      Top = 61
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1074#1074#1086#1076#1072':'
      FocusControl = DateTimePickerEnter
    end
    object LabelWhoConfirm: TLabel
      Left = 310
      Top = 87
      Width = 75
      Height = 13
      Alignment = taRightJustify
      Caption = #1050#1090#1086' '#1091#1090#1074#1077#1088#1076#1080#1083':'
      FocusControl = EditWhoConfirm
    end
    object LabelDateConfirm: TLabel
      Left = 312
      Top = 106
      Width = 73
      Height = 26
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1091#1090#1074#1077#1088#1078#1076#1077#1085#1080#1103':'
      FocusControl = DateTimePickerConfirm
      WordWrap = True
    end
    object LabelDateObservation: TLabel
      Left = 9
      Top = 7
      Width = 68
      Height = 26
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1085#1072#1073#1083#1102#1076#1077#1085#1080#1103':'
      FocusControl = DateTimePickerObservation
      WordWrap = True
    end
    object LabelInstrument: TLabel
      Left = 36
      Top = 141
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1088#1080#1073#1086#1088':'
      FocusControl = EditInstrument
    end
    object LabelMeasureUnit: TLabel
      Left = 20
      Top = 160
      Width = 57
      Height = 26
      Alignment = taRightJustify
      Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
      FocusControl = EditMeasureUnit
      WordWrap = True
    end
    object LabelMeasureType: TLabel
      Left = 30
      Top = 63
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = #1042#1080#1076' '#1080#1079#1084'.:'
      FocusControl = EditMeasureType
    end
    object LabelGroupId: TLabel
      Left = 37
      Top = 219
      Width = 40
      Height = 13
      Alignment = taRightJustify
      Caption = #1043#1088#1091#1087#1087#1072':'
      FocusControl = EditGroupId
    end
    object LabelPriority: TLabel
      Left = 29
      Top = 245
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1086#1088#1103#1076#1086#1082':'
      FocusControl = EditPriority
    end
    object LabelJournalNum: TLabel
      Left = 303
      Top = 10
      Width = 82
      Height = 13
      Alignment = taRightJustify
      Caption = #1053#1086#1084#1077#1088' '#1078#1091#1088#1085#1072#1083#1072':'
      FocusControl = EditJournalNum
    end
    object LabelNote: TLabel
      Left = 318
      Top = 146
      Width = 65
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
      FocusControl = MemoNote
    end
    object EditCycle: TEdit
      Left = 85
      Top = 33
      Width = 186
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object ButtonCycle: TButton
      Left = 277
      Top = 33
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1094#1080#1082#1083
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object EditPoint: TEdit
      Left = 85
      Top = 85
      Width = 186
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
    end
    object ButtonPoint: TButton
      Left = 277
      Top = 85
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1091#1102' '#1090#1086#1095#1082#1091
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
    end
    object EditParam: TEdit
      Left = 85
      Top = 111
      Width = 186
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 7
    end
    object ButtonParam: TButton
      Left = 277
      Top = 111
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
    end
    object EditValue: TEdit
      Left = 85
      Top = 189
      Width = 100
      Height = 21
      TabOrder = 13
    end
    object EditWhoEnter: TEdit
      Left = 393
      Top = 31
      Width = 186
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 19
    end
    object ButtonWhoEnter: TButton
      Left = 585
      Top = 31
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1077#1088#1089#1086#1085#1091
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 20
    end
    object DateTimePickerEnter: TDateTimePicker
      Left = 393
      Top = 57
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 21
    end
    object EditWhoConfirm: TEdit
      Left = 393
      Top = 83
      Width = 186
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 22
      OnKeyDown = EditWhoConfirmKeyDown
    end
    object ButtonWhoConfirm: TButton
      Left = 585
      Top = 83
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1077#1088#1089#1086#1085#1091
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 23
      OnClick = ButtonWhoConfirmClick
    end
    object DateTimePickerConfirm: TDateTimePicker
      Left = 393
      Top = 109
      Width = 100
      Height = 21
      Date = 0.504579895830829600
      Time = 0.504579895830829600
      TabOrder = 24
    end
    object DateTimePickerObservation: TDateTimePicker
      Left = 85
      Top = 8
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 0
    end
    object EditInstrument: TEdit
      Left = 85
      Top = 137
      Width = 186
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 9
    end
    object ButtonInstrument: TButton
      Left = 277
      Top = 137
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1088#1080#1073#1086#1088
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
    end
    object EditMeasureUnit: TEdit
      Left = 85
      Top = 163
      Width = 186
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 11
    end
    object ButtonMeasureUnit: TButton
      Left = 277
      Top = 163
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1077#1076#1080#1085#1080#1094#1091' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
    end
    object EditMeasureType: TEdit
      Left = 85
      Top = 59
      Width = 186
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
    end
    object ButtonMeasureType: TButton
      Left = 277
      Top = 59
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1074#1080#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object EditGroupId: TEdit
      Left = 85
      Top = 215
      Width = 211
      Height = 21
      TabOrder = 15
      OnKeyDown = EditWhoConfirmKeyDown
    end
    object EditPriority: TEdit
      Left = 85
      Top = 241
      Width = 78
      Height = 21
      TabOrder = 16
    end
    object CheckBoxIsBase: TCheckBox
      Left = 191
      Top = 191
      Width = 85
      Height = 17
      Caption = #1041#1072#1079#1086#1074#1099#1081
      Checked = True
      State = cbChecked
      TabOrder = 14
    end
    object EditJournalNum: TEdit
      Left = 393
      Top = 6
      Width = 100
      Height = 21
      TabOrder = 18
    end
    object MemoNote: TMemo
      Left = 315
      Top = 162
      Width = 291
      Height = 99
      ScrollBars = ssBoth
      TabOrder = 25
    end
    object CheckBoxIsCheck: TCheckBox
      Left = 169
      Top = 243
      Width = 85
      Height = 17
      Caption = #1050#1086#1085#1090#1088#1086#1083#1100
      TabOrder = 17
    end
  end
  inherited PanelButton: TPanel
    Top = 263
    Width = 651
    DesignSize = (
      651
      39)
    inherited ButtonCancel: TButton
      Left = 570
    end
    inherited ButtonOk: TButton
      Left = 488
    end
  end
  inherited MainMenu: TMainMenu
    Left = 16
    Top = 128
  end
  inherited ImageList: TImageList
    Left = 16
    Top = 186
  end
end
