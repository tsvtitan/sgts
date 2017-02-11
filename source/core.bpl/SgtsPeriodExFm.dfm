inherited SgtsPeriodExForm: TSgtsPeriodExForm
  Left = 620
  Top = 380
  Caption = #1042#1099#1073#1086#1088' '#1087#1077#1088#1080#1086#1076#1072
  ClientHeight = 122
  ClientWidth = 363
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelDialog: TPanel
    Width = 363
    Height = 84
    object LabelPeriodEnd: TLabel
      Left = 214
      Top = 17
      Width = 16
      Height = 13
      Alignment = taRightJustify
      Caption = #1087#1086':'
      FocusControl = DateTimePickerPeriodEnd
    end
    object LabelPeriodBegin: TLabel
      Left = 98
      Top = 17
      Width = 9
      Height = 13
      Alignment = taRightJustify
      Caption = #1089':'
      FocusControl = DateTimePickerPeriodBegin
    end
    object LabelCycleBegin: TLabel
      Left = 98
      Top = 46
      Width = 9
      Height = 13
      Alignment = taRightJustify
      Caption = #1089':'
      Enabled = False
      FocusControl = EditCycleBegin
    end
    object LabelCycleEnd: TLabel
      Left = 214
      Top = 46
      Width = 16
      Height = 13
      Alignment = taRightJustify
      Caption = #1087#1086':'
      Enabled = False
      FocusControl = EditCycleEnd
    end
    object RadioButtonPeriod: TRadioButton
      Left = 11
      Top = 16
      Width = 81
      Height = 17
      Caption = #1047#1072' '#1087#1077#1088#1080#1086#1076
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = RadioButtonPeriodClick
    end
    object DateTimePickerPeriodBegin: TDateTimePicker
      Left = 115
      Top = 14
      Width = 89
      Height = 21
      Hint = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
      Date = 39283.583816365740000000
      Time = 39283.583816365740000000
      TabOrder = 2
    end
    object DateTimePickerPeriodEnd: TDateTimePicker
      Left = 238
      Top = 14
      Width = 89
      Height = 21
      Hint = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
      Date = 39283.583816365740000000
      Time = 39283.583816365740000000
      TabOrder = 3
    end
    object RadioButtonCycle: TRadioButton
      Left = 11
      Top = 45
      Width = 69
      Height = 17
      Caption = #1047#1072' '#1094#1080#1082#1083
      TabOrder = 1
      OnClick = RadioButtonPeriodClick
    end
    object EditCycleBegin: TEdit
      Left = 115
      Top = 43
      Width = 60
      Height = 21
      Hint = #1053#1072#1095#1072#1083#1100#1085#1099#1081' '#1094#1080#1082#1083
      Color = clBtnFace
      Enabled = False
      TabOrder = 5
    end
    object ButtonCycleBegin: TButton
      Left = 182
      Top = 43
      Width = 21
      Height = 21
      Caption = '...'
      Enabled = False
      TabOrder = 6
      OnClick = ButtonCycleBeginClick
    end
    object EditCycleEnd: TEdit
      Left = 238
      Top = 43
      Width = 60
      Height = 21
      Hint = #1050#1086#1085#1077#1095#1085#1099#1081' '#1094#1080#1082#1083
      Color = clBtnFace
      Enabled = False
      TabOrder = 7
    end
    object ButtonCycleEnd: TButton
      Left = 305
      Top = 43
      Width = 21
      Height = 21
      Caption = '...'
      Enabled = False
      TabOrder = 8
      OnClick = ButtonCycleEndClick
    end
    object ButtonPeriod: TButton
      Left = 333
      Top = 14
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 4
      OnClick = ButtonPeriodClick
    end
  end
  inherited PanelButton: TPanel
    Top = 84
    Width = 363
    inherited ButtonOk: TButton
      Left = 201
    end
    inherited ButtonCancel: TButton
      Left = 283
    end
  end
end
