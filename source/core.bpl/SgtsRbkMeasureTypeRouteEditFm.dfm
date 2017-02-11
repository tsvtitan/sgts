inherited SgtsRbkMeasureTypeRouteEditForm: TSgtsRbkMeasureTypeRouteEditForm
  Left = 471
  Top = 308
  Width = 344
  Height = 199
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1074#1080#1076#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' '#1084#1072#1088#1096#1088#1091#1090#1072
  Constraints.MinHeight = 160
  Constraints.MinWidth = 300
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 134
    Width = 336
  end
  inherited ToolBar: TToolBar
    Width = 35
    Height = 95
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
    Width = 301
    Height = 95
    object LabelMeasureType: TLabel
      Left = 6
      Top = 23
      Width = 81
      Height = 13
      Alignment = taRightJustify
      Caption = #1042#1080#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
      FocusControl = EditMeasureType
    end
    object LabelRoute: TLabel
      Left = 39
      Top = 50
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Caption = #1052#1072#1088#1096#1088#1091#1090':'
      FocusControl = EditRoute
      WordWrap = True
    end
    object LabelPriority: TLabel
      Left = 135
      Top = 77
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1086#1088#1103#1076#1086#1082':'
      FocusControl = EditPriority
    end
    object EditMeasureType: TEdit
      Left = 97
      Top = 19
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonMeasureType: TButton
      Left = 274
      Top = 19
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1074#1080#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object EditRoute: TEdit
      Left = 97
      Top = 46
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object ButtonRoute: TButton
      Left = 274
      Top = 46
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1084#1072#1088#1096#1088#1091#1090
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object EditPriority: TEdit
      Left = 190
      Top = 73
      Width = 78
      Height = 21
      TabOrder = 4
    end
  end
  inherited PanelButton: TPanel
    Top = 95
    Width = 336
    inherited ButtonCancel: TButton
      Left = 252
    end
    inherited ButtonOk: TButton
      Left = 170
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
