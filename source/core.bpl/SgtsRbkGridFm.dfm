inherited SgtsRbkGridForm: TSgtsRbkGridForm
  Width = 400
  Height = 383
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1083#1080#1085#1077#1081#1085#1099#1081
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 318
    Width = 392
  end
  inherited ToolBar: TToolBar
    Height = 318
  end
  inherited PanelView: TPanel
    Width = 357
    Height = 318
    object GridPattern: TDBGrid
      Left = 3
      Top = 3
      Width = 351
      Height = 312
      Align = alClient
      PopupMenu = PopupMenuView
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
end
