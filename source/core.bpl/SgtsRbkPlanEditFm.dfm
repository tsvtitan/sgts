inherited SgtsRbkPlanEditForm: TSgtsRbkPlanEditForm
  Left = 450
  Top = 209
  Width = 337
  Height = 215
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1082#1072#1083#1077#1085#1076#1072#1088#1085#1086#1075#1086' '#1087#1083#1072#1085#1072
  Constraints.MinHeight = 210
  Constraints.MinWidth = 310
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 150
    Width = 329
  end
  inherited ToolBar: TToolBar
    Height = 111
  end
  inherited PanelEdit: TPanel
    Width = 294
    Height = 111
    object LabelCycle: TLabel
      Left = 58
      Top = 14
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = #1062#1080#1082#1083':'
      FocusControl = EditCycle
    end
    object LabelMeasureType: TLabel
      Left = 6
      Top = 40
      Width = 81
      Height = 13
      Alignment = taRightJustify
      Caption = #1042#1080#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
      FocusControl = EditMeasureType
    end
    object LabelDateBegin: TLabel
      Left = 85
      Top = 66
      Width = 67
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072':'
      FocusControl = DateTimePickerBegin
    end
    object LabelDateEnd: TLabel
      Left = 67
      Top = 91
      Width = 85
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
      FocusControl = DateTimePickerEnd
    end
    object EditCycle: TEdit
      Left = 95
      Top = 10
      Width = 166
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonCycle: TButton
      Left = 267
      Top = 10
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1094#1080#1082#1083
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object EditMeasureType: TEdit
      Left = 95
      Top = 36
      Width = 166
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object ButtonMeasureType: TButton
      Left = 267
      Top = 36
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1074#1080#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object DateTimePickerBegin: TDateTimePicker
      Left = 161
      Top = 62
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 4
    end
    object DateTimePickerEnd: TDateTimePicker
      Left = 161
      Top = 87
      Width = 100
      Height = 21
      Date = 0.504579895830829600
      Time = 0.504579895830829600
      TabOrder = 5
    end
  end
  inherited PanelButton: TPanel
    Top = 111
    Width = 329
    DesignSize = (
      329
      39)
    inherited ButtonCancel: TButton
      Left = 248
    end
    inherited ButtonOk: TButton
      Left = 166
    end
  end
  inherited MainMenu: TMainMenu
    Left = 24
    Top = 144
  end
  inherited ImageList: TImageList
    Left = 64
    Top = 146
  end
end
