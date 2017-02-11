inherited SgtsRbkMeasureTypeEditForm: TSgtsRbkMeasureTypeEditForm
  Left = 426
  Top = 226
  ActiveControl = EditName
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1074#1080#1076#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
  ClientHeight = 324
  ClientWidth = 337
  Constraints.MinHeight = 345
  Constraints.MinWidth = 345
  ExplicitLeft = 426
  ExplicitTop = 226
  ExplicitWidth = 345
  ExplicitHeight = 370
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 305
    Width = 337
    ExplicitTop = 280
    ExplicitWidth = 337
  end
  inherited ToolBar: TToolBar
    Height = 266
    ExplicitHeight = 266
  end
  inherited PanelEdit: TPanel
    Width = 302
    Height = 266
    ExplicitWidth = 302
    ExplicitHeight = 241
    object LabelName: TLabel
      Left = 13
      Top = 39
      Width = 77
      Height = 13
      Alignment = taRightJustify
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
      FocusControl = EditName
    end
    object LabelNote: TLabel
      Left = 37
      Top = 84
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
      FocusControl = MemoNote
    end
    object LabelParent: TLabel
      Left = 22
      Top = 12
      Width = 68
      Height = 13
      Alignment = taRightJustify
      Caption = #1042#1077#1088#1093#1085#1080#1081' '#1074#1080#1076':'
      FocusControl = EditParent
    end
    object LabelDate: TLabel
      Left = 21
      Top = 179
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072':'
      FocusControl = DateTimePicker
    end
    object LabelPriority: TLabel
      Left = 101
      Top = 242
      Width = 97
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1086#1088#1103#1076#1086#1082' '#1074' '#1076#1077#1088#1077#1074#1077':'
      FocusControl = EditPriority
    end
    object EditName: TEdit
      Left = 98
      Top = 35
      Width = 196
      Height = 21
      TabOrder = 2
      Text = #1053#1086#1074#1099#1081' '#1074#1080#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
    end
    object MemoNote: TMemo
      Left = 98
      Top = 81
      Width = 196
      Height = 89
      TabOrder = 4
    end
    object EditParent: TEdit
      Left = 98
      Top = 8
      Width = 169
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonParent: TButton
      Left = 273
      Top = 8
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1074#1077#1088#1093#1085#1080#1081' '#1086#1073#1098#1077#1082#1090
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object DateTimePicker: TDateTimePicker
      Left = 98
      Top = 176
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 5
    end
    object CheckBoxIsActive: TCheckBox
      Left = 98
      Top = 200
      Width = 85
      Height = 17
      Caption = #1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object CheckBoxIsVisual: TCheckBox
      Left = 98
      Top = 60
      Width = 191
      Height = 17
      Caption = #1069#1090#1086' '#1074#1080#1079#1091#1072#1083#1100#1085#1099#1081' '#1074#1080#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      TabOrder = 3
    end
    object CheckBoxIsBase: TCheckBox
      Left = 98
      Top = 218
      Width = 167
      Height = 17
      Caption = #1041#1072#1079#1086#1074#1099#1081' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      TabOrder = 7
    end
    object EditPriority: TEdit
      Left = 204
      Top = 239
      Width = 95
      Height = 21
      TabOrder = 8
    end
  end
  inherited PanelButton: TPanel
    Top = 266
    Width = 337
    ExplicitTop = 241
    ExplicitWidth = 337
    inherited ButtonCancel: TButton
      Left = 256
      ExplicitLeft = 256
    end
    inherited ButtonOk: TButton
      Left = 174
      ExplicitLeft = 174
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
