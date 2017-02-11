object SgtsMemoForm: TSgtsMemoForm
  Left = 480
  Top = 391
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1090#1077#1082#1089#1090#1072
  ClientHeight = 273
  ClientWidth = 442
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    442
    273)
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonOk: TButton
    Left = 278
    Top = 240
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object ButtonCancel: TButton
    Left = 359
    Top = 240
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 426
    Height = 222
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 0
  end
end
