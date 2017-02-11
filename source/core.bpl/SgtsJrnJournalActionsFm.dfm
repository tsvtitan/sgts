inherited SgtsJrnJournalActionsForm: TSgtsJrnJournalActionsForm
  Left = 410
  Top = 203
  Caption = #1046#1091#1088#1085#1072#1083' '#1076#1077#1081#1089#1090#1074#1080#1081
  ClientHeight = 429
  ClientWidth = 592
  Constraints.MinHeight = 475
  Constraints.MinWidth = 600
  ExplicitWidth = 600
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 366
    Width = 592
    ExplicitTop = 328
    ExplicitWidth = 592
  end
  inherited StatusBar: TStatusBar
    Top = 408
    Width = 592
    ExplicitTop = 368
    ExplicitWidth = 592
  end
  inherited ToolBar: TToolBar
    Height = 366
    ExplicitWidth = 66
    ExplicitHeight = 326
  end
  inherited PanelView: TPanel
    Width = 557
    Height = 366
    ExplicitLeft = 66
    ExplicitWidth = 526
    ExplicitHeight = 326
    object BevelInfo: TBevel [0]
      Left = 3
      Top = 283
      Width = 551
      Height = 3
      Align = alBottom
      Shape = bsSpacer
      ExplicitTop = 245
    end
    object BevelFilter: TBevel [1]
      Left = 3
      Top = 50
      Width = 551
      Height = 5
      Align = alTop
      Shape = bsSpacer
    end
    inherited GridPattern: TDBGrid
      Top = 55
      Width = 551
      Height = 228
    end
    object PanelInfo: TPanel
      Left = 3
      Top = 286
      Width = 551
      Height = 77
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 246
      ExplicitWidth = 520
      object GroupBoxValue: TGroupBox
        Left = 0
        Top = 0
        Width = 551
        Height = 77
        Align = alClient
        Caption = ' '#1047#1085#1072#1095#1077#1085#1080#1077' '
        TabOrder = 0
        ExplicitWidth = 520
        object PanelValue: TPanel
          Left = 2
          Top = 15
          Width = 547
          Height = 60
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          ExplicitWidth = 516
          object DBMemoValue: TDBMemo
            Left = 5
            Top = 5
            Width = 537
            Height = 50
            Align = alClient
            Color = clBtnFace
            DataField = 'VALUE'
            DataSource = DataSource
            ReadOnly = True
            TabOrder = 0
            ExplicitWidth = 506
          end
        end
      end
    end
    object PanelFilter: TPanel
      Left = 3
      Top = 3
      Width = 551
      Height = 47
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitWidth = 520
      object GroupBoxFiilter: TGroupBox
        Left = 0
        Top = 0
        Width = 551
        Height = 47
        Align = alClient
        Caption = ' '#1060#1080#1083#1100#1090#1088' '
        TabOrder = 0
        ExplicitWidth = 520
        object LabelDateFrom: TLabel
          Left = 11
          Top = 20
          Width = 50
          Height = 13
          Alignment = taRightJustify
          Caption = #1055#1077#1088#1080#1086#1076' '#1089':'
          FocusControl = DateTimePickerFrom
        end
        object LabelDateTo: TLabel
          Left = 164
          Top = 20
          Width = 16
          Height = 13
          Alignment = taRightJustify
          Caption = #1087#1086':'
          FocusControl = DateTimePickerTo
        end
        object DateTimePickerFrom: TDateTimePicker
          Left = 69
          Top = 16
          Width = 87
          Height = 21
          Date = 39032.500084814810000000
          Time = 39032.500084814810000000
          TabOrder = 0
          OnChange = DateTimePickerFromChange
        end
        object DateTimePickerTo: TDateTimePicker
          Left = 188
          Top = 16
          Width = 87
          Height = 21
          Date = 39032.500084814810000000
          Time = 39032.500084814810000000
          TabOrder = 1
          OnChange = DateTimePickerFromChange
        end
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 369
    Width = 592
    ExplicitTop = 329
    ExplicitWidth = 592
    DesignSize = (
      592
      39)
    inherited ButtonCancel: TButton
      Left = 512
      ExplicitLeft = 512
    end
    inherited ButtonOk: TButton
      Left = 430
      ExplicitLeft = 430
    end
  end
end
