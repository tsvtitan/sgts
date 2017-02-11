inherited SgtsRbkDivisionEditForm: TSgtsRbkDivisionEditForm
  Left = 426
  Top = 226
  Width = 344
  Height = 282
  ActiveControl = EditName
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1076#1077#1083#1072
  Constraints.MinHeight = 240
  Constraints.MinWidth = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 217
    Width = 336
  end
  inherited ToolBar: TToolBar
    Height = 178
  end
  inherited PanelEdit: TPanel
    Width = 301
    Height = 178
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
      Top = 65
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
      FocusControl = MemoNote
    end
    object LabelParent: TLabel
      Left = 10
      Top = 12
      Width = 80
      Height = 13
      Alignment = taRightJustify
      Caption = #1042#1077#1088#1093#1085#1080#1081' '#1086#1090#1076#1077#1083':'
      FocusControl = EditParent
    end
    object LabelPriority: TLabel
      Left = 42
      Top = 161
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1086#1088#1103#1076#1086#1082':'
      FocusControl = EditPriority
    end
    object EditName: TEdit
      Left = 98
      Top = 35
      Width = 196
      Height = 21
      TabOrder = 2
      Text = #1053#1086#1074#1099#1081' '#1086#1090#1076#1077#1083
    end
    object MemoNote: TMemo
      Left = 98
      Top = 62
      Width = 196
      Height = 89
      TabOrder = 3
    end
    object EditParent: TEdit
      Left = 98
      Top = 8
      Width = 169
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
      OnKeyDown = EditParentKeyDown
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
      OnClick = ButtonParentClick
    end
    object EditPriority: TEdit
      Left = 98
      Top = 157
      Width = 78
      Height = 21
      TabOrder = 4
    end
  end
  inherited PanelButton: TPanel
    Top = 178
    Width = 336
    inherited ButtonCancel: TButton
      Left = 255
    end
    inherited ButtonOk: TButton
      Left = 173
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
    Top = 88
  end
  inherited ImageList: TImageList
    Left = 232
    Top = 82
  end
end
