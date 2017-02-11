inherited SgtsRbkInstrumentPassportsForm: TSgtsRbkInstrumentPassportsForm
  Left = 391
  Top = 158
  Caption = #1055#1072#1089#1087#1086#1088#1090#1072' '#1087#1088#1080#1073#1086#1088#1086#1074
  ClientHeight = 429
  ClientWidth = 532
  Constraints.MinHeight = 475
  Constraints.MinWidth = 540
  ExplicitWidth = 540
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 426
    Width = 532
    ExplicitWidth = 532
  end
  inherited StatusBar: TStatusBar
    Top = 405
    Width = 532
    ExplicitTop = 395
    ExplicitWidth = 532
  end
  inherited ToolBar: TToolBar
    Height = 366
    ExplicitHeight = 356
  end
  inherited PanelView: TPanel
    Width = 497
    Height = 366
    ExplicitWidth = 497
    ExplicitHeight = 356
    object Splitter: TSplitter [0]
      Left = 3
      Top = 295
      Width = 491
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 287
    end
    inherited GridPattern: TDBGrid
      Width = 491
      Height = 292
    end
    object PanelInfo: TPanel
      Left = 3
      Top = 298
      Width = 491
      Height = 65
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 288
      object GroupBoxInfo: TGroupBox
        Left = 0
        Top = 0
        Width = 491
        Height = 65
        Align = alClient
        Caption = ' '#1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081' '
        TabOrder = 0
        object PanelNote: TPanel
          Left = 2
          Top = 15
          Width = 487
          Height = 48
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          object DBMemoNote: TDBMemo
            Left = 5
            Top = 5
            Width = 477
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
    Width = 532
    ExplicitWidth = 532
    inherited ButtonCancel: TButton
      Left = 451
      ExplicitLeft = 451
    end
    inherited ButtonOk: TButton
      Left = 369
      ExplicitLeft = 369
    end
  end
end
