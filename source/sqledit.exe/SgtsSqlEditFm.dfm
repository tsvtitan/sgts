object SgtsSqlEditForm: TSgtsSqlEditForm
  Left = 365
  Top = 171
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' SQL '#1089#1082#1088#1080#1087#1090#1086#1074
  ClientHeight = 513
  ClientWidth = 772
  Color = clBtnFace
  Constraints.MinHeight = 540
  Constraints.MinWidth = 780
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 772
    Height = 513
    ActivePage = TabSheet2
    Align = alClient
    HotTrack = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        764
        485)
      object Label1: TLabel
        Left = 18
        Top = 15
        Width = 96
        Height = 13
        Caption = #1055#1072#1087#1082#1072' '#1082' '#1089#1082#1088#1080#1087#1090#1072#1084':'
        FocusControl = EditDir
      end
      object EditDir: TEdit
        Left = 120
        Top = 12
        Width = 543
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'U:\sql\'
      end
      object ButtonDir: TButton
        Left = 676
        Top = 11
        Width = 75
        Height = 23
        Anchors = [akTop, akRight]
        Caption = #1042#1099#1073#1088#1072#1090#1100
        TabOrder = 1
        OnClick = ButtonDirClick
      end
      object GroupBox1: TGroupBox
        Left = 13
        Top = 41
        Width = 738
        Height = 400
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = ' '#1059#1089#1083#1086#1074#1080#1103' '
        TabOrder = 2
        object Panel3: TPanel
          Left = 2
          Top = 15
          Width = 734
          Height = 342
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            734
            342)
          object Label2: TLabel
            Left = 28
            Top = 43
            Width = 126
            Height = 13
            Caption = #1054#1087#1077#1088#1072#1090#1086#1088#1099' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
            FocusControl = MemoWordsFrom
          end
          object Label3: TLabel
            Left = 450
            Top = 43
            Width = 50
            Height = 13
            Anchors = [akTop, akRight]
            Caption = #1044#1077#1083#1080#1090#1077#1083#1080
            FocusControl = MemoWordsDelim
          end
          object Label5: TLabel
            Left = 28
            Top = 16
            Width = 104
            Height = 13
            Alignment = taRightJustify
            Caption = #1053#1072#1095#1072#1083#1086' '#1087#1088#1080#1084#1077#1095#1072#1085#1080#1103':'
          end
          object Label6: TLabel
            Left = 441
            Top = 16
            Width = 122
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1087#1088#1080#1084#1077#1095#1072#1085#1080#1103':'
          end
          object MemoWordsFrom: TMemo
            Left = 26
            Top = 61
            Width = 255
            Height = 270
            Anchors = [akLeft, akTop, akBottom]
            Lines.Strings = (
              'CREATE'
              'DROP'
              'ALTER'
              'INSERT'
              'UPDATE'
              'DELETE'
              'COMMIT'
              'GRANT'
              'REVOKE'
              'DECLARE'
              'BEGIN')
            TabOrder = 0
          end
          object MemoWordsDelim: TMemo
            Left = 452
            Top = 61
            Width = 259
            Height = 270
            Anchors = [akTop, akRight, akBottom]
            Lines.Strings = (
              '--')
            TabOrder = 1
          end
          object EditBegin: TEdit
            Left = 144
            Top = 13
            Width = 137
            Height = 21
            TabOrder = 2
            Text = '/*'
          end
          object EditEnd: TEdit
            Left = 575
            Top = 13
            Width = 137
            Height = 21
            Anchors = [akTop, akRight]
            TabOrder = 3
            Text = '*/'
          end
        end
        object Panel4: TPanel
          Left = 2
          Top = 357
          Width = 734
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          DesignSize = (
            734
            41)
          object Button3: TButton
            Left = 198
            Top = 9
            Width = 343
            Height = 23
            Anchors = [akLeft, akRight, akBottom]
            Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100
            TabOrder = 0
            OnClick = Button3Click
          end
        end
      end
      object ProgressBar: TProgressBar
        Left = 16
        Top = 458
        Width = 735
        Height = 16
        Anchors = [akLeft, akRight, akBottom]
        TabOrder = 3
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 352
        Top = 0
        Height = 485
      end
      object PanelScript: TPanel
        Left = 0
        Top = 0
        Width = 352
        Height = 485
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 3
        TabOrder = 0
        object Panel2: TPanel
          Left = 3
          Top = 3
          Width = 346
          Height = 38
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object ButtonLoad: TButton
            Left = 4
            Top = 4
            Width = 75
            Height = 25
            Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
            TabOrder = 0
            OnClick = ButtonLoadClick
          end
          object ButtonSave: TButton
            Left = 89
            Top = 4
            Width = 75
            Height = 25
            Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
            TabOrder = 1
            OnClick = ButtonSaveClick
          end
          object ButtonClear: TButton
            Left = 173
            Top = 4
            Width = 75
            Height = 25
            Caption = #1054#1095#1080#1089#1090#1080#1090#1100
            TabOrder = 2
            OnClick = ButtonClearClick
          end
          object btUpColumns: TBitBtn
            Left = 256
            Top = 4
            Width = 25
            Height = 25
            Hint = #1042#1074#1077#1088#1093
            TabOrder = 3
            OnClick = btUpColumnsClick
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
          object btDownColumns: TBitBtn
            Left = 287
            Top = 4
            Width = 25
            Height = 25
            Hint = #1042#1085#1080#1079
            TabOrder = 4
            OnClick = btDownColumnsClick
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
        end
        object DBNavigator: TDBNavigator
          Left = 3
          Top = 459
          Width = 346
          Height = 23
          DataSource = DataSourceScript
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
          Align = alBottom
          Flat = True
          TabOrder = 1
        end
      end
      object Panel1: TPanel
        Left = 355
        Top = 0
        Width = 409
        Height = 485
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        TabOrder = 1
        object PageControlValue: TPageControl
          Left = 5
          Top = 5
          Width = 399
          Height = 475
          ActivePage = TabSheetTable
          Align = alClient
          Style = tsFlatButtons
          TabOrder = 0
          object TabSheetUnknown: TTabSheet
            Caption = #1053#1077#1080#1079#1074#1077#1089#1090#1085#1086
            ImageIndex = 2
            TabVisible = False
          end
          object TabSheetQuery: TTabSheet
            Caption = #1047#1072#1087#1088#1086#1089#1099
            TabVisible = False
            object MemoScript: TMemo
              Left = 0
              Top = 0
              Width = 391
              Height = 465
              Align = alClient
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 0
              WordWrap = False
            end
          end
          object TabSheetTable: TTabSheet
            Caption = #1058#1072#1073#1083#1080#1094#1072
            ImageIndex = 1
            TabVisible = False
            inline TableEditFrame: TSgtsTableEditFrame
              Left = 0
              Top = 0
              Width = 391
              Height = 465
              Align = alClient
              TabOrder = 0
              ExplicitWidth = 391
              ExplicitHeight = 465
              inherited Splitter: TSplitter
                Top = 334
                Width = 391
                ExplicitTop = 334
                ExplicitWidth = 391
              end
              inherited PanelTop: TPanel
                Width = 391
                ExplicitWidth = 391
                inherited LabelTableName: TLabel
                  Left = 16
                  Width = 71
                  ExplicitLeft = 16
                  ExplicitWidth = 71
                end
              end
              inherited PanelGrid: TPanel
                Width = 391
                Height = 275
                ExplicitWidth = 391
                ExplicitHeight = 275
                inherited DBNavigator: TDBNavigator
                  Top = 247
                  Width = 385
                  Hints.Strings = ()
                  ExplicitTop = 247
                  ExplicitWidth = 385
                end
              end
              inherited PanelBottom: TPanel
                Top = 337
                Width = 391
                ExplicitTop = 337
                ExplicitWidth = 391
                inherited GroupBoxValue: TGroupBox
                  Width = 385
                  ExplicitWidth = 385
                  inherited PanelValue: TPanel
                    Width = 381
                    ExplicitWidth = 381
                    inherited PanelValueButton: TPanel
                      Left = 287
                      ExplicitLeft = 287
                    end
                    inherited PanelMemo: TPanel
                      Width = 282
                      ExplicitWidth = 282
                      inherited LabelFilter: TLabel
                        Width = 43
                        ExplicitWidth = 43
                      end
                      inherited DBMemoValue: TDBMemo
                        Width = 282
                        ExplicitWidth = 282
                      end
                    end
                  end
                end
              end
            end
          end
          object TabSheetFile: TTabSheet
            Caption = #1060#1072#1081#1083
            ImageIndex = 3
            TabVisible = False
            object MemoFile: TMemo
              Left = 0
              Top = 0
              Width = 391
              Height = 465
              Align = alClient
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 0
              WordWrap = False
            end
          end
        end
      end
    end
  end
  object OpenDialogScript: TOpenDialog
    DefaultExt = '*.que'
    Filter = 
      'Query '#1092#1072#1081#1083#1099' (*.que)|*.que|Result '#1092#1072#1081#1083#1099' (*.rsl)|*.rsl|Sql '#1092#1072#1081#1083#1099' (' +
      '*.sql)|*.sql|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    FilterIndex = 0
    Left = 40
    Top = 80
  end
  object SaveDialogScript: TSaveDialog
    DefaultExt = '*.que'
    Filter = 'Query '#1092#1072#1081#1083#1099' (*.que)|*.que|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    FilterIndex = 0
    Left = 40
    Top = 136
  end
  object DataSourceScript: TDataSource
    Left = 44
    Top = 184
  end
  object XPManifest: TXPManifest
    Left = 147
    Top = 128
  end
  object PopupMenuLoad: TPopupMenu
    Left = 40
    Top = 240
    object Sql1: TMenuItem
      Caption = 'Sql '#1092#1072#1081#1083
      OnClick = Sql1Click
    end
    object Query1: TMenuItem
      Caption = 'Query '#1092#1072#1081#1083
      OnClick = Query1Click
    end
    object Result1: TMenuItem
      Caption = 'Result '#1092#1072#1081#1083
      OnClick = Result1Click
    end
  end
end
