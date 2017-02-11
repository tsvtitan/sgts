inherited SgtsRbkAlgorithmsForm: TSgtsRbkAlgorithmsForm
  Left = 387
  Top = 232
  Caption = #1040#1083#1075#1086#1088#1080#1090#1084#1099
  ClientHeight = 429
  ClientWidth = 632
  Constraints.MinHeight = 475
  Constraints.MinWidth = 640
  ExplicitWidth = 640
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 426
    Width = 632
    ExplicitWidth = 532
  end
  inherited StatusBar: TStatusBar
    Top = 405
    Width = 632
    ExplicitTop = 395
    ExplicitWidth = 632
  end
  inherited ToolBar: TToolBar
    Height = 366
    ExplicitHeight = 356
  end
  inherited PanelView: TPanel
    Width = 597
    Height = 366
    ExplicitWidth = 597
    ExplicitHeight = 356
    object Splitter: TSplitter [0]
      Left = 3
      Top = 295
      Width = 591
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 287
      ExplicitWidth = 491
    end
    inherited GridPattern: TDBGrid
      Width = 591
      Height = 292
    end
    object PanelInfo: TPanel
      Left = 3
      Top = 298
      Width = 591
      Height = 65
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 288
      object GroupBoxInfo: TGroupBox
        Left = 0
        Top = 0
        Width = 591
        Height = 65
        Align = alClient
        Caption = ' '#1054#1087#1080#1089#1072#1085#1080#1077' '
        TabOrder = 0
        object PanelNote: TPanel
          Left = 2
          Top = 15
          Width = 587
          Height = 48
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          object DBMemoNote: TDBMemo
            Left = 5
            Top = 5
            Width = 577
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
    Width = 632
    ExplicitWidth = 632
    inherited ButtonCancel: TButton
      Left = 552
      ExplicitLeft = 552
    end
    inherited ButtonOk: TButton
      Left = 470
      ExplicitLeft = 470
    end
  end
end
