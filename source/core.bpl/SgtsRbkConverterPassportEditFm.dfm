inherited SgtsRbkConverterPassportEditForm: TSgtsRbkConverterPassportEditForm
  Left = 450
  Top = 209
  Width = 354
  Height = 329
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1072#1089#1087#1086#1088#1090#1072' '#1087#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1077#1083#1103
  Constraints.MinHeight = 210
  Constraints.MinWidth = 310
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 264
    Width = 346
  end
  inherited ToolBar: TToolBar
    Height = 225
  end
  inherited PanelEdit: TPanel
    Width = 311
    Height = 225
    object LabelDescription: TLabel
      Left = 26
      Top = 145
      Width = 71
      Height = 13
      Alignment = taRightJustify
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081':'
      FocusControl = MemoDescription
    end
    object LabelComponent: TLabel
      Left = 38
      Top = 16
      Width = 59
      Height = 13
      Alignment = taRightJustify
      Caption = #1050#1086#1084#1087#1086#1085#1077#1085#1090':'
      FocusControl = EditComponent
    end
    object LabelValue: TLabel
      Left = 45
      Top = 198
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077':'
      FocusControl = EditValue
    end
    object LabelInstrument: TLabel
      Left = 56
      Top = 42
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1088#1080#1073#1086#1088':'
      FocusControl = EditInstrument
    end
    object LabelMeasureUnit: TLabel
      Left = 40
      Top = 60
      Width = 57
      Height = 26
      Alignment = taRightJustify
      Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
      FocusControl = EditMeasureUnit
      WordWrap = True
    end
    object LabelDateBegin: TLabel
      Left = 28
      Top = 94
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072':'
      FocusControl = DateTimePickerBegin
    end
    object LabelDateEnd: TLabel
      Left = 10
      Top = 120
      Width = 87
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
      FocusControl = DateTimePickerEnd
    end
    object MemoDescription: TMemo
      Left = 105
      Top = 142
      Width = 198
      Height = 48
      TabOrder = 8
    end
    object EditComponent: TEdit
      Left = 105
      Top = 12
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonComponent: TButton
      Left = 282
      Top = 12
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1082#1086#1084#1087#1086#1085#1077#1085#1090
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object EditValue: TEdit
      Left = 105
      Top = 195
      Width = 198
      Height = 21
      TabOrder = 9
    end
    object DateTimePickerBegin: TDateTimePicker
      Left = 105
      Top = 90
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 6
    end
    object DateTimePickerEnd: TDateTimePicker
      Left = 105
      Top = 116
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 7
    end
    object EditInstrument: TEdit
      Left = 105
      Top = 38
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object ButtonInstrument: TButton
      Left = 282
      Top = 38
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1088#1080#1073#1086#1088
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object EditMeasureUnit: TEdit
      Left = 105
      Top = 64
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 4
    end
    object ButtonMeasureUnit: TButton
      Left = 282
      Top = 64
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1077#1076#1080#1085#1080#1094#1091' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
  end
  inherited PanelButton: TPanel
    Top = 225
    Width = 346
    DesignSize = (
      346
      39)
    inherited ButtonCancel: TButton
      Left = 265
    end
    inherited ButtonOk: TButton
      Left = 183
    end
  end
  inherited MainMenu: TMainMenu
    Left = 176
    Top = 144
  end
  inherited ImageList: TImageList
    Left = 216
    Top = 146
  end
end
