inherited SgtsRbkObjectPassportsForm: TSgtsRbkObjectPassportsForm
  Left = 485
  Top = 210
  Caption = #1055#1072#1089#1087#1086#1088#1090#1072' '#1086#1073#1098#1077#1082#1090#1086#1074
  ClientHeight = 429
  ClientWidth = 452
  Constraints.MinHeight = 475
  Constraints.MinWidth = 460
  ExplicitWidth = 460
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 366
    Width = 452
    ExplicitTop = 329
    ExplicitWidth = 452
  end
  inherited StatusBar: TStatusBar
    Top = 408
    Width = 452
    ExplicitTop = 369
    ExplicitWidth = 452
  end
  inherited ToolBar: TToolBar
    Height = 366
    ExplicitWidth = 66
    ExplicitHeight = 327
  end
  inherited PanelView: TPanel
    Width = 417
    Height = 366
    ExplicitLeft = 66
    ExplicitWidth = 386
    ExplicitHeight = 327
    object Splitter: TSplitter [0]
      Left = 3
      Top = 295
      Width = 411
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 258
    end
    inherited GridPattern: TDBGrid
      Width = 411
      Height = 292
    end
    object PanelInfo: TPanel
      Left = 3
      Top = 298
      Width = 411
      Height = 65
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 259
      ExplicitWidth = 380
      object GroupBoxInfo: TGroupBox
        Left = 0
        Top = 0
        Width = 411
        Height = 65
        Align = alClient
        Caption = ' '#1054#1087#1080#1089#1072#1085#1080#1077' '
        TabOrder = 0
        ExplicitWidth = 380
        object PanelNote: TPanel
          Left = 2
          Top = 15
          Width = 407
          Height = 48
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          ExplicitWidth = 376
          object DBMemoNote: TDBMemo
            Left = 5
            Top = 5
            Width = 397
            Height = 38
            Align = alClient
            Color = clBtnFace
            DataField = 'DESCRIPTION'
            DataSource = DataSource
            ReadOnly = True
            TabOrder = 0
            ExplicitWidth = 366
          end
        end
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 369
    Width = 452
    ExplicitTop = 330
    ExplicitWidth = 452
    inherited ButtonCancel: TButton
      Left = 371
      ExplicitLeft = 371
    end
    inherited ButtonOk: TButton
      Left = 289
      ExplicitLeft = 289
    end
  end
end
