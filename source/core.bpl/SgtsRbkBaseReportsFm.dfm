inherited SgtsRbkBaseReportsForm: TSgtsRbkBaseReportsForm
  Caption = #1041#1072#1079#1086#1074#1099#1077' '#1086#1090#1095#1077#1090#1099
  ClientHeight = 429
  ClientWidth = 692
  Constraints.MinHeight = 475
  Constraints.MinWidth = 700
  ExplicitWidth = 700
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 426
    Width = 692
    ExplicitWidth = 692
  end
  inherited StatusBar: TStatusBar
    Top = 405
    Width = 692
    ExplicitTop = 395
    ExplicitWidth = 692
  end
  inherited ToolBar: TToolBar
    Height = 366
    ExplicitHeight = 356
  end
  inherited PanelView: TPanel
    Width = 657
    Height = 366
    ExplicitWidth = 657
    ExplicitHeight = 356
    object Splitter: TSplitter [0]
      Left = 3
      Top = 295
      Width = 651
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 287
    end
    inherited GridPattern: TDBGrid
      Width = 651
      Height = 292
    end
    object PanelInfo: TPanel
      Left = 3
      Top = 298
      Width = 651
      Height = 65
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 288
      object GroupBoxInfo: TGroupBox
        Left = 0
        Top = 0
        Width = 651
        Height = 65
        Align = alClient
        Caption = ' '#1054#1087#1080#1089#1072#1085#1080#1077' '
        TabOrder = 0
        object PanelNote: TPanel
          Left = 2
          Top = 15
          Width = 647
          Height = 48
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          object DBMemoNote: TDBMemo
            Left = 5
            Top = 5
            Width = 637
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
    Width = 692
    ExplicitWidth = 692
    inherited ButtonCancel: TButton
      Left = 611
      ExplicitLeft = 611
    end
    inherited ButtonOk: TButton
      Left = 529
      ExplicitLeft = 529
    end
  end
end
