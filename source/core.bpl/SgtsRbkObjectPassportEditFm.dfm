inherited SgtsRbkObjectPassportEditForm: TSgtsRbkObjectPassportEditForm
  Left = 450
  Top = 209
  Width = 342
  Height = 300
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1072#1089#1087#1086#1088#1090#1072' '#1086#1073#1098#1077#1082#1090#1072
  Constraints.MinHeight = 210
  Constraints.MinWidth = 310
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 235
    Width = 334
  end
  inherited ToolBar: TToolBar
    Width = 35
    Height = 196
    inherited ToolButtonOk: TToolButton
      Wrap = True
    end
    inherited ToolButtonCancel: TToolButton
      Left = 0
      Top = 30
    end
    inherited ToolButtonDefault: TToolButton
      Top = 60
    end
  end
  inherited PanelEdit: TPanel
    Left = 35
    Width = 299
    Height = 196
    object LabelDescription: TLabel
      Left = 12
      Top = 119
      Width = 73
      Height = 13
      Alignment = taRightJustify
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081':'
      FocusControl = MemoDescription
    end
    object LabelObject: TLabel
      Left = 44
      Top = 16
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1073#1098#1077#1082#1090':'
      FocusControl = EditObject
    end
    object LabelDatePassport: TLabel
      Left = 56
      Top = 42
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072':'
      FocusControl = DateTimePickerPassport
    end
    object LabelParamName: TLabel
      Left = 31
      Top = 67
      Width = 54
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088':'
      FocusControl = EditParamName
    end
    object LabelValue: TLabel
      Left = 34
      Top = 94
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077':'
      FocusControl = EditValue
    end
    object MemoDescription: TMemo
      Left = 93
      Top = 116
      Width = 198
      Height = 75
      TabOrder = 5
    end
    object EditObject: TEdit
      Left = 93
      Top = 12
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonObject: TButton
      Left = 270
      Top = 12
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1086#1073#1098#1077#1082#1090
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object DateTimePickerPassport: TDateTimePicker
      Left = 93
      Top = 38
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 2
    end
    object EditParamName: TEdit
      Left = 93
      Top = 64
      Width = 193
      Height = 21
      TabOrder = 3
    end
    object EditValue: TEdit
      Left = 93
      Top = 90
      Width = 94
      Height = 21
      TabOrder = 4
    end
  end
  inherited PanelButton: TPanel
    Top = 196
    Width = 334
    DesignSize = (
      334
      39)
    inherited ButtonCancel: TButton
      Left = 253
    end
    inherited ButtonOk: TButton
      Left = 171
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
