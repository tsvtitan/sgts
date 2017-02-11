unit SgtsRbkObjectTreesFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ExtCtrls, ComCtrls, ToolWin, StdCtrls, DBCtrls,
  SgtsDataTreeFm, SgtsSelectDefs,  SgtsCoreIntf, SgtsRbkObjectDrawingsFrm,
  SgtsDataIfaceIntf, SgtsRbkObjectDocumentsFrm, SgtsDataGridFrm, SgtsControls;

type
  TSgtsRbkObjectTreesForm = class(TSgtsDataTreeForm)
    PanelInfo: TPanel;
    BevelTop: TBevel;
    BevelLeft: TBevel;
    PanelTop: TPanel;
    PanelCaption: TPanel;
    LabelCaption: TLabel;
    PageControlInfo: TPageControl;
    TabSheetGeneral: TTabSheet;
    LabelDesc: TLabel;
    DBMemoDesc: TDBMemo;
    TabSheetDrawings: TTabSheet;
    TabSheetDocuments: TTabSheet;
    TabSheetPassports: TTabSheet;
    Splitter: TSplitter;
  private
    FrameObjectDrawings: TSgtsRbkObjectDrawingsFrame;
    FrameObjectDocuments: TSgtsRbkObjectDocumentsFrame;
    FrameObjectPassports: TSgtsDataGridFrame;

    procedure ActivateDrawings;
    procedure ActivateDocuments;
    procedure ActivatePassports;
  protected
    function GetIfaceIntf: ISgtsDataIface; override;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkObjectTreesIface=class(TSgtsDataTreeIface)
  private
    FOldObjectId: Variant;
    function GetForm: TSgtsRbkObjectTreesForm;
  protected
    procedure DataSetAfterScroll(DataSet: TDataSet); override;
  public
    procedure Init; override;

    property Form: TSgtsRbkObjectTreesForm read GetForm;
  end;   

var
  SgtsRbkObjectTreesForm: TSgtsRbkObjectTreesForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS, SgtsGetRecordsConfig,
     SgtsConsts, SgtsRbkObjectTreeEditFm, SgtsRbkObjectPassportIfaces;

{$R *.dfm}

{ TSgtsRbkObjectTreesIface }

procedure TSgtsRbkObjectTreesIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkObjectTreesForm;
  InterfaceName:=SInterfaceObjectTrees;
  with InsertClasses do begin
    Add(TSgtsRbkObjectTreeInsertIface);
    Add(TSgtsRbkObjectTreeInsertChildIface);
  end;
  UpdateClass:=TSgtsRbkObjectTreeUpdateIface;
  DeleteClass:=TSgtsRbkObjectTreeDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectObjectTrees;
    with SelectDefs do begin
      AddKey('OBJECT_TREE_ID');
      Add('OBJECT_NAME','Наименование объекта');
      AddInvisible('OBJECT_DESCRIPTION');
      AddInvisible('PARENT_ID');
      AddInvisible('OBJECT_ID');
      AddInvisible('PARENT_NAME');
      AddInvisible('PRIORITY');
    end;
    KeyFieldName:='OBJECT_TREE_ID';
    ViewFieldName:='OBJECT_NAME';
    ParentFieldName:='PARENT_ID';
  end;
end;

function TSgtsRbkObjectTreesIface.GetForm: TSgtsRbkObjectTreesForm;
begin
  Result:=TSgtsRbkObjectTreesForm(inherited Form);
end;

procedure TSgtsRbkObjectTreesIface.DataSetAfterScroll(DataSet: TDataSet);
var
  NewObjectId: Variant;
  OldCursor: TCursor;
begin
  inherited DataSetAfterScroll(DataSet);
  if DataSet.Active and not DataSet.IsEmpty then begin
    if Assigned(Form) then begin
      with Form do begin
        NewObjectId:=DataSet.FieldByName('OBJECT_ID').AsInteger;
        if (FOldObjectId<>NewObjectId) then begin

          OldCursor:=Screen.Cursor;
          Screen.Cursor:=crHourGlass;
          try
            LabelCaption.Caption:=DataSet.FieldByName('OBJECT_NAME').AsString;
            ActivateDrawings;
            ActivateDocuments;
            ACtivatePassports;
            FOldObjectId:=NewObjectId;
          finally
            Screen.Cursor:=OldCursor;
          end;  
        end;
      end;
    end;
  end else
    if Assigned(Form) then begin
      Form.LabelCaption.Caption:=Form.PanelInfo.Caption;
    end;
  UpdateButtons;    
end;

