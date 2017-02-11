inherited SgtsLoginForm: TSgtsLoginForm
  Left = 879
  Top = 181
  Caption = #1040#1091#1090#1077#1085#1090#1080#1092#1080#1082#1072#1094#1080#1103
  ClientHeight = 131
  ClientWidth = 307
  Constraints.MinHeight = 0
  Constraints.MinWidth = 0
  OnShow = FormShow
  ExplicitWidth = 313
  ExplicitHeight = 156
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelDialog: TPanel
    Width = 307
    Height = 93
    ExplicitWidth = 307
    ExplicitHeight = 93
    object PanelUserPass: TPanel
      Left = 0
      Top = 0
      Width = 307
      Height = 91
      Align = alTop
      BevelOuter = bvNone
      BorderWidth = 3
      TabOrder = 0
      object GroupBoxUserPass: TGroupBox
        Left = 3
        Top = 3
        Width = 301
        Height = 85
        Align = alClient
        Caption = ' '#1042#1074#1077#1076#1080#1090#1077' '#1089#1074#1086#1080' '#1076#1072#1085#1085#1099#1077' '
        TabOrder = 0
        object LabelUser: TLabel
          Left = 16
          Top = 26
          Width = 76
          Height = 13
          Alignment = taRightJustify
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
          FocusControl = EditUser
        end
        object LabelPass: TLabel
          Left = 51
          Top = 54
          Width = 41
          Height = 13
          Alignment = taRightJustify
          Caption = #1055#1072#1088#1086#1083#1100':'
          FocusControl = EditPass
        end
        object EditUser: TEdit
          Left = 102
          Top = 23
          Width = 185
          Height = 21
          TabOrder = 0
        end
        object EditPass: TEdit
          Left = 102
          Top = 51
          Width = 185
          Height = 21
          TabOrder = 1
        end
      end
    end
    object PanelParams: TPanel
      Left = 0
      Top = 91
      Width = 307
      Height = 2
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 3
      TabOrder = 1
      object GroupBoxParams: TGroupBox
        Left = 3
        Top = 3
        Width = 301
        Height = 58
        Align = alClient
        Caption = ' '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '
        TabOrder = 0
        object LabelBase: TLabel
          Left = 23
          Top = 26
          Width = 69
          Height = 13
          Alignment = taRightJustify
          Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093':'
          FocusControl = ComboBoxBase
        end
        object ComboBoxBase: TComboBox
          Left = 102
          Top = 22
          Width = 185
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = ComboBoxBaseChange
        end
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 93
    Width = 307
    ExplicitTop = 93
    ExplicitWidth = 307
    inherited ButtonOk: TButton
      Left = 145
      ExplicitLeft = 145
    end
    inherited ButtonCancel: TButton
      Left = 227
      ExplicitLeft = 227
    end
    object ButtonParams: TButton
      Left = 6
      Top = 7
      Width = 90
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' >>'
      TabOrder = 2
      OnClick = ButtonParamsClick
    end
  end
  object TimerLogon: TTimer
    Enabled = False
    Interval = 1
    OnTimer = TimerLogonTimer
    Left = 19
    Top = 51
  end
end
