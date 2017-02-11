inherited SgtsFunSourceDataMeasureDetailFrame: TSgtsFunSourceDataMeasureDetailFrame
  Width = 500
  Height = 300
  Constraints.MinHeight = 300
  Constraints.MinWidth = 500
  ExplicitWidth = 500
  ExplicitHeight = 300
  inherited PanelStatus: TPanel
    Width = 500
    Height = 300
    ExplicitWidth = 500
    ExplicitHeight = 300
    object Splitter: TSplitter
      Left = 255
      Top = 0
      Height = 300
      MinSize = 255
    end
    object PanelPoints: TPanel
      Left = 0
      Top = 0
      Width = 255
      Height = 300
      Align = alLeft
      BevelOuter = bvNone
      BorderWidth = 3
      Constraints.MinWidth = 255
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      object GridPattern: TDBGrid
        Left = 3
        Top = 3
        Width = 249
        Height = 294
        Align = alClient
        DataSource = DataSource
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object PanelValuesAndAdditional: TPanel
      Left = 258
      Top = 0
      Width = 242
      Height = 300
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object PanelValues: TPanel
        Left = 0
        Top = 0
        Width = 242
        Height = 89
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 3
        TabOrder = 0
        object GridValuesPattern: TDBGrid
          Left = 3
          Top = 3
          Width = 236
          Height = 83
          Align = alClient
          DataSource = DataSourceValues
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
      end
      object PanelAdditional: TPanel
        Left = 0
        Top = 89
        Width = 242
        Height = 211
        Align = alBottom
        BevelOuter = bvNone
        BorderWidth = 3
        TabOrder = 1
        object GroupBoxAdditional: TGroupBox
          Left = 3
          Top = 3
          Width = 236
          Height = 205
          Align = alClient
          Caption = ' '#1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086' '
          TabOrder = 0
          object LabelJournalNum: TLabel
            Left = 28
            Top = 127
            Width = 82
            Height = 13
            Alignment = taRightJustify
            Caption = #1053#1086#1084#1077#1088' '#1078#1091#1088#1085#1072#1083#1072':'
            FocusControl = DBEditJournalNum
          end
          object LabelNote: TLabel
            Left = 45
            Top = 152
            Width = 65
            Height = 13
            Alignment = taRightJustify
            Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
            FocusControl = DBMemoNote
          end
          object LabelConverter: TLabel
            Left = 16
            Top = 24
            Width = 94
            Height = 13
            Alignment = taRightJustify
            Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1077#1083#1100':'
            FocusControl = EditConverter
          end
          object LabelPointCoordinateZ: TLabel
            Left = 46
            Top = 50
            Width = 64
            Height = 13
            Alignment = taRightJustify
            Caption = #1054#1090#1084#1077#1090#1082#1072' '#1048#1058':'
            FocusControl = EditPointCoordinateZ
          end
          object LabelPointObject: TLabel
            Left = 34
            Top = 72
            Width = 76
            Height = 26
            Alignment = taRightJustify
            Caption = #1056#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072':'
            FocusControl = MemoPointObject
            WordWrap = True
          end
          object DBEditJournalNum: TDBEdit
            Left = 120
            Top = 124
            Width = 80
            Height = 21
            DataField = 'JOURNAL_NUM'
            DataSource = DataSource
            TabOrder = 3
            OnKeyDown = DBEditJournalNumKeyDown
          end
          object DBMemoNote: TDBMemo
            Left = 120
            Top = 149
            Width = 106
            Height = 47
            DataField = 'NOTE'
            DataSource = DataSource
            TabOrder = 4
            OnExit = DBMemoNoteExit
            OnKeyDown = DBEditJournalNumKeyDown
          end
          object EditConverter: TEdit
            Left = 120
            Top = 21
            Width = 81
            Height = 21
            Color = clBtnFace
            ReadOnly = True
            TabOrder = 0
          end
          object EditPointCoordinateZ: TEdit
            Left = 120
            Top = 47
            Width = 81
            Height = 21
            Color = clBtnFace
            ReadOnly = True
            TabOrder = 1
          end
          object MemoPointObject: TMemo
            Left = 120
            Top = 73
            Width = 106
            Height = 46
            Color = clBtnFace
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 2
            WordWrap = False
          end
        end
      end
    end
  end
  object DataSource: TDataSource
    Left = 64
    Top = 104
  end
  object DataSourceValues: TDataSource
    Left = 152
    Top = 32
  end
  object PopupMenuConfirm: TPopupMenu
    OnPopup = PopupMenuConfirmPopup
    Left = 104
    Top = 176
    object MenuItemConfirmCheckAll: TMenuItem
      Caption = #1059#1090#1074#1077#1088#1076#1080#1090#1100' '#1074#1089#1077
      OnClick = MenuItemConfirmCheckAllClick
    end
    object MenuItemConfirmUncheckAll: TMenuItem
      Caption = #1057#1085#1103#1090#1100' '#1091#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077' '#1091' '#1074#1089#1077#1093
      OnClick = MenuItemConfirmUncheckAllClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MenuItemConfirmCancel: TMenuItem
      Caption = #1054#1090#1084#1077#1085#1072
    end
  end
end