{ TSgtsRbkObjectTreesForm }

constructor TSgtsRbkObjectTreesForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);

  FrameObjectDrawings:=TSgtsRbkObjectDrawingsFrame.Create(Self);
  with FrameObjectDrawings do begin
    Name:='FrameObjectDrawings';
    Parent:=TabSheetDrawings;
  end;
  FrameObjectDrawings.InitByCore(CoreIntf);

  FrameObjectDocuments:=TSgtsRbkObjectDocumentsFrame.Create(Self);
  with FrameObjectDocuments do begin
    Name:='FrameObjectDocuments';
    Parent:=TabSheetDocuments;
  end;
  FrameObjectDocuments.InitByCore(CoreIntf);

  FrameObjectPassports:=TSgtsDataGridFrame.Create(Self);
  with FrameObjectPassports do begin
    Name:='FrameObjectPassports';
    Parent:=TabSheetPassports;
    InsertClass:=TSgtsRbkObjectPassportInsertIface;
    UpdateClass:=TSgtsRbkObjectPassportUpdateIface;
    DeleteClass:=TSgtsRbkObjectPassportDeleteIface;
    with DataSet do begin
      ProviderName:=SProviderSelectObjectPassports;
      with SelectDefs do begin
        Add('DATE_PASSPORT','Дата',70);
        Add('PARAM_NAME','Параметр',100);
        Add('VALUE','Значение',50);
        AddInvisible('OBJECT_PASSPORT_ID');
        AddInvisible('OBJECT_ID');
        AddInvisible('OBJECT_NAME');
        AddInvisible('DESCRIPTION');
      end;
    end;
  end;
  FrameObjectPassports.InitByCore(CoreIntf);

  PageControlInfo.ActivePage:=TabSheetGeneral;
end;

function TSgtsRbkObjectTreesForm.GetIfaceIntf: ISgtsDataIface;
begin
  Result:=inherited GetIfaceIntf;
  case PageControlInfo.ActivePageIndex of
    1: if ActiveControl=FrameObjectDrawings.Grid then Result:=FrameObjectDrawings;
    2: if ActiveControl=FrameObjectDocuments.Grid then Result:=FrameObjectDocuments;
    3: if ActiveControl=FrameObjectPassports.Grid then Result:=FrameObjectPassports;
  end;
end;

procedure TSgtsRbkObjectTreesForm.ActivateDrawings;
var
  AObjectId: Variant;
begin
  AObjectId:=Iface.DataSet.FieldByName('OBJECT_ID').Value;
  with FrameObjectDrawings do begin
    CloseData;
    with DataSet do begin
      FilterGroups.Clear;
      FilterGroups.Add.Filters.Add('OBJECT_ID',fcEqual,AObjectId);
      ExecuteDefs.Clear;
      ExecuteDefs.AddValue('OBJECT_ID',AObjectId);
      ExecuteDefs.AddValue('OBJECT_NAME',Iface.DataSet.FieldByName('OBJECT_NAME').Value);
    end;
    OpenData;
    UpdateButtons;
  end;
end;

procedure TSgtsRbkObjectTreesForm.ActivateDocuments;
var
  AObjectId: Variant;
begin
  AObjectId:=Iface.DataSet.FieldByName('OBJECT_ID').Value;
  with FrameObjectDocuments do begin
    CloseData;
    with DataSet do begin
      FilterGroups.Clear;
      FilterGroups.Add.Filters.Add('OBJECT_ID',fcEqual,AObjectId);
      ExecuteDefs.Clear;
      ExecuteDefs.AddValue('OBJECT_ID',AObjectId);
      ExecuteDefs.AddValue('OBJECT_NAME',Iface.DataSet.FieldByName('OBJECT_NAME').Value);
    end;
    OpenData;
    UpdateButtons;
  end;
end;

procedure TSgtsRbkObjectTreesForm.ActivatePassports;
var
  AObjectId: Variant;
begin
  AObjectId:=Iface.DataSet.FieldByName('OBJECT_ID').Value;
  with FrameObjectPassports do begin
    CloseData;
    with DataSet do begin
      FilterGroups.Clear;
      FilterGroups.Add.Filters.Add('OBJECT_ID',fcEqual,AObjectId);
      ExecuteDefs.Clear;
      ExecuteDefs.AddValue('OBJECT_ID',AObjectId);
      ExecuteDefs.AddValue('OBJECT_NAME',Iface.DataSet.FieldByName('OBJECT_NAME').Value);
    end;
    OpenData;
    UpdateButtons;
  end;
end;

end.
