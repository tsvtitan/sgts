inherited SgtsRbkAccountRoleEditForm: TSgtsRbkAccountRoleEditForm
  Left = 549
  Top = 218
  Width = 330
  Height = 204
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1086#1089#1090#1091#1087#1072' '#1082' '#1088#1086#1083#1103#1084
  Constraints.MinHeight = 160
  Constraints.MinWidth = 330
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 139
    Width = 322
  end
  inherited ToolBar: TToolBar
    Height = 100
  end
  inherited PanelEdit: TPanel
    Width = 287
    Height = 100
    object LabelAccount: TLabel
      Left = 10
      Top = 23
      Width = 84
      Height = 13
      Alignment = taRightJustify
      Caption = #1059#1095#1077#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100':'
      FocusControl = EditAccount
    end
    object LabelRole: TLabel
      Left = 66
      Top = 50
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = #1056#1086#1083#1100':'
      FocusControl = EditRole
    end
    object EditAccount: TEdit
      Left = 104
      Top = 19
      Width = 140
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonAccount: TButton
      Left = 249
      Top = 19
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1091#1095#1077#1090#1085#1091#1102' '#1079#1072#1087#1080#1089#1100
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object EditRole: TEdit
      Left = 104
      Top = 46
      Width = 140
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object ButtonRole: TButton
      Left = 249
      Top = 46
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1088#1086#1083#1100
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
  end
  inherited PanelButton: TPanel
    Top = 100
    Width = 322
    inherited ButtonCancel: TButton
      Left = 238
    end
    inherited ButtonOk: TButton
      Left = 156
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
