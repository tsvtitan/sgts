inherited SgtsRbkAccountEditForm: TSgtsRbkAccountEditForm
  Left = 549
  Top = 218
  Width = 350
  Height = 346
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
  Constraints.MinHeight = 210
  Constraints.MinWidth = 310
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 281
    Width = 342
  end
  inherited ToolBar: TToolBar
    Height = 242
  end
  inherited PanelEdit: TPanel
    Width = 307
    Height = 242
    object LabelName: TLabel
      Left = 10
      Top = 16
      Width = 84
      Height = 13
      Alignment = taRightJustify
      Caption = #1059#1095#1077#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100':'
      FocusControl = EditName
    end
    object LabelPass: TLabel
      Left = 53
      Top = 42
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1072#1088#1086#1083#1100':'
      FocusControl = EditPass
    end
    object LabelPersonnel: TLabel
      Left = 48
      Top = 68
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1077#1088#1089#1086#1085#1072':'
      FocusControl = EditPersonnel
    end
    object EditName: TEdit
      Left = 102
      Top = 12
      Width = 193
      Height = 21
      TabOrder = 0
      Text = #1053#1086#1074#1072#1103' '#1091#1095#1077#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100
    end
    object EditPass: TEdit
      Left = 102
      Top = 38
      Width = 193
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
    object EditPersonnel: TEdit
      Left = 102
      Top = 64
      Width = 166
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object ButtonPersonnel: TButton
      Left = 274
      Top = 64
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1077#1088#1089#1086#1085#1091
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object GroupBoxRoles: TGroupBox
      Left = 101
      Top = 93
      Width = 193
      Height = 116
      Caption = ' '#1044#1086#1089#1090#1091#1087#1085#1099#1077' '#1088#1086#1083#1080' '
      TabOrder = 4
      object PanelRoles: TPanel
        Left = 2
        Top = 15
        Width = 189
        Height = 99
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        Caption = #1053#1077#1090' '#1076#1086#1089#1090#1091#1087#1085#1099#1093' '#1088#1086#1083#1077#1081
        TabOrder = 0
        object CheckListBoxRoles: TCheckListBox
          Left = 5
          Top = 5
          Width = 179
          Height = 89
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
          OnClick = CheckListBoxRolesClick
        end
      end
    end
    object ButtonAdjustment: TButton
      Left = 111
      Top = 216
      Width = 174
      Height = 25
      Caption = #1055#1088#1086#1092#1080#1083#1100
      TabOrder = 5
      OnClick = ButtonAdjustmentClick
    end
  end
  inherited PanelButton: TPanel
    Top = 242
    Width = 342
    DesignSize = (
      342
      39)
    inherited ButtonCancel: TButton
      Left = 261
    end
    inherited ButtonOk: TButton
      Left = 179
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
