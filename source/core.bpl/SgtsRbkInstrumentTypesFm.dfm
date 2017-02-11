inherited SgtsRbkInstrumentTypesForm: TSgtsRbkInstrumentTypesForm
  Caption = #1058#1080#1087#1099' '#1087#1088#1080#1073#1086#1088#1086#1074
  ClientHeight = 429
  Constraints.MinHeight = 475
  ExplicitWidth = 500
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 366
    ExplicitTop = 363
  end
  inherited StatusBar: TStatusBar
    Top = 408
    ExplicitTop = 403
  end
  inherited ToolBar: TToolBar
    Height = 366
    ExplicitHeight = 361
  end
  inherited PanelView: TPanel
    Height = 366
    ExplicitHeight = 361
    object Splitter: TSplitter [0]
      Left = 3
      Top = 295
      Width = 451
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 292
    end
    inherited GridPattern: TDBGrid
      Height = 292
    end
    object PanelInfo: TPanel
      Left = 3
      Top = 298
      Width = 451
      Height = 65
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 293
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
    ExplicitTop = 364
    inherited ButtonCancel: TButton
      Left = 411
      ExplicitLeft = 411
    end
    inherited ButtonOk: TButton
      Left = 329
      ExplicitLeft = 329
    end
  end
end
