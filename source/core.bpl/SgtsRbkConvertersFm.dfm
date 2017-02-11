inherited SgtsRbkConvertersForm: TSgtsRbkConvertersForm
  Left = 509
  Top = 169
  Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1077#1083#1080
  ClientHeight = 429
  Constraints.MinHeight = 475
  ExplicitWidth = 500
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 426
  end
  inherited StatusBar: TStatusBar
    Top = 405
    ExplicitTop = 395
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
      ExplicitTop = 287
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
    Top = 366
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
