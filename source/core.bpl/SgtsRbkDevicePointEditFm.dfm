inherited SgtsRbkDevicePointEditForm: TSgtsRbkDevicePointEditForm
  Left = 471
  Top = 308
  Width = 332
  Height = 201
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1086#1095#1082#1080' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
  Constraints.MinHeight = 160
  Constraints.MinWidth = 300
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 136
    Width = 324
  end
  inherited ToolBar: TToolBar
    Width = 35
    Height = 97
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
    Width = 289
    Height = 97
    object LabelPoint: TLabel
      Left = 37
      Top = 48
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = #1058#1086#1095#1082#1072':'
      FocusControl = EditPoint
    end
    object LabelDevice: TLabel
      Left = 7
      Top = 21
      Width = 63
      Height = 13
      Alignment = taRightJustify
      Caption = #1059#1089#1090#1088#1086#1081#1089#1090#1074#1086':'
      FocusControl = EditDevice
      WordWrap = True
    end
    object LabelPriority: TLabel
      Left = 118
      Top = 75
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1086#1088#1103#1076#1086#1082':'
      FocusControl = EditPriority
    end
    object EditPoint: TEdit
      Left = 80
      Top = 44
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object ButtonPoint: TButton
      Left = 257
      Top = 44
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1091#1102' '#1090#1086#1095#1082#1091
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object EditDevice: TEdit
      Left = 80
      Top = 17
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonDevice: TButton
      Left = 257
      Top = 17
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1086
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object EditPriority: TEdit
      Left = 173
      Top = 71
      Width = 78
      Height = 21
      TabOrder = 4
    end
  end
  inherited PanelButton: TPanel
    Top = 97
    Width = 324
    inherited ButtonCancel: TButton
      Left = 240
    end
    inherited ButtonOk: TButton
      Left = 158
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
