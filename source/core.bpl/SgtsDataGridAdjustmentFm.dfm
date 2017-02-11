inherited SgtsDataGridAdjustmentForm: TSgtsDataGridAdjustmentForm
  Left = 541
  Top = 394
  Width = 370
  Height = 350
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
  Constraints.MinHeight = 350
  Constraints.MinWidth = 350
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelDialog: TPanel
    Width = 362
    Height = 285
    Caption = #1053#1077#1090' '#1085#1080' '#1086#1076#1085#1086#1081' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
    object PageControl: TPageControl
      Left = 0
      Top = 0
      Width = 362
      Height = 285
      ActivePage = TabSheetFilters
      Align = alClient
      TabOrder = 0
      object TabSheetColumns: TTabSheet
        Caption = #1050#1086#1083#1086#1085#1082#1080
        object PanelClientColumns: TPanel
          Left = 0
          Top = 0
          Width = 354
          Height = 227
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 3
          TabOrder = 0
          object PanelButtonColumns: TPanel
            Left = 308
            Top = 3
            Width = 43
            Height = 221
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 1
            object ButtonUpColumns: TBitBtn
              Left = 1
              Top = 4
              Width = 40
              Height = 25
              Hint = #1042#1074#1077#1088#1093
              TabOrder = 0
              OnClick = ButtonUpColumnsClick
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                8888888888888888888888888888888888888888888888888888888880000088
                8888888880666088888888888066608888888888806660888888880000666000
                0888888066666660888888880666660888888888806660888888888888060888
                8888888888808888888888888888888888888888888888888888}
            end
            object ButtonDownColumns: TBitBtn
              Left = 1
              Top = 36
              Width = 40
              Height = 25
              Hint = #1042#1085#1080#1079
              TabOrder = 1
              OnClick = ButtonDownColumnsClick
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                8888888888888888888888888888888888888888888888888888888888808888
                8888888888060888888888888066608888888888066666088888888066666660
                8888880000666000088888888066608888888888806660888888888880666088
                8888888880000088888888888888888888888888888888888888}
            end
            object ButtonCheckAllColumns: TBitBtn
              Left = 1
              Top = 68
              Width = 40
              Height = 25
              Hint = #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077
              TabOrder = 2
              OnClick = ButtonCheckAllColumnsClick
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                04000000000080000000120B0000120B00001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
                DADAADADADADADADADADDFFFFFFFFFFFFFDAA788888888888FADD70FFFFFFFFF
                8FDAA70FFF0FFFFF8FADD70FF000FFFF8FDAA70F00000FFF8FADD70F00F000FF
                8FDAA70F0FFF000F8FADD70FFFFFF00F8FDAA70FFFFFFF0F8FADD70FFFFFFFFF
                8FDAA700000000008FADD777777777777FDAADADADADADADADAD}
            end
            object ButtonUnCheckAllColumns: TBitBtn
              Left = 1
              Top = 100
              Width = 40
              Height = 25
              Hint = #1059#1073#1088#1072#1090#1100' '#1074#1099#1073#1086#1088' '#1074#1089#1077#1093
              TabOrder = 3
              OnClick = ButtonUnCheckAllColumnsClick
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                04000000000080000000120B0000120B00001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                888888888888888888888FFFFFFFFFFFFF888788888888888F88870FFFFFFFFF
                8F88870FFFFFFFFF8F88870FFFFFFFFF8F88870FFFFFFFFF8F88870FFFFFFFFF
                8F88870FFFFFFFFF8F88870FFFFFFFFF8F88870FFFFFFFFF8F88870FFFFFFFFF
                8F888700000000008F888777777777777F888888888888888888}
            end
          end
          object PanelCheckListBoxColumns: TPanel
            Left = 3
            Top = 3
            Width = 305
            Height = 221
            Align = alClient
            BevelOuter = bvNone
            BorderWidth = 5
            TabOrder = 0
            object CheckListBoxColumns: TCheckListBox
              Left = 5
              Top = 5
              Width = 295
              Height = 211
              OnClickCheck = CheckListBoxColumnsClickCheck
              Align = alClient
              Flat = False
              ItemHeight = 14
              Style = lbOwnerDrawVariable
              TabOrder = 0
              OnDblClick = CheckListBoxColumnsDblClick
              OnDragDrop = CheckListBoxColumnsDragDrop
              OnDragOver = CheckListBoxColumnsDragOver
              OnMouseMove = CheckListBoxColumnsMouseMove
            end
          end
        end
        object PanelBottomColumns: TPanel
          Left = 0
          Top = 227
          Width = 354
          Height = 30
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          DesignSize = (
            354
            30)
          object ButtonDefaultColumns: TButton
            Left = 9
            Top = 0
            Width = 97
            Height = 25
            Anchors = [akLeft, akBottom]
            Caption = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
            TabOrder = 0
            OnClick = ButtonDefaultColumnsClick
          end
          object CheckBoxColumnsAuto: TCheckBox
            Left = 117
            Top = 4
            Width = 156
            Height = 17
            Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1072#1103' '#1096#1080#1088#1080#1085#1072
            TabOrder = 1
          end
        end
      end
      object TabSheetOrders: TTabSheet
        Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072
        ImageIndex = 1
        object PanelClientOrders: TPanel
          Left = 0
          Top = 0
          Width = 354
          Height = 197
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 3
          TabOrder = 0
          object PanelButtonOrders: TPanel
            Left = 308
            Top = 3
            Width = 43
            Height = 191
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 1
            object ButtonUpOrders: TBitBtn
              Left = 1
              Top = 4
              Width = 40
              Height = 25
              Hint = #1042#1074#1077#1088#1093
              TabOrder = 0
              OnClick = ButtonUpOrdersClick
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                8888888888888888888888888888888888888888888888888888888880000088
                8888888880666088888888888066608888888888806660888888880000666000
                0888888066666660888888880666660888888888806660888888888888060888
                8888888888808888888888888888888888888888888888888888}
            end
            object ButtonDownOrders: TBitBtn
              Left = 1
              Top = 36
              Width = 40
              Height = 25
              Hint = #1042#1085#1080#1079
              TabOrder = 1
              OnClick = ButtonDownOrdersClick
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                8888888888888888888888888888888888888888888888888888888888808888
                8888888888060888888888888066608888888888066666088888888066666660
                8888880000666000088888888066608888888888806660888888888880666088
                8888888880000088888888888888888888888888888888888888}
            end
            object ButtonCheckAllOrders: TBitBtn
              Left = 1
              Top = 68
              Width = 40
              Height = 25
              Hint = #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077
              TabOrder = 2
              OnClick = ButtonCheckAllOrdersClick
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                04000000000080000000120B0000120B00001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
                DADAADADADADADADADADDFFFFFFFFFFFFFDAA788888888888FADD70FFFFFFFFF
                8FDAA70FFF0FFFFF8FADD70FF000FFFF8FDAA70F00000FFF8FADD70F00F000FF
                8FDAA70F0FFF000F8FADD70FFFFFF00F8FDAA70FFFFFFF0F8FADD70FFFFFFFFF
                8FDAA700000000008FADD777777777777FDAADADADADADADADAD}
            end
            object ButtonUnCheckAllOrders: TBitBtn
              Left = 1
              Top = 100
              Width = 40
              Height = 25
              Hint = #1059#1073#1088#1072#1090#1100' '#1074#1099#1073#1086#1088' '#1074#1089#1077#1093
              TabOrder = 3
              OnClick = ButtonUnCheckAllOrdersClick
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                04000000000080000000120B0000120B00001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                888888888888888888888FFFFFFFFFFFFF888788888888888F88870FFFFFFFFF
                8F88870FFFFFFFFF8F88870FFFFFFFFF8F88870FFFFFFFFF8F88870FFFFFFFFF
                8F88870FFFFFFFFF8F88870FFFFFFFFF8F88870FFFFFFFFF8F88870FFFFFFFFF
                8F888700000000008F888777777777777F888888888888888888}
            end
          end
          object PanelCheckListBoxOrders: TPanel
            Left = 3
            Top = 3
            Width = 305
            Height = 191
            Align = alClient
            BevelOuter = bvNone
            BorderWidth = 5
            TabOrder = 0
            object CheckListBoxOrders: TCheckListBox
              Left = 5
              Top = 5
              Width = 295
              Height = 181
              OnClickCheck = CheckListBoxColumnsClickCheck
              Align = alClient
              Flat = False
              ItemHeight = 14
              Style = lbOwnerDrawFixed
              TabOrder = 0
              OnClick = CheckListBoxOrdersClick
              OnDragDrop = CheckListBoxColumnsDragDrop
              OnDragOver = CheckListBoxColumnsDragOver
              OnDrawItem = ComboBoxOrdersDrawItem
              OnMouseMove = CheckListBoxColumnsMouseMove
            end
          end
        end
        object PanelBottomOrders: TPanel
          Left = 0
          Top = 197
          Width = 354
          Height = 60
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          DesignSize = (
            354
            60)
          object LabelOrders: TLabel
            Left = 19
            Top = 5
            Width = 85
            Height = 13
            Caption = #1042#1080#1076' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1080':'
          end
          object ButtonDefaultOrders: TButton
            Left = 9
            Top = 30
            Width = 97
            Height = 25
            Anchors = [akLeft, akBottom]
            Caption = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
            TabOrder = 1
            OnClick = ButtonDefaultOrdersClick
          end
          object ComboBoxOrders: TComboBox
            Left = 112
            Top = 2
            Width = 161
            Height = 20
            Style = csOwnerDrawFixed
            ItemHeight = 14
            TabOrder = 0
            OnChange = ComboBoxOrdersChange
            OnDrawItem = ComboBoxOrdersDrawItem
            Items.Strings = (
              #1086#1090#1082#1083#1102#1095#1077#1085#1086
              #1087#1086' '#1074#1086#1079#1088#1072#1089#1090#1072#1085#1080#1102
              #1087#1086' '#1091#1073#1099#1074#1072#1085#1080#1102)
          end
        end
      end
      object TabSheetFilters: TTabSheet
        Caption = #1060#1080#1083#1100#1090#1088
        ImageIndex = 2
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 354
          Height = 227
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 3
          TabOrder = 0
          object Panel2: TPanel
            Left = 308
            Top = 3
            Width = 43
            Height = 221
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 1
            object ButtonUpFilters: TBitBtn
              Left = 1
              Top = 4
              Width = 40
              Height = 25
              Hint = #1042#1074#1077#1088#1093
              TabOrder = 0
              OnClick = ButtonUpFiltersClick
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                8888888888888888888888888888888888888888888888888888888880000088
                8888888880666088888888888066608888888888806660888888880000666000
                0888888066666660888888880666660888888888806660888888888888060888
                8888888888808888888888888888888888888888888888888888}
            end
            object ButtonDownFilters: TBitBtn
              Left = 1
              Top = 36
              Width = 40
              Height = 25
              Hint = #1042#1085#1080#1079
              TabOrder = 1
              OnClick = ButtonDownFiltersClick
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                8888888888888888888888888888888888888888888888888888888888808888
                8888888888060888888888888066608888888888066666088888888066666660
                8888880000666000088888888066608888888888806660888888888880666088
                8888888880000088888888888888888888888888888888888888}
            end
            object ButtonCheckAllFilters: TBitBtn
              Left = 1
              Top = 68
              Width = 40
              Height = 25
              Hint = #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077
              TabOrder = 2
              OnClick = ButtonCheckAllFiltersClick
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                04000000000080000000120B0000120B00001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
                DADAADADADADADADADADDFFFFFFFFFFFFFDAA788888888888FADD70FFFFFFFFF
                8FDAA70FFF0FFFFF8FADD70FF000FFFF8FDAA70F00000FFF8FADD70F00F000FF
                8FDAA70F0FFF000F8FADD70FFFFFF00F8FDAA70FFFFFFF0F8FADD70FFFFFFFFF
                8FDAA700000000008FADD777777777777FDAADADADADADADADAD}
            end
            object ButtonUnCheckAllFilters: TBitBtn
              Left = 1
              Top = 100
              Width = 40
              Height = 25
              Hint = #1059#1073#1088#1072#1090#1100' '#1074#1099#1073#1086#1088' '#1074#1089#1077#1093
              TabOrder = 3
              OnClick = ButtonUnCheckAllFiltersClick
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                04000000000080000000120B0000120B00001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                888888888888888888888FFFFFFFFFFFFF888788888888888F88870FFFFFFFFF
                8F88870FFFFFFFFF8F88870FFFFFFFFF8F88870FFFFFFFFF8F88870FFFFFFFFF
                8F88870FFFFFFFFF8F88870FFFFFFFFF8F88870FFFFFFFFF8F88870FFFFFFFFF
                8F888700000000008F888777777777777F888888888888888888}
            end
          end
          object Panel3: TPanel
            Left = 3
            Top = 3
            Width = 305
            Height = 221
            Align = alClient
            BevelOuter = bvNone
            BorderWidth = 5
            TabOrder = 0
            object SplitterFilters1: TSplitter
              Left = 5
              Top = 147
              Width = 295
              Height = 5
              Cursor = crVSplit
              Align = alBottom
              MinSize = 50
            end
            object SplitterFilters2: TSplitter
              Left = 5
              Top = 60
              Width = 295
              Height = 5
              Cursor = crVSplit
              Align = alTop
              MinSize = 50
            end
            object CheckListBoxFilters: TCheckListBox
              Left = 5
              Top = 65
              Width = 295
              Height = 82
              OnClickCheck = CheckListBoxFiltersClickCheck
              Align = alClient
              Flat = False
              ItemHeight = 14
              Style = lbOwnerDrawFixed
              TabOrder = 0
              OnClick = CheckListBoxFiltersClick
              OnDragDrop = CheckListBoxColumnsDragDrop
              OnDragOver = CheckListBoxColumnsDragOver
              OnMouseMove = CheckListBoxColumnsMouseMove
            end
            object GroupBoxFilters: TGroupBox
              Left = 5
              Top = 5
              Width = 295
              Height = 55
              Align = alTop
              Caption = ' '#1056#1077#1079#1091#1083#1100#1090#1072#1090' '
              Constraints.MinHeight = 50
              TabOrder = 1
              object PanelMemoFilters: TPanel
                Left = 2
                Top = 15
                Width = 291
                Height = 38
                Align = alClient
                BevelOuter = bvNone
                BorderWidth = 3
                TabOrder = 0
                object MemoFilters: TMemo
                  Left = 3
                  Top = 3
                  Width = 285
                  Height = 32
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
            object PanelGridFilters: TPanel
              Left = 5
              Top = 152
              Width = 295
              Height = 64
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 2
              object GridFilters: TDBGrid
                Left = 0
                Top = 0
                Width = 264
                Height = 64
                Align = alClient
                Constraints.MinHeight = 50
                DataSource = DataSourceFilters
                Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete]
                TabOrder = 0
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -11
                TitleFont.Name = 'Tahoma'
                TitleFont.Style = []
                OnExit = GridFiltersExit
                Columns = <
                  item
                    Alignment = taCenter
                    Expanded = False
                    FieldName = 'OPERATOR'
                    Title.Alignment = taCenter
                    Title.Caption = #1054#1087#1077#1088#1072#1090#1086#1088
                    Width = 60
                    Visible = True
                  end
                  item
                    Alignment = taCenter
                    Expanded = False
                    FieldName = 'CONDITION'
                    Title.Alignment = taCenter
                    Title.Caption = #1059#1089#1083#1086#1074#1080#1077
                    Width = 70
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'VALUE'
                    Title.Caption = #1047#1085#1072#1095#1077#1085#1080#1077
                    Width = 95
                    Visible = True
                  end>
              end
              object PanelGridButtons: TPanel
                Left = 264
                Top = 0
                Width = 31
                Height = 64
                Align = alRight
                BevelOuter = bvNone
                TabOrder = 1
                DesignSize = (
                  31
                  64)
                object ButtonAddFilter: TBitBtn
                  Left = 4
                  Top = 0
                  Width = 27
                  Height = 25
                  Hint = #1044#1086#1073#1072#1074#1080#1090#1100
                  Anchors = [akTop, akRight]
                  Caption = '+'
                  TabOrder = 0
                  OnClick = ButtonAddFilterClick
                end
                object ButtonDeleteFilter: TBitBtn
                  Left = 4
                  Top = 31
                  Width = 27
                  Height = 25
                  Hint = #1059#1076#1072#1083#1080#1090#1100
                  Anchors = [akTop, akRight]
                  Caption = '-'
                  TabOrder = 1
                  OnClick = ButtonDeleteFilterClick
                end
              end
            end
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 227
          Width = 354
          Height = 30
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          DesignSize = (
            354
            30)
          object ButtonDefaultFilters: TButton
            Left = 9
            Top = 0
            Width = 97
            Height = 25
            Anchors = [akLeft, akBottom]
            Caption = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
            TabOrder = 0
            OnClick = ButtonDefaultFiltersClick
          end
        end
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 285
    Width = 362
    DesignSize = (
      362
      38)
    inherited ButtonOk: TButton
      Left = 200
    end
    inherited ButtonCancel: TButton
      Left = 282
    end
  end
  object ImageList: TImageList
    Height = 14
    Width = 14
    Left = 56
    Top = 49
    Bitmap = {
      494C01010300040004000E000E00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000380000000E0000000100200000000000400C
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000380000000E0000000100010000000000700000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFC00000FFFFFFFFFFC00000
      FFFFFFFFFFC00000FFFFFFFFFFC00000C71FFFFFFFC00000E23FF7FC01C00000
      F07FE3FE03C00000F8FFC1FF07C00000F07F80FF8FC00000E23F007FDFC00000
      C71FFFFFFFC00000FFFFFFFFFFC00000FFFFFFFFFFC00000FFFFFFFFFFC00000
      00000000000000000000000000000000000000000000}
  end
  object DataSourceFilters: TDataSource
    DataSet = ClientDataSetFilters
    Left = 79
    Top = 179
  end
  object ClientDataSetFilters: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 183
    Top = 179
    Data = {
      6F0000009619E0BD0100000018000000030000000000030000006F00084F5045
      5241544F52010049000000010005574944544802000200030009434F4E444954
      494F4E01004900000001000557494454480200020032000556414C5545010049
      00000001000557494454480200020064000000}
    object ClientDataSetFiltersOPERATOR: TStringField
      FieldName = 'OPERATOR'
      OnSetText = ClientDataSetFiltersOPERATORSetText
      Size = 3
    end
    object ClientDataSetFiltersCONDITION: TStringField
      FieldName = 'CONDITION'
      OnSetText = ClientDataSetFiltersCONDITIONSetText
      Size = 50
    end
    object ClientDataSetFiltersVALUE: TStringField
      FieldName = 'VALUE'
      OnSetText = ClientDataSetFiltersVALUESetText
      Size = 100
    end
  end
end
