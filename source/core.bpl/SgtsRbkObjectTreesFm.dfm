inherited SgtsRbkObjectTreesForm: TSgtsRbkObjectTreesForm
  Left = 396
  Top = 277
  Caption = #1044#1077#1088#1077#1074#1086' '#1086#1073#1098#1077#1082#1090#1086#1074
  ClientHeight = 429
  ClientWidth = 692
  Constraints.MinHeight = 475
  Constraints.MinWidth = 700
  ExplicitWidth = 700
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited BevelStatus: TBevel
    Top = 405
    Width = 692
    ExplicitWidth = 692
  end
  inherited StatusBar: TStatusBar
    Top = 408
    Width = 692
    ExplicitTop = 398
    ExplicitWidth = 692
  end
  inherited ToolBar: TToolBar
    Height = 366
    ExplicitHeight = 356
  end
  inherited PanelView: TPanel
    Width = 657
    Height = 366
    ExplicitWidth = 657
    ExplicitHeight = 356
    object Splitter: TSplitter [0]
      Left = 253
      Top = 3
      Height = 360
      MinSize = 200
      ExplicitHeight = 369
    end
    inherited TreePattern: TTreeView
      Width = 250
      Height = 360
      Align = alLeft
      Constraints.MinWidth = 200
      ExplicitWidth = 250
      ExplicitHeight = 350
    end
    object PanelInfo: TPanel
      Left = 256
      Top = 3
      Width = 398
      Height = 360
      Align = alClient
      BevelOuter = bvNone
      Caption = #1053#1077#1090' '#1076#1086#1089#1090#1091#1087#1085#1086#1081' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080
      TabOrder = 1
      ExplicitHeight = 350
      object BevelTop: TBevel
        Left = 0
        Top = 19
        Width = 398
        Height = 6
        Align = alTop
        Shape = bsSpacer
      end
      object BevelLeft: TBevel
        Left = 0
        Top = 25
        Width = 3
        Height = 335
        Align = alLeft
        Shape = bsSpacer
        ExplicitHeight = 344
      end
      object PanelTop: TPanel
        Left = 0
        Top = 0
        Width = 398
        Height = 19
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object PanelCaption: TPanel
          Left = 0
          Top = 0
          Width = 398
          Height = 19
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 3
          Color = clInactiveCaption
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object LabelCaption: TLabel
            Left = 3
            Top = 3
            Width = 392
            Height = 13
            Align = alClient
            Caption = #1053#1077#1090' '#1076#1086#1089#1090#1091#1087#1085#1086#1081' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080
            Transparent = False
            Layout = tlCenter
            ExplicitWidth = 162
          end
        end
      end
      object PageControlInfo: TPageControl
        Left = 3
        Top = 25
        Width = 395
        Height = 335
        ActivePage = TabSheetGeneral
        Align = alClient
        HotTrack = True
        Style = tsFlatButtons
        TabOrder = 1
        ExplicitHeight = 325
        object TabSheetGeneral: TTabSheet
          Caption = #1054#1073#1097#1072#1103
          ExplicitHeight = 294
          DesignSize = (
            387
            304)
          object LabelDesc: TLabel
            Left = 12
            Top = 12
            Width = 53
            Height = 13
            Alignment = taRightJustify
            Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
            FocusControl = DBMemoDesc
          end
          object DBMemoDesc: TDBMemo
            Left = 72
            Top = 9
            Width = 298
            Height = 112
            Anchors = [akLeft, akTop, akRight]
            Color = clBtnFace
            DataField = 'OBJECT_DESCRIPTION'
            DataSource = DataSource
            ReadOnly = True
            TabOrder = 0
          end
        end
        object TabSheetDrawings: TTabSheet
          Caption = #1063#1077#1088#1090#1077#1078#1080
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object TabSheetDocuments: TTabSheet
          Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object TabSheetPassports: TTabSheet
          Caption = #1055#1072#1089#1087#1086#1088#1090
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
      end
    end
  end
  inherited PanelButton: TPanel
    Top = 366
    Width = 692
    ExplicitWidth = 692
    inherited ButtonCancel: TButton
      Left = 611
      ExplicitLeft = 611
    end
    inherited ButtonOk: TButton
      Left = 529
      ExplicitLeft = 529
    end
  end
end
