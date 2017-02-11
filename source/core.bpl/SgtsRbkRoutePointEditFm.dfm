inherited SgtsRbkRoutePointEditForm: TSgtsRbkRoutePointEditForm
  Left = 471
  Top = 308
  Width = 321
  Height = 199
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1086#1095#1082#1080' '#1084#1072#1088#1096#1088#1091#1090#1072
  Constraints.MinHeight = 160
  Constraints.MinWidth = 300
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 134
    Width = 313
  end
  inherited ToolBar: TToolBar
    Height = 95
  end
  inherited PanelEdit: TPanel
    Width = 278
    Height = 95
    object LabelRoute: TLabel
      Left = 13
      Top = 23
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Caption = #1052#1072#1088#1096#1088#1091#1090':'
      FocusControl = EditRoute
    end
    object LabelPoint: TLabel
      Left = 28
      Top = 50
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = #1058#1086#1095#1082#1072':'
      FocusControl = EditPoint
      WordWrap = True
    end
    object LabelPriority: TLabel
      Left = 71
      Top = 77
      Width = 85
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1086#1088#1103#1076#1086#1082' '#1086#1073#1093#1086#1076#1072':'
      FocusControl = EditPriority
    end
    object EditRoute: TEdit
      Left = 71
      Top = 19
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonRoute: TButton
      Left = 248
      Top = 19
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1084#1072#1088#1096#1088#1091#1090
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object EditPoint: TEdit
      Left = 71
      Top = 46
      Width = 171
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object ButtonPoint: TButton
      Left = 248
      Top = 46
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1091#1102' '#1090#1086#1095#1082#1091
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object EditPriority: TEdit
      Left = 164
      Top = 73
      Width = 78
      Height = 21
      TabOrder = 4
    end
  end
  inherited PanelButton: TPanel
    Top = 95
    Width = 313
    inherited ButtonCancel: TButton
      Left = 229
    end
    inherited ButtonOk: TButton
      Left = 147
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
