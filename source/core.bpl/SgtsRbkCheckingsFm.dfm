inherited SgtsRbkCheckingsForm: TSgtsRbkCheckingsForm
  Left = 508
  Top = 294
  Caption = #1050#1086#1085#1090#1088#1086#1083#1100
  ClientHeight = 429
  ClientWidth = 592
  Constraints.MinHeight = 475
  Constraints.MinWidth = 600
  ExplicitWidth = 600
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 426
    Width = 592
    ExplicitWidth = 592
  end
  inherited StatusBar: TStatusBar
    Top = 405
    Width = 592
    ExplicitTop = 395
    ExplicitWidth = 592
  end
  inherited ToolBar: TToolBar
    Height = 366
    ExplicitHeight = 356
  end
  inherited PanelView: TPanel
    Width = 557
    Height = 366
    ExplicitWidth = 557
    ExplicitHeight = 356
    object Splitter: TSplitter [0]
      Left = 3
      Top = 295
      Width = 551
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 257
    end
    inherited GridPattern: TDBGrid
      Width = 551
      Height = 292
    end
    object PanelInfo: TPanel
      Left = 3
      Top = 298
      Width = 551
      Height = 65
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 288
      object GroupBoxInfo: TGroupBox
        Left = 0
        Top = 0
        Width = 551
        Height = 65
        Align = alClient
        Caption = ' '#1054#1087#1080#1089#1072#1085#1080#1077' '
        TabOrder = 0
        object PanelNote: TPanel
          Left = 2
          Top = 15
          Width = 547
          Height = 48
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          object DBMemoNote: TDBMemo
            Left = 5
            Top = 5
            Width = 537
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
    Width = 592
    ExplicitWidth = 592
    inherited ButtonCancel: TButton
      Left = 511
      ExplicitLeft = 511
    end
    inherited ButtonOk: TButton
      Left = 429
      ExplicitLeft = 429
    end
  end
end
