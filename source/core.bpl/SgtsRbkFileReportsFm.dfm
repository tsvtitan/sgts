inherited SgtsRbkFileReportsForm: TSgtsRbkFileReportsForm
  Caption = #1060#1072#1081#1083#1086#1074#1099#1077' '#1086#1090#1095#1077#1090#1099
  ClientHeight = 429
  ClientWidth = 482
  Constraints.MinHeight = 475
  Constraints.MinWidth = 490
  ExplicitWidth = 490
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 426
    Width = 482
    ExplicitWidth = 482
  end
  inherited StatusBar: TStatusBar
    Top = 405
    Width = 482
    ExplicitTop = 395
    ExplicitWidth = 482
  end
  inherited ToolBar: TToolBar
    Height = 366
    ExplicitHeight = 356
  end
  inherited PanelView: TPanel
    Width = 447
    Height = 366
    ExplicitWidth = 447
    ExplicitHeight = 356
    object Splitter: TSplitter [0]
      Left = 3
      Top = 295
      Width = 441
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 287
    end
    inherited GridPattern: TDBGrid
      Width = 441
      Height = 292
    end
    object PanelInfo: TPanel
      Left = 3
      Top = 298
      Width = 441
      Height = 65
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 288
      object GroupBoxInfo: TGroupBox
        Left = 0
        Top = 0
        Width = 441
        Height = 65
        Align = alClient
        Caption = ' '#1054#1087#1080#1089#1072#1085#1080#1077' '
        TabOrder = 0
        object PanelNote: TPanel
          Left = 2
          Top = 15
          Width = 437
          Height = 48
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          object DBMemoNote: TDBMemo
            Left = 5
            Top = 5
            Width = 427
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
    Width = 482
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
