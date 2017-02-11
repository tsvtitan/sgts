inherited SgtsKgesGraphRefreshForm: TSgtsKgesGraphRefreshForm
  Left = 525
  Top = 213
  Width = 380
  Height = 370
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = #1059#1089#1083#1086#1074#1080#1103' '#1075#1088#1072#1092#1080#1082#1072
  Constraints.MinHeight = 370
  Constraints.MinWidth = 380
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelDialog: TPanel
    Width = 372
    Height = 305
    object PanelType: TPanel
      Left = 0
      Top = 0
      Width = 372
      Height = 58
      Align = alTop
      BevelOuter = bvNone
      BorderWidth = 3
      TabOrder = 0
      object GroupBoxType: TGroupBox
        Left = 3
        Top = 3
        Width = 366
        Height = 52
        Align = alClient
        Caption = ' '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1075#1088#1072#1092#1080#1082#1072' '
        TabOrder = 0
        DesignSize = (
          366
          52)
        object EditName: TEdit
          Left = 11
          Top = 21
          Width = 344
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
      end
    end
    object PanelPeriod: TPanel
      Left = 0
      Top = 58
      Width = 372
      Height = 90
      Align = alTop
      BevelOuter = bvNone
      BorderWidth = 3
      TabOrder = 1
      object GroupBoxPeriod: TGroupBox
        Left = 3
        Top = 3
        Width = 366
        Height = 84
        Align = alClient
        Caption = ' '#1042#1088#1077#1084#1077#1085#1085#1086#1081' '#1087#1088#1086#1084#1077#1078#1091#1090#1086#1082' '
        TabOrder = 0
        object LabelPeriodEnd: TLabel
          Left = 214
          Top = 25
          Width = 16
          Height = 13
          Alignment = taRightJustify
          Caption = #1087#1086':'
          FocusControl = DateTimePickerPeriodEnd
        end
        object LabelPeriodBegin: TLabel
          Left = 98
          Top = 25
          Width = 9
          Height = 13
          Alignment = taRightJustify
          Caption = #1089':'
          FocusControl = DateTimePickerPeriodBegin
        end
        object LabelCycleBegin: TLabel
          Left = 98
          Top = 54
          Width = 9
          Height = 13
          Alignment = taRightJustify
          Caption = #1089':'
          Enabled = False
          FocusControl = EditCycleBegin
        end
        object LabelCycleEnd: TLabel
          Left = 214
          Top = 54
          Width = 16
          Height = 13
          Alignment = taRightJustify
          Caption = #1087#1086':'
          Enabled = False
          FocusControl = EditCycleEnd
        end
        object RadioButtonPeriod: TRadioButton
          Left = 11
          Top = 24
          Width = 81
          Height = 17
          Caption = #1047#1072' '#1087#1077#1088#1080#1086#1076
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = RadioButtonCycleClick
        end
        object DateTimePickerPeriodBegin: TDateTimePicker
          Left = 115
          Top = 22
          Width = 89
          Height = 21
          Hint = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
          Date = 39283.583816365740000000
          Time = 39283.583816365740000000
          TabOrder = 2
        end
        object DateTimePickerPeriodEnd: TDateTimePicker
          Left = 238
          Top = 22
          Width = 89
          Height = 21
          Hint = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
          Date = 39283.583816365740000000
          Time = 39283.583816365740000000
          TabOrder = 3
        end
        object RadioButtonCycle: TRadioButton
          Left = 11
          Top = 53
          Width = 69
          Height = 17
          Caption = #1047#1072' '#1094#1080#1082#1083
          TabOrder = 1
          OnClick = RadioButtonCycleClick
        end
        object EditCycleBegin: TEdit
          Left = 115
          Top = 51
          Width = 60
          Height = 21
          Hint = #1053#1072#1095#1072#1083#1100#1085#1099#1081' '#1094#1080#1082#1083
          Color = clBtnFace
          Enabled = False
          TabOrder = 5
        end
        object ButtonCycleBegin: TButton
          Left = 182
          Top = 51
          Width = 21
          Height = 21
          Caption = '...'
          Enabled = False
          TabOrder = 6
          OnClick = ButtonCycleBeginClick
        end
        object EditCycleEnd: TEdit
          Left = 238
          Top = 51
          Width = 60
          Height = 21
          Hint = #1050#1086#1085#1077#1095#1085#1099#1081' '#1094#1080#1082#1083
          Color = clBtnFace
          Enabled = False
          TabOrder = 7
        end
        object ButtonCycleEnd: TButton
          Left = 305
          Top = 51
          Width = 21
          Height = 21
          Caption = '...'
          Enabled = False
          TabOrder = 8
          OnClick = ButtonCycleEndClick
        end
        object ButtonPeriod: TButton
          Left = 333
          Top = 22
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 4
          OnClick = ButtonPeriodClick
        end
      end
    end
    object PanelPageControl: TPanel
      Left = 0
      Top = 148
      Width = 372
      Height = 157
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 3
      TabOrder = 2
    end
    object PanelAxis: TPanel
      Left = 0
      Top = 148
      Width = 372
      Height = 157
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 3
      TabOrder = 3
      object GroupBoxAxis: TGroupBox
        Left = 3
        Top = 3
        Width = 366
        Height = 151
        Align = alClient
        Caption = ' '#1053#1072#1079#1085#1072#1095#1077#1085#1080#1077' '#1086#1089#1077#1081' '#1075#1088#1072#1092#1080#1082#1072' '
        TabOrder = 0
        object PanelAxis2: TPanel
          Left = 2
          Top = 15
          Width = 362
          Height = 134
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 2
          TabOrder = 0
          object TabControlAxis: TTabControl
            Left = 2
            Top = 2
            Width = 358
            Height = 130
            Align = alClient
            Style = tsFlatButtons
            TabOrder = 0
            Tabs.Strings = (
              #1051#1077#1074#1072#1103' '#1086#1089#1100' Y'#1083
              #1053#1080#1078#1085#1103#1103' '#1086#1089#1100' X'#1085
              #1055#1088#1072#1074#1072#1103' '#1086#1089#1100' Y'#1087)
            TabIndex = 0
            OnChange = TabControlAxisChange
            object CheckListBoxParams: TCheckListBox
              Left = 4
              Top = 27
              Width = 350
              Height = 99
              OnClickCheck = CheckListBoxParamsClickCheck
              Align = alClient
              ItemHeight = 13
              PopupMenu = PopupMenuParams
              TabOrder = 0
            end
          end
        end
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 305
    Width = 372
    DesignSize = (
      372
      38)
    inherited ButtonOk: TButton
      Left = 210
      TabOrder = 1
    end
    inherited ButtonCancel: TButton
      Left = 292
      TabOrder = 2
    end
    object ButtonDefault: TButton
      Left = 8
      Top = 7
      Width = 90
      Height = 25
      Caption = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      TabOrder = 0
      OnClick = ButtonDefaultClick
    end
  end
  object PopupMenuParams: TPopupMenu
    Left = 167
    Top = 218
    object MenuItemParamCheckAll: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077
      OnClick = MenuItemParamCheckAllClick
    end
    object MenuItemParamUnCheckAll: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1089#1077
      OnClick = MenuItemParamUnCheckAllClick
    end
  end
end
