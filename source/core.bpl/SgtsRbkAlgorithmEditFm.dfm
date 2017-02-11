inherited SgtsRbkAlgorithmEditForm: TSgtsRbkAlgorithmEditForm
  Left = 426
  Top = 226
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeable
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1072#1083#1075#1086#1088#1080#1090#1084#1072
  ClientHeight = 304
  ClientWidth = 492
  Constraints.MinHeight = 350
  Constraints.MinWidth = 500
  ExplicitLeft = 426
  ExplicitTop = 226
  ExplicitWidth = 500
  ExplicitHeight = 350
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 285
    Width = 492
    ExplicitTop = 198
    ExplicitWidth = 325
  end
  inherited ToolBar: TToolBar
    Height = 246
    ExplicitHeight = 159
  end
  inherited PanelEdit: TPanel
    Width = 457
    Height = 246
    ExplicitWidth = 290
    ExplicitHeight = 159
    object LabelProcName: TLabel
      Left = 4
      Top = 45
      Width = 83
      Height = 13
      Alignment = taRightJustify
      Caption = #1048#1084#1103' '#1087#1088#1086#1094#1077#1076#1091#1088#1099':'
      FocusControl = EditProcName
    end
    object LabelNote: TLabel
      Left = 34
      Top = 72
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
      FocusControl = MemoNote
    end
    object LabelName: TLabel
      Left = 10
      Top = 17
      Width = 77
      Height = 13
      Alignment = taRightJustify
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
      FocusControl = EditName
    end
    object EditProcName: TEdit
      Left = 95
      Top = 41
      Width = 351
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      ExplicitWidth = 184
    end
    object MemoNote: TMemo
      Left = 95
      Top = 69
      Width = 351
      Height = 176
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 2
      ExplicitWidth = 184
      ExplicitHeight = 89
    end
    object EditName: TEdit
      Left = 95
      Top = 13
      Width = 351
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = #1053#1086#1074#1099#1081' '#1072#1083#1075#1086#1088#1080#1090#1084
      ExplicitWidth = 184
    end
  end
  inherited PanelButton: TPanel
    Top = 246
    Width = 492
    ExplicitTop = 159
    ExplicitWidth = 325
    inherited ButtonCancel: TButton
      Left = 411
      ExplicitLeft = 244
    end
    inherited ButtonOk: TButton
      Left = 329
      ExplicitLeft = 162
    end
  end
  inherited MainMenu: TMainMenu
    Left = 168
    Top = 48
  end
  inherited ImageList: TImageList
    Left = 208
    Top = 50
  end
end
