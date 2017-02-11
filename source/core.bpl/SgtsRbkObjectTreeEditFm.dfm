inherited SgtsRbkObjectTreeEditForm: TSgtsRbkObjectTreeEditForm
  Left = 533
  Top = 199
  Width = 390
  Height = 210
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1091#1079#1083#1072' '#1076#1077#1088#1077#1074#1072' '#1086#1073#1098#1077#1082#1090#1086#1074
  Constraints.MinHeight = 210
  Constraints.MinWidth = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 145
    Width = 382
  end
  inherited ToolBar: TToolBar
    Height = 106
  end
  inherited PanelEdit: TPanel
    Width = 347
    Height = 106
    object LabelParent: TLabel
      Left = 4
      Top = 22
      Width = 86
      Height = 13
      Alignment = taRightJustify
      Caption = #1042#1077#1088#1093#1085#1080#1081' '#1086#1073#1098#1077#1082#1090':'
      FocusControl = EditParent
    end
    object LabelObject: TLabel
      Left = 47
      Top = 49
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1073#1098#1077#1082#1090':'
      FocusControl = EditObject
    end
    object LabelPriority: TLabel
      Left = 176
      Top = 76
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1086#1088#1103#1076#1086#1082':'
      FocusControl = EditPriority
    end
    object EditParent: TEdit
      Left = 98
      Top = 18
      Width = 212
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonParent: TButton
      Left = 317
      Top = 18
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1074#1077#1088#1093#1085#1080#1081' '#1086#1073#1098#1077#1082#1090
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object EditObject: TEdit
      Left = 98
      Top = 45
      Width = 212
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object ButtonObject: TButton
      Left = 317
      Top = 45
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1086#1073#1098#1077#1082#1090
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object EditPriority: TEdit
      Left = 232
      Top = 72
      Width = 78
      Height = 21
      TabOrder = 4
    end
  end
  inherited PanelButton: TPanel
    Top = 106
    Width = 382
    inherited ButtonCancel: TButton
      Left = 301
    end
    inherited ButtonOk: TButton
      Left = 219
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
