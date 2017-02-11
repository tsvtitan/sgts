inherited SgtsKgesGraphPeriodRefreshForm: TSgtsKgesGraphPeriodRefreshForm
  Width = 380
  Height = 400
  Caption = #1059#1089#1083#1086#1074#1080#1103' '#1075#1088#1072#1092#1080#1082#1072' '#1079#1072' '#1087#1077#1088#1080#1086#1076
  Constraints.MinHeight = 400
  Constraints.MinWidth = 380
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelDialog: TPanel
    Width = 372
    Height = 335
    inherited PanelType: TPanel
      Width = 372
      inherited GroupBoxType: TGroupBox
        Width = 366
        DesignSize = (
          366
          52)
        inherited EditName: TEdit
          Width = 344
        end
      end
    end
    inherited PanelAxis: TPanel
      Top = 229
      Width = 372
      Height = 106
      TabOrder = 3
      inherited GroupBoxAxis: TGroupBox
        Width = 366
        Height = 100
        inherited PanelAxis2: TPanel
          Width = 362
          Height = 83
          inherited TabControlAxis: TTabControl
            Width = 358
            Height = 79
            inherited CheckListBoxParams: TCheckListBox
              Width = 350
              Height = 48
            end
          end
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
    object PanelHistory: TPanel
      Left = 0
      Top = 148
      Width = 372
      Height = 81
      Align = alTop
      BevelOuter = bvNone
      BorderWidth = 3
      TabOrder = 2
      object GroupBoxHistory: TGroupBox
        Left = 3
        Top = 3
        Width = 366
        Height = 75
        Align = alClient
        Caption = ' '#1048#1089#1090#1086#1088#1080#1103' '
        TabOrder = 0
        object PanelListBoxHistory: TPanel
          Left = 2
          Top = 15
          Width = 362
          Height = 58
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          object PanelButtonsHistory: TPanel
            Left = 327
            Top = 5
            Width = 30
            Height = 48
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 1
            object ButtonHistoryAdd: TButton
              Left = 5
              Top = 0
              Width = 21
              Height = 21
              Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1080#1089#1090#1086#1088#1080#1102
              Caption = '<'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = ButtonHistoryAddClick
            end
            object ButtonHistoryClear: TButton
              Left = 5
              Top = 26
              Width = 21
              Height = 21
              Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1080#1089#1090#1086#1088#1080#1080
              Caption = '>'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = ButtonHistoryClearClick
            end
          end
          object ListBoxHistory: TListBox
            Left = 5
            Top = 5
            Width = 322
            Height = 48
            Align = alClient
            ItemHeight = 13
            MultiSelect = True
            TabOrder = 0
            OnDblClick = ListBoxHistoryDblClick
            OnKeyDown = ListBoxHistoryKeyDown
          end
        end
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 335
    Width = 372
    DesignSize = (
      372
      38)
    inherited ButtonOk: TButton
      Left = 210
      Top = 8
      Height = 24
    end
    inherited ButtonCancel: TButton
      Left = 292
    end
  end
  inherited PopupMenuParams: TPopupMenu
    Left = 271
    Top = 10
  end
end
