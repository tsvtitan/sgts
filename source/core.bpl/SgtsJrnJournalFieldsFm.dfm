inherited SgtsJrnJournalFieldsForm: TSgtsJrnJournalFieldsForm
  Left = 410
  Top = 203
  Caption = #1055#1086#1083#1077#1074#1086#1081' '#1078#1091#1088#1085#1072#1083
  ClientHeight = 429
  ClientWidth = 592
  Constraints.MinHeight = 475
  Constraints.MinWidth = 600
  ExplicitWidth = 600
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 426
    Width = 592
    ExplicitWidth = 592
  end
  inherited StatusBar: TStatusBar
    Top = 405
    Width = 592
    ExplicitTop = 395
    ExplicitWidth = 592
  end
  inherited ToolBar: TToolBar
    Height = 366
    ExplicitHeight = 356
  end
  inherited PanelView: TPanel
    Width = 557
    Height = 366
    ExplicitWidth = 557
    ExplicitHeight = 356
    object BevelInfo: TBevel [0]
      Left = 3
      Top = 284
      Width = 551
      Height = 3
      Align = alBottom
      Shape = bsSpacer
      ExplicitTop = 246
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
      Height = 229
    end
    object PanelInfo: TPanel
      Left = 3
      Top = 287
      Width = 551
      Height = 76
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 277
      object GroupBoxInfo: TGroupBox
        Left = 0
        Top = 0
        Width = 551
        Height = 76
        Align = alClient
        Caption = ' '#1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086' '
        TabOrder = 0
        object PanelNote: TPanel
          Left = 2
          Top = 15
          Width = 547
          Height = 59
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          object LabelWhoEnter: TLabel
            Left = 30
            Top = 8
            Width = 50
            Height = 13
            Alignment = taRightJustify
            Caption = #1050#1090#1086' '#1074#1074#1077#1083':'
            FocusControl = DBEditWhoEnter
          end
          object LabelDateEnter: TLabel
            Left = 341
            Top = 8
            Width = 64
            Height = 13
            Alignment = taRightJustify
            Caption = #1044#1072#1090#1072' '#1074#1074#1086#1076#1072':'
            FocusControl = DBEditDateEnter
          end
          object LabelWhoConfirm: TLabel
            Left = 5
            Top = 34
            Width = 75
            Height = 13
            Alignment = taRightJustify
            Caption = #1050#1090#1086' '#1091#1090#1074#1077#1088#1076#1080#1083':'
            FocusControl = DBEditWhoConfirm
          end
          object LabelDateConfirm: TLabel
            Left = 303
            Top = 34
            Width = 102
            Height = 13
            Alignment = taRightJustify
            Caption = #1044#1072#1090#1072' '#1091#1090#1074#1077#1088#1078#1076#1077#1085#1080#1103':'
            FocusControl = DBEditDateConfirm
          end
          object DBEditWhoEnter: TDBEdit
            Left = 87
            Top = 4
            Width = 209
            Height = 21
            Color = clBtnFace
            DataField = 'WHO_ENTER_NAME'
            DataSource = DataSource
            ReadOnly = True
            TabOrder = 0
          end
          object DBEditDateEnter: TDBEdit
            Left = 412
            Top = 4
            Width = 65
            Height = 21
            Color = clBtnFace
            DataField = 'DATE_ENTER'
            DataSource = DataSource
            ReadOnly = True
            TabOrder = 1
          end
          object DBEditWhoConfirm: TDBEdit
            Left = 87
            Top = 30
            Width = 209
            Height = 21
            Color = clBtnFace
            DataField = 'WHO_CONFIRM_NAME'
            DataSource = DataSource
            ReadOnly = True
            TabOrder = 2
          end
          object DBEditDateConfirm: TDBEdit
            Left = 412
            Top = 30
            Width = 65
            Height = 21
            Color = clBtnFace
            DataField = 'DATE_CONFIRM'
            DataSource = DataSource
            ReadOnly = True
            TabOrder = 3
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
      object GroupBoxFiilter: TGroupBox
        Left = 0
        Top = 0
        Width = 551
        Height = 47
        Align = alClient
        Caption = ' '#1060#1080#1083#1100#1090#1088' '
        TabOrder = 0
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
    Top = 366
    Width = 592
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
