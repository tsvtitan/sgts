inherited SgtsGrpJournalRefreshForm: TSgtsGrpJournalRefreshForm
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelDialog: TPanel
    inherited PanelAxis: TPanel
      Top = 123
      Height = 162
      TabOrder = 2
      inherited GroupBoxAxis: TGroupBox
        Height = 156
        inherited PanelAxis2: TPanel
          Height = 139
          inherited TabControlAxis: TTabControl
            Height = 135
            inherited CheckListBoxParams: TCheckListBox
              Height = 104
            end
          end
        end
      end
    end
    object PanelFilter: TPanel
      Left = 0
      Top = 58
      Width = 342
      Height = 65
      Align = alTop
      BevelOuter = bvNone
      BorderWidth = 3
      TabOrder = 1
      object GroupBoxFilter: TGroupBox
        Left = 3
        Top = 3
        Width = 336
        Height = 59
        Align = alClient
        Caption = ' '#1060#1080#1083#1100#1090#1088'  '
        TabOrder = 0
        object PanelMemoFilters: TPanel
          Left = 2
          Top = 15
          Width = 332
          Height = 42
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 3
          TabOrder = 0
          object MemoFilters: TMemo
            Left = 3
            Top = 3
            Width = 326
            Height = 36
            Align = alClient
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
      end
    end
  end
end