inherited SgtsBaseGraphRefreshForm: TSgtsBaseGraphRefreshForm
  Left = 595
  Top = 211
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  ClientHeight = 323
  ClientWidth = 342
  Constraints.MinHeight = 350
  Constraints.MinWidth = 350
  ExplicitLeft = 595
  ExplicitTop = 211
  ExplicitWidth = 350
  ExplicitHeight = 350
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelDialog: TPanel
    Width = 342
    Height = 285
    ExplicitWidth = 342
    ExplicitHeight = 285
    object PanelType: TPanel
      Left = 0
      Top = 0
      Width = 342
      Height = 58
      Align = alTop
      BevelOuter = bvNone
      BorderWidth = 3
      TabOrder = 0
      object GroupBoxType: TGroupBox
        Left = 3
        Top = 3
        Width = 336
        Height = 52
        Align = alClient
        Caption = ' '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1075#1088#1072#1092#1080#1082#1072' '
        TabOrder = 0
        DesignSize = (
          336
          52)
        object EditName: TEdit
          Left = 11
          Top = 21
          Width = 314
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
      end
    end
    object PanelAxis: TPanel
      Left = 0
      Top = 58
      Width = 342
      Height = 227
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 3
      TabOrder = 1
      object GroupBoxAxis: TGroupBox
        Left = 3
        Top = 3
        Width = 336
        Height = 221
        Align = alClient
        Caption = ' '#1053#1072#1079#1085#1072#1095#1077#1085#1080#1077' '#1086#1089#1077#1081' '#1075#1088#1072#1092#1080#1082#1072' '
        TabOrder = 0
        object PanelAxis2: TPanel
          Left = 2
          Top = 15
          Width = 332
          Height = 204
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 2
          TabOrder = 0
          object TabControlAxis: TTabControl
            Left = 2
            Top = 2
            Width = 328
            Height = 200
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
              Width = 320
              Height = 169
              OnClickCheck = CheckListBoxParamsClickCheck
              Align = alClient
              ItemHeight = 13
              PopupMenu = PopupMenuParams
              TabOrder = 0
              OnDblClick = CheckListBoxParamsDblClick
            end
          end
        end
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 285
    Width = 342
    ExplicitTop = 285
    ExplicitWidth = 342
    DesignSize = (
      342
      38)
    inherited ButtonOk: TButton
      Left = 180
      TabOrder = 1
      ExplicitLeft = 180
    end
    inherited ButtonCancel: TButton
      Left = 262
      TabOrder = 2
      ExplicitLeft = 262
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
    Left = 151
    Top = 178
    object MenuItemParamCheckAll: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077
      Visible = False
      OnClick = MenuItemParamCheckAllClick
    end
    object MenuItemParamUnCheckAll: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1089#1077
      Visible = False
      OnClick = MenuItemParamUnCheckAllClick
    end
  end
end
