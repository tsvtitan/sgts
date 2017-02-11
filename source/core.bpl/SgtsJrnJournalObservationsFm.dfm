inherited SgtsJrnJournalObservationsForm: TSgtsJrnJournalObservationsForm
  Left = 441
  Top = 182
  ActiveControl = CheckListBoxCycles
  Caption = #1046#1091#1088#1085#1072#1083' '#1085#1072#1073#1083#1102#1076#1077#1085#1080#1081
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
    object BevelFilter: TBevel [0]
      Left = 3
      Top = 111
      Width = 551
      Height = 5
      Align = alTop
      Shape = bsSpacer
    end
    inherited GridPattern: TDBGrid
      Top = 116
      Width = 551
      Height = 148
    end
    object PanelFilter: TPanel
      Left = 3
      Top = 3
      Width = 551
      Height = 108
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object GroupBoxFiilter: TGroupBox
        Left = 0
        Top = 0
        Width = 551
        Height = 108
        Align = alClient
        Caption = ' '#1060#1080#1083#1100#1090#1088' '
        TabOrder = 0
        object LabelCycles: TLabel
          Left = 57
          Top = 50
          Width = 38
          Height = 13
          Alignment = taRightJustify
          Caption = #1062#1080#1082#1083#1099':'
          FocusControl = CheckListBoxCycles
        end
        object Label1: TLabel
          Left = 18
          Top = 24
          Width = 79
          Height = 13
          Alignment = taRightJustify
          Caption = #1042#1080#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
          FocusControl = EditMeasureType
        end
        object LabelDateBegin: TLabel
          Left = 335
          Top = 24
          Width = 69
          Height = 13
          Alignment = taRightJustify
          Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072':'
          FocusControl = DateTimePickerBegin
        end
        object LabelDateEnd: TLabel
          Left = 317
          Top = 50
          Width = 87
          Height = 13
          Alignment = taRightJustify
          Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
          FocusControl = DateTimePickerEnd
        end
        object CheckListBoxCycles: TCheckListBox
          Left = 104
          Top = 47
          Width = 195
          Height = 52
          OnClickCheck = CheckListBoxCyclesClickCheck
          ItemHeight = 13
          TabOrder = 2
        end
        object EditMeasureType: TEdit
          Left = 104
          Top = 21
          Width = 168
          Height = 21
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 0
        end
        object ButtonMeasureType: TButton
          Left = 278
          Top = 21
          Width = 21
          Height = 21
          Hint = #1042#1099#1073#1088#1072#1090#1100' '#1074#1080#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
          Caption = '...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = ButtonMeasureTypeClick
        end
        object DateTimePickerBegin: TDateTimePicker
          Left = 411
          Top = 21
          Width = 100
          Height = 21
          Date = 38987.504579895830000000
          Time = 38987.504579895830000000
          TabOrder = 3
        end
        object DateTimePickerEnd: TDateTimePicker
          Left = 411
          Top = 47
          Width = 100
          Height = 21
          Date = 38987.504579895830000000
          Time = 38987.504579895830000000
          TabOrder = 4
        end
        object ButtonDate: TButton
          Left = 517
          Top = 47
          Width = 21
          Height = 21
          Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1077#1088#1080#1086#1076
          Caption = '...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = ButtonDateClick
        end
        object ButtonApply: TButton
          Left = 411
          Top = 74
          Width = 130
          Height = 25
          Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
          Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
          TabOrder = 6
          OnClick = ButtonApplyClick
        end
      end
    end
    object GroupBoxInfo: TGroupBox
      Left = 3
      Top = 264
      Width = 551
      Height = 99
      Align = alBottom
      Caption = ' '#1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086' '
      TabOrder = 2
      ExplicitTop = 254
      DesignSize = (
        551
        99)
      object LabelPointCoordinateZ: TLabel
        Left = 216
        Top = 22
        Width = 64
        Height = 13
        Alignment = taRightJustify
        Caption = #1054#1090#1084#1077#1090#1082#1072' '#1048#1058':'
        FocusControl = EditPointCoordinateZ
      end
      object LabelConverter: TLabel
        Left = 16
        Top = 22
        Width = 94
        Height = 13
        Alignment = taRightJustify
        Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1077#1083#1100':'
        FocusControl = EditConverter
      end
      object LabelPointObject: TLabel
        Left = 34
        Top = 44
        Width = 76
        Height = 26
        Alignment = taRightJustify
        Caption = #1056#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072':'
        FocusControl = MemoPointObject
        WordWrap = True
      end
      object EditPointCoordinateZ: TEdit
        Left = 290
        Top = 19
        Width = 60
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
      end
      object EditConverter: TEdit
        Left = 120
        Top = 19
        Width = 81
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 0
      end
      object MemoPointObject: TMemo
        Left = 120
        Top = 45
        Width = 424
        Height = 46
        Anchors = [akLeft, akTop, akRight, akBottom]
        Color = clBtnFace
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 2
        WordWrap = False
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 366
    Width = 592
    ExplicitWidth = 592
    inherited ButtonCancel: TButton
      Left = 511
      ExplicitLeft = 511
    end
    inherited ButtonOk: TButton
      Left = 429
      ExplicitLeft = 429
    end
  end
  inherited MainMenu: TMainMenu
    Left = 80
    Top = 216
  end
  inherited ImageList: TImageList
    Left = 104
    Top = 162
  end
  inherited PopupMenuView: TPopupMenu
    Left = 192
    Top = 210
  end
  inherited PopupMenuFilter: TPopupMenu
    Left = 280
    Top = 218
  end
  inherited PopupMenuReport: TPopupMenu
    Left = 400
    Top = 186
  end
  inherited DataSource: TDataSource
    Left = 304
    Top = 162
  end
  inherited PopupMenuInsert: TPopupMenu
    Left = 211
    Top = 160
  end
end
