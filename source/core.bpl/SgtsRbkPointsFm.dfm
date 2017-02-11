inherited SgtsRbkPointsForm: TSgtsRbkPointsForm
  Left = 506
  Top = 146
  Caption = #1048#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1099#1077' '#1090#1086#1095#1082#1080
  ClientHeight = 429
  ClientWidth = 507
  Constraints.MinHeight = 475
  Constraints.MinWidth = 515
  ExplicitWidth = 515
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 426
    Width = 507
    ExplicitWidth = 507
  end
  inherited StatusBar: TStatusBar
    Top = 405
    Width = 507
    ExplicitTop = 395
    ExplicitWidth = 507
  end
  inherited ToolBar: TToolBar
    Height = 366
    ExplicitHeight = 356
  end
  inherited PanelView: TPanel
    Width = 472
    Height = 366
    ExplicitWidth = 472
    ExplicitHeight = 356
    object Splitter: TSplitter [0]
      Left = 3
      Top = 204
      Width = 466
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 213
    end
    inherited GridPattern: TDBGrid
      Width = 466
      Height = 201
    end
    object PanelInfo: TPanel
      Left = 3
      Top = 207
      Width = 466
      Height = 156
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 197
      object GroupBoxInfo: TGroupBox
        Left = 0
        Top = 0
        Width = 466
        Height = 156
        Align = alClient
        Caption = ' '#1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086' '
        TabOrder = 0
        object PanelNote: TPanel
          Left = 2
          Top = 15
          Width = 462
          Height = 139
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          DesignSize = (
            462
            139)
          object LabelX: TLabel
            Left = 21
            Top = 62
            Width = 75
            Height = 13
            Alignment = taRightJustify
            Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1072' X:'
            FocusControl = DBEditX
          end
          object LabelY: TLabel
            Left = 177
            Top = 62
            Width = 75
            Height = 13
            Alignment = taRightJustify
            Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1072' Y:'
            FocusControl = DBEditY
          end
          object LabelZ: TLabel
            Left = 334
            Top = 62
            Width = 64
            Height = 13
            Alignment = taRightJustify
            Caption = #1054#1090#1084#1077#1090#1082#1072' '#1048#1058':'
            FocusControl = DBEditZ
          end
          object LabelDescription: TLabel
            Left = 43
            Top = 85
            Width = 53
            Height = 13
            Alignment = taRightJustify
            Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
            FocusControl = DBMemoDescription
          end
          object LabelObjectPaths: TLabel
            Left = 20
            Top = 5
            Width = 76
            Height = 26
            Alignment = taRightJustify
            Caption = #1056#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072':'
            FocusControl = DBMemoObjectPaths
            WordWrap = True
          end
          object DBMemoDescription: TDBMemo
            Left = 103
            Top = 85
            Width = 352
            Height = 47
            Anchors = [akLeft, akTop, akRight, akBottom]
            Color = clBtnFace
            DataField = 'DESCRIPTION'
            DataSource = DataSource
            ReadOnly = True
            TabOrder = 4
          end
          object DBEditX: TDBEdit
            Left = 103
            Top = 58
            Width = 50
            Height = 21
            Color = clBtnFace
            DataField = 'COORDINATE_X'
            DataSource = DataSource
            ReadOnly = True
            TabOrder = 1
          end
          object DBEditY: TDBEdit
            Left = 259
            Top = 58
            Width = 50
            Height = 21
            Color = clBtnFace
            DataField = 'COORDINATE_Y'
            DataSource = DataSource
            ReadOnly = True
            TabOrder = 2
          end
          object DBEditZ: TDBEdit
            Left = 405
            Top = 58
            Width = 50
            Height = 21
            Color = clBtnFace
            DataField = 'COORDINATE_Z'
            DataSource = DataSource
            ReadOnly = True
            TabOrder = 3
          end
          object DBMemoObjectPaths: TDBMemo
            Left = 103
            Top = 6
            Width = 352
            Height = 46
            Anchors = [akLeft, akTop, akRight]
            Color = clBtnFace
            DataField = 'OBJECT_PATHS'
            DataSource = DataSource
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
            WordWrap = False
          end
        end
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 366
    Width = 507
    ExplicitWidth = 507
    inherited ButtonCancel: TButton
      Left = 426
      ExplicitLeft = 426
    end
    inherited ButtonOk: TButton
      Left = 344
      ExplicitLeft = 344
    end
  end
  inherited PopupMenuFilter: TPopupMenu
    Left = 288
    Top = 130
  end
end
