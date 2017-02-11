inherited SgtsJrnGridForm: TSgtsJrnGridForm
  Left = 547
  Top = 165
  Caption = #1046#1091#1088#1085#1072#1083
  ClientHeight = 429
  ClientWidth = 467
  Constraints.MinHeight = 475
  Constraints.MinWidth = 475
  ExplicitWidth = 475
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 426
    Width = 467
    ExplicitWidth = 441
  end
  inherited StatusBar: TStatusBar
    Top = 405
    Width = 467
    ExplicitTop = 395
    ExplicitWidth = 441
  end
  inherited ToolBar: TToolBar
    Height = 366
    ExplicitHeight = 356
  end
  inherited PanelView: TPanel
    Width = 432
    Height = 366
    ExplicitWidth = 406
    ExplicitHeight = 356
    inherited GridPattern: TDBGrid
      Width = 426
      Height = 360
    end
  end
  inherited PanelButton: TPanel
    Top = 366
    Width = 467
    ExplicitWidth = 441
    DesignSize = (
      467
      39)
    inherited ButtonCancel: TButton
      Left = 386
      ExplicitLeft = 360
    end
    inherited ButtonOk: TButton
      Left = 304
      ExplicitLeft = 278
    end
  end
  inherited MainMenu: TMainMenu
    inherited MenuData: TMenuItem
      Caption = #1046#1091#1088#1085#1072#1083
    end
  end
end
