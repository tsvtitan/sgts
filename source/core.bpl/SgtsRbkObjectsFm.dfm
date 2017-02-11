inherited SgtsRbkObjectsForm: TSgtsRbkObjectsForm
  Left = 561
  Top = 167
  Caption = #1054#1073#1098#1077#1082#1090#1099' '#1085#1072#1073#1083#1102#1076#1077#1085#1080#1081
  ClientHeight = 429
  ClientWidth = 482
  Constraints.MinHeight = 475
  Constraints.MinWidth = 490
  ExplicitWidth = 490
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 364
    Width = 482
    ExplicitTop = 358
    ExplicitWidth = 482
  end
  inherited StatusBar: TStatusBar
    Top = 406
    Width = 482
    Height = 23
    ExplicitTop = 381
    ExplicitWidth = 482
    ExplicitHeight = 23
  end
  inherited ToolBar: TToolBar
    Height = 364
    ExplicitWidth = 66
    ExplicitHeight = 339
  end
  inherited PanelView: TPanel
    Width = 447
    Height = 364
    ExplicitLeft = 66
    ExplicitWidth = 416
    ExplicitHeight = 339
    object Splitter: TSplitter [0]
      Left = 3
      Top = 203
      Width = 441
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      MinSize = 155
      ExplicitTop = 197
    end
    inherited GridPattern: TDBGrid
      Width = 441
      Height = 200
    end
    object PanelInfo: TPanel
      Left = 3
      Top = 206
      Width = 441
      Height = 155
      Align = alBottom
      BevelOuter = bvNone
      Constraints.MinHeight = 155
      TabOrder = 1
      ExplicitTop = 181
      ExplicitWidth = 410
      object SplitterDescription: TSplitter
        Left = 0
        Top = 75
        Width = 441
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        MinSize = 70
      end
      object GroupBoxInfo: TGroupBox
        Left = 0
        Top = 78
        Width = 441
        Height = 77
        Align = alBottom
        Caption = ' '#1054#1087#1080#1089#1072#1085#1080#1077' '
        Constraints.MinHeight = 77
        TabOrder = 1
        ExplicitWidth = 410
        object PanelNote: TPanel
          Left = 2
          Top = 15
          Width = 437
          Height = 60
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          ExplicitWidth = 406
          object DBMemoDescription: TDBMemo
            Left = 5
            Top = 5
            Width = 427
            Height = 50
            Align = alClient
            Color = clBtnFace
            DataField = 'DESCRIPTION'
            DataSource = DataSource
            ReadOnly = True
            TabOrder = 0
            ExplicitWidth = 396
          end
        end
      end
      object GroupBoxPath: TGroupBox
        Left = 0
        Top = 0
        Width = 441
        Height = 75
        Align = alClient
        Caption = ' '#1056#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072'  '
        TabOrder = 0
        ExplicitWidth = 410
        object PanelPath: TPanel
          Left = 2
          Top = 15
          Width = 437
          Height = 58
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          ExplicitWidth = 406
          object MemoPaths: TMemo
            Left = 5
            Top = 5
            Width = 427
            Height = 48
            Align = alClient
            Color = clBtnFace
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
            WordWrap = False
            ExplicitWidth = 396
          end
        end
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 367
    Width = 482
    ExplicitTop = 342
    ExplicitWidth = 482
    inherited ButtonCancel: TButton
      Left = 401
      ExplicitLeft = 401
    end
    inherited ButtonOk: TButton
      Left = 319
      ExplicitLeft = 319
    end
  end
end
