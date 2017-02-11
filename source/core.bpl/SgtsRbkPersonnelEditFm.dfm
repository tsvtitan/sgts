inherited SgtsRbkPersonnelEditForm: TSgtsRbkPersonnelEditForm
  Left = 565
  Top = 185
  Width = 326
  Height = 258
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1077#1088#1089#1086#1085#1099
  Constraints.MinHeight = 195
  Constraints.MinWidth = 325
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 193
    Width = 318
  end
  inherited ToolBar: TToolBar
    Height = 154
  end
  inherited PanelEdit: TPanel
    Width = 283
    Height = 154
    object LabelFName: TLabel
      Left = 13
      Top = 34
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = #1060#1072#1084#1080#1083#1080#1103':'
      FocusControl = EditFName
    end
    object LabelName: TLabel
      Left = 40
      Top = 59
      Width = 25
      Height = 13
      Alignment = taRightJustify
      Caption = #1048#1084#1103':'
      FocusControl = EditName
    end
    object LabelSName: TLabel
      Left = 15
      Top = 84
      Width = 50
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
      FocusControl = EditSName
    end
    object LabelDivision: TLabel
      Left = 30
      Top = 9
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1090#1076#1077#1083':'
      FocusControl = EditDivision
    end
    object LabelDateAccept: TLabel
      Left = 40
      Top = 109
      Width = 122
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1087#1088#1080#1077#1084#1072' '#1085#1072' '#1088#1072#1073#1086#1090#1091':'
      FocusControl = DateTimePickerAccept
    end
    object LabelSack: TLabel
      Left = 71
      Top = 134
      Width = 91
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1091#1074#1086#1083#1100#1085#1077#1085#1080#1103':'
      FocusControl = DateTimePickerSack
    end
    object EditFName: TEdit
      Left = 72
      Top = 30
      Width = 199
      Height = 21
      TabOrder = 2
    end
    object EditName: TEdit
      Left = 72
      Top = 55
      Width = 199
      Height = 21
      TabOrder = 3
    end
    object EditSName: TEdit
      Left = 72
      Top = 80
      Width = 199
      Height = 21
      TabOrder = 4
    end
    object EditDivision: TEdit
      Left = 72
      Top = 5
      Width = 172
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonDivision: TButton
      Left = 249
      Top = 5
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1086#1090#1076#1077#1083
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object DateTimePickerAccept: TDateTimePicker
      Left = 171
      Top = 105
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 5
    end
    object DateTimePickerSack: TDateTimePicker
      Left = 171
      Top = 130
      Width = 100
      Height = 21
      Date = 0.504579895830829600
      Time = 0.504579895830829600
      TabOrder = 6
    end
  end
  inherited PanelButton: TPanel
    Top = 154
    Width = 318
    inherited ButtonCancel: TButton
      Left = 239
    end
    inherited ButtonOk: TButton
      Left = 157
    end
  end
  inherited MainMenu: TMainMenu
    Left = 152
    Top = 0
  end
  inherited ImageList: TImageList
    Left = 184
    Top = 2
  end
end
