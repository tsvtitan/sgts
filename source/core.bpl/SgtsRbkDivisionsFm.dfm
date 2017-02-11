inherited SgtsRbkDivisionsForm: TSgtsRbkDivisionsForm
  Left = 551
  Top = 165
  Caption = #1054#1090#1076#1077#1083#1099
  ClientHeight = 429
  Constraints.MinHeight = 475
  ExplicitWidth = 500
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 366
    ExplicitTop = 324
  end
  inherited StatusBar: TStatusBar
    Top = 408
    ExplicitTop = 364
  end
  inherited ToolBar: TToolBar
    Height = 366
    ExplicitWidth = 66
    ExplicitHeight = 322
  end
  inherited PanelView: TPanel
    Height = 366
    ExplicitLeft = 66
    ExplicitWidth = 426
    ExplicitHeight = 322
    object Splitter: TSplitter [0]
      Left = 3
      Top = 295
      Width = 451
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 253
      ExplicitWidth = 376
    end
    inherited TreePattern: TTreeView
      Height = 292
      ExplicitWidth = 420
      ExplicitHeight = 248
    end
    object PanelInfo: TPanel
      Left = 3
      Top = 298
      Width = 451
      Height = 65
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 254
      ExplicitWidth = 420
      object GroupBoxInfo: TGroupBox
        Left = 0
        Top = 0
        Width = 451
        Height = 65
        Align = alClient
        Caption = ' '#1054#1087#1080#1089#1072#1085#1080#1077' '
        TabOrder = 0
        ExplicitWidth = 420
        object PanelNote: TPanel
          Left = 2
          Top = 15
          Width = 447
          Height = 48
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          ExplicitWidth = 416
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
            ExplicitWidth = 406
          end
        end
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 369
    ExplicitTop = 325
  end
  inherited MainMenu: TMainMenu
    Left = 64
  end
  inherited ImageList: TImageList
    Left = 104
    Top = 58
  end
  inherited PopupMenuView: TPopupMenu
    Left = 184
    Top = 98
  end
  inherited PopupMenuFilter: TPopupMenu
    Top = 138
  end
  inherited PopupMenuReport: TPopupMenu
    Left = 264
  end
  inherited ImageListTree: TImageList
    Left = 104
    Top = 170
  end
  inherited DataSource: TDataSource
    Left = 328
  end
  inherited PopupMenuInsert: TPopupMenu
    Left = 203
    Top = 200
  end
end
