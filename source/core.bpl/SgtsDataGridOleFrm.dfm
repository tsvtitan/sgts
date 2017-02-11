inherited SgtsDataGridOleFrame: TSgtsDataGridOleFrame
  inherited ToolBar: TToolBar
    object ToolButtonView: TToolButton
      Left = 128
      Top = 0
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088
      Enabled = False
      ImageIndex = 4
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButtonViewClick
    end
  end
  inherited PanelView: TPanel
    object Splitter: TSplitter [0]
      Left = 3
      Top = 103
      Width = 437
      Height = 3
      Cursor = crVSplit
      Align = alTop
      MinSize = 100
    end
    inherited GridPattern: TDBGrid
      Height = 100
      Align = alTop
      Constraints.MinHeight = 100
    end
    object PanelOle: TPanel
      Left = 3
      Top = 106
      Width = 437
      Height = 132
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object OleContainer: TOleContainer
        Left = 0
        Top = 24
        Width = 437
        Height = 108
        AllowInPlace = False
        AutoActivate = aaManual
        AutoVerbMenu = False
        Align = alClient
        Caption = 'OLE '#1082#1086#1085#1090#1077#1081#1085#1077#1088
        SizeMode = smScale
        TabOrder = 0
      end
      object PanelCheck: TPanel
        Left = 0
        Top = 0
        Width = 437
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object CheckBoxPreview: TCheckBox
          Left = 4
          Top = 3
          Width = 177
          Height = 17
          Caption = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1087#1088#1086#1089#1084#1086#1090#1088
          TabOrder = 0
          OnClick = CheckBoxPreviewClick
        end
      end
    end
  end
end
