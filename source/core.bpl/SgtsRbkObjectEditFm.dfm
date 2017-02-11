inherited SgtsRbkObjectEditForm: TSgtsRbkObjectEditForm
  Left = 426
  Top = 226
  Width = 320
  Height = 264
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072
  Constraints.MinHeight = 240
  Constraints.MinWidth = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 199
    Width = 312
  end
  inherited ToolBar: TToolBar
    Height = 160
  end
  inherited PanelEdit: TPanel
    Width = 277
    Height = 160
    object LabelName: TLabel
      Left = 7
      Top = 16
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = #1048#1084#1103' '#1086#1073#1098#1077#1082#1090#1072':'
      FocusControl = EditName
    end
    object LabelNote: TLabel
      Left = 23
      Top = 67
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
      FocusControl = MemoNote
    end
    object LabelShortName: TLabel
      Left = 29
      Top = 42
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = #1050#1088#1072#1090#1082#1086#1077':'
      FocusControl = EditShortName
    end
    object EditName: TEdit
      Left = 84
      Top = 12
      Width = 184
      Height = 21
      TabOrder = 0
      Text = #1053#1086#1074#1099#1081' '#1086#1073#1098#1077#1082#1090
    end
    object MemoNote: TMemo
      Left = 84
      Top = 64
      Width = 184
      Height = 89
      TabOrder = 2
    end
    object EditShortName: TEdit
      Left = 84
      Top = 38
      Width = 184
      Height = 21
      TabOrder = 1
    end
  end
  inherited PanelButton: TPanel
    Top = 160
    Width = 312
    inherited ButtonCancel: TButton
      Left = 231
    end
    inherited ButtonOk: TButton
      Left = 149
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
  end
  inherited ImageList: TImageList
    Left = 208
  end
end
