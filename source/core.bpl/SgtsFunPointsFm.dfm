inherited SgtsFunPointsForm: TSgtsFunPointsForm
  Left = 394
  Top = 96
  Width = 563
  Caption = #1042#1074#1086#1076' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1099#1093' '#1090#1086#1095#1077#1082
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Width = 555
  end
  inherited ToolBar: TToolBar
    ButtonWidth = 33
    inherited ToolButtonInsert: TToolButton
      DropdownMenu = PopupMenuAdd
    end
  end
  inherited PanelView: TPanel
    Width = 520
    inherited TreePattern: TTreeView
      Width = 311
    end
    inherited PanelGrid: TPanel
      Width = 311
      object PageControl: TPageControl
        Left = 0
        Top = 0
        Width = 311
        Height = 188
        ActivePage = TabSheetPoint
        Align = alTop
        Style = tsFlatButtons
        TabOrder = 0
        object TabSheetMeasureType: TTabSheet
          Caption = #1042#1080#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
          TabVisible = False
          object Label1: TLabel
            Left = 14
            Top = 8
            Width = 81
            Height = 13
            Alignment = taRightJustify
            Caption = #1042#1080#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
          end
          object Label2: TLabel
            Left = 42
            Top = 32
            Width = 53
            Height = 13
            Alignment = taRightJustify
            Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
          end
          object Label3: TLabel
            Left = 30
            Top = 132
            Width = 67
            Height = 13
            Alignment = taRightJustify
            Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072':'
          end
          object DBEdit1: TDBEdit
            Left = 104
            Top = 4
            Width = 193
            Height = 21
            DataSource = DataSource
            TabOrder = 0
          end
          object DBMemo1: TDBMemo
            Left = 104
            Top = 32
            Width = 193
            Height = 89
            DataSource = DataSource
            TabOrder = 1
          end
          object DBEdit2: TDBEdit
            Left = 104
            Top = 128
            Width = 193
            Height = 21
            DataSource = DataSource
            TabOrder = 2
          end
          object DBCheckBox1: TDBCheckBox
            Left = 104
            Top = 154
            Width = 121
            Height = 17
            Caption = #1069#1090#1086#1090' '#1074#1080#1076' '#1072#1082#1090#1080#1074#1077#1085
            DataSource = DataSource
            TabOrder = 3
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
        end
        object TabSheetRoute: TTabSheet
          Caption = #1052#1072#1088#1096#1088#1091#1090
          ImageIndex = 1
          TabVisible = False
          object Label4: TLabel
            Left = 47
            Top = 8
            Width = 48
            Height = 13
            Alignment = taRightJustify
            Caption = #1052#1072#1088#1096#1088#1091#1090':'
          end
          object Label5: TLabel
            Left = 42
            Top = 32
            Width = 53
            Height = 13
            Alignment = taRightJustify
            Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
          end
          object Label6: TLabel
            Left = 30
            Top = 132
            Width = 67
            Height = 13
            Alignment = taRightJustify
            Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072':'
          end
          object DBEdit3: TDBEdit
            Left = 104
            Top = 4
            Width = 193
            Height = 21
            DataSource = DataSource
            TabOrder = 0
          end
          object DBMemo2: TDBMemo
            Left = 104
            Top = 32
            Width = 193
            Height = 89
            DataSource = DataSource
            TabOrder = 1
          end
          object DBEdit4: TDBEdit
            Left = 104
            Top = 128
            Width = 193
            Height = 21
            DataSource = DataSource
            TabOrder = 2
          end
          object DBCheckBox2: TDBCheckBox
            Left = 104
            Top = 154
            Width = 145
            Height = 17
            Caption = #1069#1090#1086#1090' '#1084#1072#1088#1096#1088#1091#1090' '#1072#1082#1090#1080#1074#1077#1085
            DataSource = DataSource
            TabOrder = 3
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
        end
        object TabSheetPoint: TTabSheet
          Caption = #1048#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1072#1103' '#1090#1086#1095#1082#1072
          ImageIndex = 2
          TabVisible = False
          object Label7: TLabel
            Left = 36
            Top = 8
            Width = 59
            Height = 13
            Alignment = taRightJustify
            Caption = #1048#1079#1084'. '#1090#1086#1095#1082#1072':'
          end
          object Label8: TLabel
            Left = 42
            Top = 32
            Width = 53
            Height = 13
            Alignment = taRightJustify
            Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
          end
          object Label9: TLabel
            Left = 30
            Top = 136
            Width = 67
            Height = 13
            Alignment = taRightJustify
            Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072':'
          end
          object Label10: TLabel
            Left = 34
            Top = 108
            Width = 65
            Height = 13
            Alignment = taRightJustify
            Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1099':'
          end
          object DBEdit5: TDBEdit
            Left = 104
            Top = 4
            Width = 193
            Height = 21
            DataSource = DataSource
            TabOrder = 0
          end
          object DBMemo3: TDBMemo
            Left = 104
            Top = 32
            Width = 193
            Height = 65
            DataSource = DataSource
            TabOrder = 1
          end
          object DBEdit6: TDBEdit
            Left = 104
            Top = 132
            Width = 193
            Height = 21
            DataSource = DataSource
            TabOrder = 3
          end
          object DBCheckBox3: TDBCheckBox
            Left = 104
            Top = 158
            Width = 145
            Height = 17
            Caption = #1069#1090#1072' '#1090#1086#1095#1082#1072' '#1072#1082#1090#1080#1074#1085#1072
            DataSource = DataSource
            TabOrder = 4
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
          object DBEdit7: TDBEdit
            Left = 104
            Top = 104
            Width = 193
            Height = 21
            DataSource = DataSource
            TabOrder = 2
          end
        end
      end
      object PanelGridView: TPanel
        Left = 0
        Top = 188
        Width = 311
        Height = 104
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
      end
    end
  end
  object PopupMenuAdd: TPopupMenu
    OnPopup = PopupMenuAddPopup
    Left = 131
    Top = 67
    object MenuItemAdd: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1080#1076
      OnClick = MenuItemAddClick
    end
    object MenuItemAddSub: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1076#1074#1080#1076
      OnClick = MenuItemAddSubClick
    end
    object MenuItemAddRoute: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1084#1072#1088#1096#1088#1091#1090
      OnClick = MenuItemAddRouteClick
    end
    object MenuItemAddPoint: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1091#1102' '#1090#1086#1095#1082#1091
      OnClick = MenuItemAddPointClick
    end
  end
end
