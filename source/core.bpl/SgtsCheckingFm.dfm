inherited SgtsCheckingForm: TSgtsCheckingForm
  Left = 437
  Top = 219
  ActiveControl = EditValue
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = #1050#1086#1085#1090#1088#1086#1083#1100
  ClientHeight = 273
  ClientWidth = 592
  Constraints.MinHeight = 300
  Constraints.MinWidth = 600
  ExplicitLeft = 437
  ExplicitTop = 219
  ExplicitWidth = 600
  ExplicitHeight = 300
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelDialog: TPanel
    Width = 592
    Height = 235
    ExplicitWidth = 592
    ExplicitHeight = 235
    object LabelDateObservation: TLabel
      Left = 88
      Top = 11
      Width = 97
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1085#1072#1073#1083#1102#1076#1077#1085#1080#1103':'
      FocusControl = DateTimePickerObservation
    end
    object LabelCycle: TLabel
      Left = 365
      Top = 11
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = #1062#1080#1082#1083':'
      FocusControl = EditCycle
    end
    object LabelMeasureType: TLabel
      Left = 36
      Top = 38
      Width = 79
      Height = 13
      Alignment = taRightJustify
      Caption = #1042#1080#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
      FocusControl = EditMeasureType
    end
    object LabelPoint: TLabel
      Left = 336
      Top = 38
      Width = 59
      Height = 13
      Alignment = taRightJustify
      Caption = #1048#1079#1084'. '#1090#1086#1095#1082#1072':'
      FocusControl = EditPoint
    end
    object LabelParam: TLabel
      Left = 62
      Top = 66
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088':'
      FocusControl = EditParam
    end
    object LabelValue: TLabel
      Left = 343
      Top = 66
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077':'
      FocusControl = EditValue
    end
    object DateTimePickerObservation: TDateTimePicker
      Left = 193
      Top = 8
      Width = 100
      Height = 21
      Date = 38987.504579895830000000
      Time = 38987.504579895830000000
      Color = clBtnFace
      TabOrder = 0
    end
    object EditCycle: TEdit
      Left = 403
      Top = 8
      Width = 118
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object ButtonCycle: TButton
      Left = 527
      Top = 8
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1094#1080#1082#1083
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = ButtonCycleClick
    end
    object EditMeasureType: TEdit
      Left = 123
      Top = 35
      Width = 170
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
    end
    object ButtonMeasureType: TButton
      Left = 299
      Top = 35
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1074#1080#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = ButtonMeasureTypeClick
    end
    object EditPoint: TEdit
      Left = 403
      Top = 35
      Width = 118
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
    end
    object ButtonPoint: TButton
      Left = 527
      Top = 35
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1091#1102' '#1090#1086#1095#1082#1091
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = ButtonPointClick
    end
    object EditParam: TEdit
      Left = 123
      Top = 62
      Width = 170
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 7
    end
    object ButtonParam: TButton
      Left = 299
      Top = 62
      Width = 21
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = ButtonParamClick
    end
    object EditValue: TEdit
      Left = 403
      Top = 62
      Width = 100
      Height = 21
      TabOrder = 9
    end
    object PanelChecking: TPanel
      Left = 0
      Top = 88
      Width = 592
      Height = 147
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      BorderWidth = 3
      TabOrder = 10
      object GroupBoxChecking: TGroupBox
        Left = 3
        Top = 3
        Width = 586
        Height = 141
        Align = alClient
        Caption = ' '#1057#1087#1080#1089#1086#1082' '
        TabOrder = 0
        object PanelGrid: TPanel
          Left = 2
          Top = 15
          Width = 582
          Height = 124
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
        end
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 235
    Width = 592
    ExplicitTop = 235
    ExplicitWidth = 592
    inherited ButtonOk: TButton
      Left = 430
      TabOrder = 1
      ExplicitLeft = 430
    end
    inherited ButtonCancel: TButton
      Left = 512
      TabOrder = 2
      ExplicitLeft = 512
    end
    object ButtonCheck: TButton
      Left = 6
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1050#1086#1085#1090#1088#1086#1083#1100
      TabOrder = 0
      OnClick = ButtonCheckClick
    end
  end
  object DataSource: TDataSource
    Left = 101
    Top = 120
  end
end
