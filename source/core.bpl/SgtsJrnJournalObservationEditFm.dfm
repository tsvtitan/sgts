inherited SgtsJrnJournalObservationEditForm: TSgtsJrnJournalObservationEditForm
  Left = 450
  Top = 209
  Width = 339
  Height = 288
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1078#1091#1088#1085#1072#1083#1072' '#1085#1072#1073#1083#1102#1076#1077#1085#1080#1081
  Constraints.MinHeight = 210
  Constraints.MinWidth = 310
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 223
    Width = 331
  end
  inherited ToolBar: TToolBar
    Height = 184
  end
  inherited PanelEdit: TPanel
    Width = 296
    Height = 184
    object LabelCycle: TLabel
      Left = 49
      Top = 35
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = #1062#1080#1082#1083':'
      FocusControl = EditCycle
    end
    object LabelPoint: TLabel
      Left = 20
      Top = 61
      Width = 59
      Height = 13
      Alignment = taRightJustify
      Caption = #1048#1079#1084'. '#1090#1086#1095#1082#1072':'
      FocusControl = EditPoint
    end
    object LabelParam: TLabel
      Left = 26
      Top = 87
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088':'
      FocusControl = EditParam
    end
    object LabelValue: TLabel
      Left = 27
      Top = 113
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077':'
      FocusControl = EditValue
    end
    object LabelWhoEnter: TLabel
      Left = 29
      Top = 139
      Width = 50
      Height = 13
      Alignment = taRightJustify
      Caption = #1050#1090#1086' '#1074#1074#1077#1083':'
      FocusControl = EditWhoEnter
    end
    object LabelDateEnter: TLabel
      Left = 14
      Top = 165
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1074#1074#1086#1076#1072':'
      FocusControl = DateTimePickerEnter
    end
    object LabelDateObservation: TLabel
      Left = 11
      Top = 3
      Width = 68
      Height = 26
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1085#1072#1073#1083#1102#1076#1077#1085#1080#1103':'
      FocusControl = DateTimePickerObservation
      WordWrap = True
    end
    object EditCycle: TEdit
      Left = 87
      Top = 31
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object ButtonCycle: TButton
      Left = 264
      Top = 31
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1094#1080#1082#1083
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object EditPoint: TEdit
      Left = 87
      Top = 57
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
    end
    object ButtonPoint: TButton
      Left = 264
      Top = 57
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1091#1102' '#1090#1086#1095#1082#1091
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object EditParam: TEdit
      Left = 87
      Top = 83
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
    end
    object ButtonParam: TButton
      Left = 264
      Top = 83
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
    end
    object EditValue: TEdit
      Left = 87
      Top = 109
      Width = 94
      Height = 21
      TabOrder = 7
    end
    object EditWhoEnter: TEdit
      Left = 87
      Top = 135
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 8
    end
    object ButtonWhoEnter: TButton
      Left = 264
      Top = 135
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1077#1088#1089#1086#1085#1091
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
    end
    object DateTimePickerEnter: TDateTimePicker
      Left = 87
      Top = 161
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 10
    end
    object DateTimePickerObservation: TDateTimePicker
      Left = 87
      Top = 6
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 0
    end
  end
  inherited PanelButton: TPanel
    Top = 184
    Width = 331
    DesignSize = (
      331
      39)
    inherited ButtonCancel: TButton
      Left = 250
    end
    inherited ButtonOk: TButton
      Left = 168
    end
  end
  inherited MainMenu: TMainMenu
    Left = 176
    Top = 48
  end
  inherited ImageList: TImageList
    Left = 216
    Top = 50
  end
end
