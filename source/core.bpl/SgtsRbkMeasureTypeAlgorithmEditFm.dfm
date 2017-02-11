inherited SgtsRbkMeasureTypeAlgorithmEditForm: TSgtsRbkMeasureTypeAlgorithmEditForm
  Left = 471
  Top = 308
  Width = 349
  Height = 255
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1072#1083#1075#1086#1088#1080#1090#1084#1072' '#1074#1080#1076#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
  Constraints.MinHeight = 160
  Constraints.MinWidth = 300
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 190
    Width = 341
  end
  inherited ToolBar: TToolBar
    Height = 151
  end
  inherited PanelEdit: TPanel
    Width = 306
    Height = 151
    object LabelMeasureType: TLabel
      Left = 12
      Top = 23
      Width = 79
      Height = 13
      Alignment = taRightJustify
      Caption = #1042#1080#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
      FocusControl = EditMeasureType
    end
    object LabelAlgorithm: TLabel
      Left = 39
      Top = 50
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = #1040#1083#1075#1086#1088#1080#1090#1084':'
      FocusControl = EditAlgorithm
      WordWrap = True
    end
    object LabelPriority: TLabel
      Left = 45
      Top = 129
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1086#1088#1103#1076#1086#1082':'
      FocusControl = EditPriority
    end
    object LabelDateBegin: TLabel
      Left = 24
      Top = 77
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072':'
      FocusControl = DateTimePickerBegin
    end
    object LabelDateEnd: TLabel
      Left = 6
      Top = 103
      Width = 87
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
      FocusControl = DateTimePickerEnd
    end
    object EditMeasureType: TEdit
      Left = 101
      Top = 19
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonMeasureType: TButton
      Left = 278
      Top = 19
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1074#1080#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object EditAlgorithm: TEdit
      Left = 101
      Top = 46
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object ButtonAlgorithm: TButton
      Left = 278
      Top = 46
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1072#1083#1075#1086#1088#1080#1090#1084
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object EditPriority: TEdit
      Left = 101
      Top = 125
      Width = 78
      Height = 21
      TabOrder = 6
    end
    object DateTimePickerBegin: TDateTimePicker
      Left = 101
      Top = 73
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 4
    end
    object DateTimePickerEnd: TDateTimePicker
      Left = 101
      Top = 99
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 5
    end
  end
  inherited PanelButton: TPanel
    Top = 151
    Width = 341
    inherited ButtonCancel: TButton
      Left = 257
    end
    inherited ButtonOk: TButton
      Left = 175
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
