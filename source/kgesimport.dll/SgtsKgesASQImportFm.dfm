inherited SgtsKgesASQImportForm: TSgtsKgesASQImportForm
  Left = 419
  Top = 252
  Caption = #1048#1084#1087#1086#1088#1090' '#1080#1079' '#1072#1074#1090#1086#1084#1072#1090#1080#1079#1080#1088#1086#1074#1072#1085#1085#1086#1081' '#1089#1080#1089#1090#1077#1084#1099' '#1086#1087#1088#1086#1089#1072
  ClientHeight = 423
  ClientWidth = 602
  Constraints.MinHeight = 450
  Constraints.MinWidth = 610
  ExplicitLeft = 419
  ExplicitTop = 252
  ExplicitWidth = 610
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 13
  object GridPanel: TGridPanel
    Left = 0
    Top = 0
    Width = 602
    Height = 404
    Align = alClient
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = GroupBoxData
        Row = 0
      end
      item
        Column = 0
        Control = GroupBoxResult
        Row = 1
      end>
    ExpandStyle = emFixedSize
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    TabOrder = 0
    ExplicitLeft = -8
    ExplicitTop = 8
    ExplicitHeight = 423
    object GroupBoxData: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 2
      Width = 592
      Height = 200
      Margins.Left = 5
      Margins.Top = 2
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alClient
      Caption = ' '#1044#1072#1085#1085#1099#1077' '#1086#1087#1088#1086#1089#1072' '
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 600
      ExplicitHeight = 210
      object GridDataPattern: TDBGrid
        AlignWithMargins = True
        Left = 7
        Top = 17
        Width = 578
        Height = 140
        Margins.Left = 5
        Margins.Top = 2
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alClient
        DataSource = DataSourceData
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object PanelData: TPanel
        Left = 2
        Top = 157
        Width = 588
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitLeft = 3
        ExplicitTop = 175
        ExplicitWidth = 590
        DesignSize = (
          588
          41)
        object LabelState: TLabel
          Left = 205
          Top = 12
          Width = 111
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1074#1086#1076#1086#1074#1086#1076#1072':'
          FocusControl = ComboBoxState
        end
        object ComboBoxState: TComboBox
          Left = 322
          Top = 9
          Width = 148
          Height = 21
          Style = csDropDownList
          Anchors = [akTop, akRight]
          ItemHeight = 13
          TabOrder = 1
          Items.Strings = (
            '0 - '#1085#1077' '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1086
            '1 - '#1072#1075#1088#1077#1075#1072#1090' '#1074' '#1088#1072#1073#1086#1090#1077
            '2 - '#1072#1075#1088#1077#1075#1072#1090' '#1074' '#1088#1077#1079#1077#1088#1074#1077
            '3 - '#1086#1087#1086#1088#1086#1078#1085#1077#1085)
        end
        object ButtonLoad: TButton
          Left = 480
          Top = 7
          Width = 102
          Height = 25
          Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1086#1087#1088#1086#1089#1072
          Anchors = [akTop, akRight]
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = ButtonLoadClick
        end
        object NavigatorData: TDBNavigator
          Left = 5
          Top = 7
          Width = 140
          Height = 25
          DataSource = DataSourceData
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
          TabOrder = 0
        end
      end
    end
    object GroupBoxResult: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 204
      Width = 592
      Height = 195
      Margins.Left = 5
      Margins.Top = 2
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Caption = ' '#1056#1077#1079#1091#1083#1100#1090#1072#1090' '
      TabOrder = 1
      object GridResultPattern: TDBGrid
        AlignWithMargins = True
        Left = 7
        Top = 17
        Width = 578
        Height = 135
        Margins.Left = 5
        Margins.Top = 2
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alClient
        DataSource = DataSourceResult
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        PopupMenu = PopupMenu
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyDown = GridResultPatternKeyDown
      end
      object PanelResult: TPanel
        Left = 2
        Top = 152
        Width = 588
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          588
          41)
        object LabelCycle: TLabel
          Left = 155
          Top = 12
          Width = 30
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = #1062#1080#1082#1083':'
          FocusControl = EditCycle
        end
        object ButtonImport: TButton
          Left = 480
          Top = 7
          Width = 102
          Height = 25
          Hint = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090
          Anchors = [akTop, akRight]
          Caption = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = ButtonImportClick
        end
        object NavigatorResult: TDBNavigator
          Left = 5
          Top = 7
          Width = 140
          Height = 25
          DataSource = DataSourceResult
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
          TabOrder = 0
        end
        object EditCycle: TEdit
          Left = 191
          Top = 9
          Width = 134
          Height = 21
          Anchors = [akTop, akRight]
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 1
        end
        object ButtonCycle: TButton
          Left = 331
          Top = 9
          Width = 21
          Height = 21
          Hint = #1042#1099#1073#1088#1072#1090#1100' '#1094#1080#1082#1083
          Anchors = [akTop, akRight]
          Caption = '...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = ButtonCycleClick
        end
        object CheckBoxClearCycle: TCheckBox
          Left = 358
          Top = 11
          Width = 113
          Height = 17
          Hint = #1059#1076#1072#1083#1080#1090#1100' '#1080#1089#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1099#1077' '#1079#1072' '#1074#1099#1073#1088#1072#1085#1085#1099#1081' '#1094#1080#1082#1083
          Anchors = [akTop, akRight]
          Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 404
    Width = 602
    Height = 19
    Panels = <>
  end
  object DataSourceData: TDataSource
    Left = 124
    Top = 57
  end
  object DataSourceResult: TDataSource
    Left = 116
    Top = 257
  end
  object OpenDialog: TOpenDialog
    Filter = #1060#1072#1081#1083#1099' '#1086#1087#1088#1086#1089#1072' (*.dbf)|*.dbf|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Options = [ofEnableSizing]
    Left = 229
    Top = 58
  end
  object PopupMenu: TPopupMenu
    Left = 213
    Top = 252
    object MenuItemResistanceLine: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1089' '#1089#1086#1087#1088#1086#1090#1080#1074#1083#1077#1085#1080#1077#1084' '#1083#1080#1085#1080#1080' <> 0'
      OnClick = MenuItemFrequencyClick
    end
    object MenuItemResistance: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1089' '#1089#1086#1087#1088#1086#1090#1080#1074#1083#1077#1085#1080#1077#1084' <> 0'
      OnClick = MenuItemFrequencyClick
    end
    object MenuItemFrequency: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' c '#1095#1072#1089#1090#1086#1090#1086#1081' <> 0'
      OnClick = MenuItemFrequencyClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MenuItemUnCheckAll: TMenuItem
      Caption = #1059#1073#1088#1072#1090#1100' '#1074#1099#1073#1086#1088' '#1074#1089#1077#1093
      OnClick = MenuItemUnCheckAllClick
    end
  end
end
