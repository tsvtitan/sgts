inherited SgtsRbkRoutesForm: TSgtsRbkRoutesForm
  Left = 419
  Top = 212
  Caption = #1052#1072#1088#1096#1088#1091#1090#1099
  ClientHeight = 424
  ClientWidth = 462
  Constraints.MinHeight = 470
  Constraints.MinWidth = 470
  ExplicitWidth = 470
  ExplicitHeight = 470
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 361
    Width = 462
    ExplicitTop = 328
    ExplicitWidth = 457
  end
  inherited StatusBar: TStatusBar
    Top = 403
    Width = 462
    ExplicitTop = 368
    ExplicitWidth = 457
  end
  inherited ToolBar: TToolBar
    Height = 361
    ExplicitWidth = 66
    ExplicitHeight = 326
  end
  inherited PanelView: TPanel
    Width = 427
    Height = 361
    ExplicitLeft = 66
    ExplicitWidth = 391
    ExplicitHeight = 326
    object Splitter: TSplitter [0]
      Left = 3
      Top = 289
      Width = 421
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 256
      ExplicitWidth = 416
    end
    inherited GridPattern: TDBGrid
      Width = 421
      Height = 286
    end
    object PanelInfo: TPanel
      Left = 3
      Top = 292
      Width = 421
      Height = 66
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 257
      ExplicitWidth = 385
      object GroupBoxInfo: TGroupBox
        Left = 0
        Top = 0
        Width = 421
        Height = 66
        Align = alClient
        Caption = ' '#1054#1087#1080#1089#1072#1085#1080#1077' '
        TabOrder = 0
        ExplicitWidth = 385
        object PanelNote: TPanel
          Left = 2
          Top = 15
          Width = 417
          Height = 49
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          ExplicitWidth = 381
          object DBMemoDescription: TDBMemo
            Left = 5
            Top = 5
            Width = 407
            Height = 39
            Align = alClient
            Color = clBtnFace
            DataField = 'DESCRIPTION'
            DataSource = DataSource
            ReadOnly = True
            TabOrder = 0
            ExplicitWidth = 371
          end
        end
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 364
    Width = 462
    ExplicitTop = 329
    ExplicitWidth = 457
    inherited ButtonCancel: TButton
      Left = 381
      ExplicitLeft = 376
    end
    inherited ButtonOk: TButton
      Left = 299
      ExplicitLeft = 294
    end
  end
end
