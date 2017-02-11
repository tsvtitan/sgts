inherited SgtsRbkConverterEditForm: TSgtsRbkConverterEditForm
  Left = 471
  Top = 308
  Width = 348
  Height = 281
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1077#1083#1103
  Constraints.MinHeight = 160
  Constraints.MinWidth = 300
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 216
    Width = 340
  end
  inherited ToolBar: TToolBar
    Height = 177
  end
  inherited PanelEdit: TPanel
    Width = 305
    Height = 177
    object LabelPoint: TLabel
      Left = 51
      Top = 13
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = #1058#1086#1095#1082#1072':'
      FocusControl = EditPoint
    end
    object LabelName: TLabel
      Left = 8
      Top = 40
      Width = 77
      Height = 13
      Alignment = taRightJustify
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
      FocusControl = EditName
    end
    object LabelDescription: TLabel
      Left = 32
      Top = 66
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
      FocusControl = MemoDescription
    end
    object LabelDateEnter: TLabel
      Left = 21
      Top = 139
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1074#1074#1086#1076#1072':'
      FocusControl = DateTimePicker
    end
    object EditPoint: TEdit
      Left = 95
      Top = 9
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonPoint: TButton
      Left = 272
      Top = 9
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1091#1102' '#1090#1086#1095#1082#1091
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object EditName: TEdit
      Left = 95
      Top = 36
      Width = 198
      Height = 21
      TabOrder = 2
      Text = #1053#1086#1074#1099#1081' '#1087#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object MemoDescription: TMemo
      Left = 95
      Top = 63
      Width = 198
      Height = 67
      TabOrder = 3
    end
    object DateTimePicker: TDateTimePicker
      Left = 95
      Top = 135
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      TabOrder = 4
    end
    object CheckBoxNotOperation: TCheckBox
      Left = 95
      Top = 159
      Width = 122
      Height = 17
      Caption = #1053#1077' '#1092#1091#1085#1082#1094#1080#1086#1085#1080#1088#1091#1077#1090
      TabOrder = 5
    end
  end
  inherited PanelButton: TPanel
    Top = 177
    Width = 340
    inherited ButtonCancel: TButton
      Left = 256
    end
    inherited ButtonOk: TButton
      Left = 174
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
