inherited SgtsRbkMeasureTypesForm: TSgtsRbkMeasureTypesForm
  Left = 551
  Top = 165
  Caption = #1042#1080#1076#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1081
  ClientHeight = 429
  Constraints.MinHeight = 475
  ExplicitWidth = 500
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 366
    ExplicitTop = 375
  end
  inherited StatusBar: TStatusBar
    Top = 408
    ExplicitTop = 398
  end
  inherited ToolBar: TToolBar
    Height = 366
    ExplicitHeight = 356
  end
  inherited PanelView: TPanel
    Height = 366
    ExplicitHeight = 356
    object Splitter: TSplitter [0]
      Left = 3
      Top = 295
      Width = 451
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 304
    end
    inherited TreePattern: TTreeView
      Height = 292
      ExplicitHeight = 282
    end
    object PanelInfo: TPanel
      Left = 3
      Top = 298
      Width = 451
      Height = 65
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 288
      object GroupBoxInfo: TGroupBox
        Left = 0
        Top = 0
        Width = 451
        Height = 65
        Align = alClient
        Caption = ' '#1054#1087#1080#1089#1072#1085#1080#1077' '
        TabOrder = 0
        object PanelNote: TPanel
          Left = 2
          Top = 15
          Width = 447
          Height = 48
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          object DBMemoDescription: TDBMemo
            Left = 5
            Top = 5
            Width = 437
            Height = 38
            Align = alClient
            Color = clBtnFace
            DataField = 'DESCRIPTION'
            DataSource = DataSource
            ReadOnly = True
            TabOrder = 0
          end
        end
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 369
    ExplicitTop = 359
  end
end
