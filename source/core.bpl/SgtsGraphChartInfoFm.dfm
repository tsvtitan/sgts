inherited SgtsGraphChartInfoForm: TSgtsGraphChartInfoForm
  Left = 505
  Top = 276
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
  ClientHeight = 238
  ClientWidth = 312
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelDialog: TPanel
    Width = 312
    Height = 200
    object LabelLeftAxis: TLabel
      Left = 94
      Top = 10
      Width = 31
      Height = 13
      Caption = #1054#1089#1100' Y'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 201
      Top = 10
      Width = 31
      Height = 13
      Caption = #1054#1089#1100' X'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelValue: TLabel
      Left = 25
      Top = 33
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = #1079#1085#1072#1095#1077#1085#1080#1077':'
      FocusControl = EditYValue
    end
    object EditYValue: TEdit
      Left = 84
      Top = 30
      Width = 100
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object EditXValue: TEdit
      Left = 191
      Top = 30
      Width = 100
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object GroupBoxStatistics: TGroupBox
      Left = 9
      Top = 60
      Width = 294
      Height = 134
      Caption = ' '#1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '
      TabOrder = 2
      object LabelAverage: TLabel
        Left = 21
        Top = 24
        Width = 46
        Height = 13
        Alignment = taRightJustify
        Caption = #1089#1088#1077#1076#1085#1077#1077':'
        FocusControl = EditYAverage
      end
      object LabelMax: TLabel
        Left = 16
        Top = 51
        Width = 51
        Height = 13
        Alignment = taRightJustify
        Caption = #1084#1072#1082#1089#1080#1084#1091#1084':'
        FocusControl = EditYMax
      end
      object LabelMin: TLabel
        Left = 21
        Top = 78
        Width = 46
        Height = 13
        Alignment = taRightJustify
        Caption = #1084#1080#1085#1080#1084#1091#1084':'
        FocusControl = EditYMin
      end
      object LabelRange: TLabel
        Left = 28
        Top = 105
        Width = 39
        Height = 13
        Alignment = taRightJustify
        Caption = #1088#1072#1079#1084#1072#1093':'
        FocusControl = EditYRange
      end
      object EditYAverage: TEdit
        Left = 75
        Top = 20
        Width = 100
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 0
      end
      object EditYMax: TEdit
        Left = 75
        Top = 47
        Width = 100
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
      end
      object EditXMax: TEdit
        Left = 182
        Top = 47
        Width = 100
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 2
      end
      object EditYMin: TEdit
        Left = 75
        Top = 74
        Width = 100
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 3
      end
      object EditXMin: TEdit
        Left = 182
        Top = 74
        Width = 100
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 4
      end
      object EditYRange: TEdit
        Left = 75
        Top = 101
        Width = 100
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 5
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 200
    Width = 312
    inherited ButtonOk: TButton
      Left = 150
      Visible = False
    end
    inherited ButtonCancel: TButton
      Left = 232
    end
  end
end
