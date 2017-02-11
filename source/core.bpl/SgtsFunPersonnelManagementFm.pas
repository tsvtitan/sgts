unit SgtsFunPersonnelManagementFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ExtCtrls, ComCtrls, ToolWin,
  StdCtrls, DBCtrls, Mask, VirtualTrees, VirtualDBTree, Grids, DBGrids,
  SgtsDataTreeFm, SgtsFm, SgtsDbTree,
  SgtsFunDivisionIfaces, SgtsFunPersonnelIfaces, SgtsFunAccountIfaces,
  SgtsControls, SgtsExecuteDefs, SgtsSelectDefs,
  SgtsCoreIntf;

type

  TSgtsFunPersonnelManagementForm = class(TSgtsDataTreeForm)
    Splitter: TSplitter;
    PanelInfo: TPanel;
    PageControlInfo: TPageControl;
    TabSheetDivision: TTabSheet;
    TabSheetPersonnel: TTabSheet;                              
    TabSheetAccount: TTabSheet;
    PanelTop: TPanel;
    PanelCaption: TPanel;
    LabelCaption: TLabel;
    LabelName: TLabel;
    LabelNote: TLabel;
    DBEditDivisionName: TDBEdit;
    DBMemoDivisionDescription: TDBMemo;
    LabelFName: TLabel;
    Label1: TLabel;
    LabelSName: TLabel;
    LabelDivision: TLabel;
    DBEditPersonnelFName: TDBEdit;
    DBEditPersonnelName: TDBEdit;
    DBEditPersonnelSName: TDBEdit;
    DBEditPersonnelDivision: TDBEdit;
    Label2: TLabel;
    Label4: TLabel;
    DBEditAccountName: TDBEdit;
    DBEditAccountPersonnel: TDBEdit;
  private
  protected
    procedure TreeReadNodeFromDB(Node: PSgtsTreeDBNode); override;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsFunPersonnelManagementIfaceUnionType=(utDivision,utPersonnel,utAccount);

  TSgtsFunPersonnelManagementIface=class(TSgtsDataTreeIface)
  private
    function GetForm: TSgtsFunPersonnelManagementForm;
    function GetNameProc(Def: TSgtsSelectDef): Variant;
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
    procedure DataSetAfterScroll(DataSet: TDataSet); override;
//    function GetAsModal: Boolean; override;
  public
    procedure Init; override;
    procedure UpdateButtons; override;

    property Form: TSgtsFunPersonnelManagementForm read GetForm;
  end;

var
  SgtsFunPersonnelManagementForm: TSgtsFunPersonnelManagementForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsConsts, SgtsRbkObjectEditFm, SgtsDataEditFm, SgtsDataFm;

{$R *.dfm}

{ TSgtsFunPersonnelManagementIface }

procedure TSgtsFunPersonnelManagementIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsFunPersonnelManagementForm;
  InterfaceName:=SInterfacePersonnelManagement;
  with InsertClasses do begin
    Add(TSgtsFunDivisionInsertIface);
    Add(TSgtsFunDivisionInsertChildIface);
    Add(TSgtsFunPersonnelInsertIface);
    Add(TSgtsFunAccountInsertIface);
  end;
  UpdateClass:=TSgtsFunDivisionUpdateIface;
  DeleteClass:=TSgtsFunDivisionDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectPersonnelManagement;
    with SelectDefs do begin
      AddKey('TREE_ID');
      AddCalc('NAME_EX','Наименование','NAME',GetNameProc,ftString,250);
      AddInvisible('DESCRIPTION');
      AddInvisible('TREE_PARENT_ID');
      AddInvisible('UNION_ID');
      AddInvisible('UNION_PARENT_ID');
      AddInvisible('UNION_TYPE');
      AddInvisible('PARENT_NAME');
      AddInvisible('FNAME');
      AddInvisible('SNAME');
      AddInvisible('PASS');
      AddInvisible('DATE_ACCEPT');
      AddInvisible('DATE_SACK');
    end;
    KeyFieldName:='TREE_ID';
    ViewFieldName:='NAME_EX';
    ParentFieldName:='TREE_PARENT_ID';
  end;
end;

function TSgtsFunPersonnelManagementIface.GetNameProc(Def: TSgtsSelectDef): Variant;
var
  Field1,Field2,Field3: TField;
  S1,S2,S3: String;
begin
  Result:=Null;
  if DataSet.Active then begin
    S1:='';
    Field1:=DataSet.FindField('FNAME');
    if Assigned(Field1) then S1:=Field1.AsString;
    S2:='';
    Field2:=DataSet.FindField('NAME');
    if Assigned(Field2) then S2:=Field2.AsString;
    S3:='';
    Field3:=DataSet.FindField('SNAME');
    if Assigned(Field3) then S3:=Field3.AsString;
    Result:=Trim(Format('%s %s %s',[S1,S2,S3]));
  end;
end;

function TSgtsFunPersonnelManagementIface.GetForm: TSgtsFunPersonnelManagementForm;
begin
  Result:=TSgtsFunPersonnelManagementForm(inherited Form);
end;

procedure TSgtsFunPersonnelManagementIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
end;

{function TSgtsFunPersonnelManagementIface.GetAsModal: Boolean;
begin
  Result:=true;
end;}

procedure TSgtsFunPersonnelManagementIface.DataSetAfterScroll(DataSet: TDataSet);
begin
  inherited DataSetAfterScroll(DataSet);
  if DataSet.Active and not DataSet.IsEmpty then begin
    if Assigned(Form) then begin
      with Form do begin
        PageControlInfo.Visible:=true;
        PageControlInfo.ActivePageIndex:=DataSet.FieldByName('UNION_TYPE').AsInteger;
        LabelCaption.Caption:=PageControlInfo.ActivePage.Caption;
      end;
    end;
  end else
    if Assigned(Form) then begin
      Form.PageControlInfo.Visible:=false;
      Form.LabelCaption.Caption:=Form.PanelInfo.Caption;
    end;  
end;

procedure TSgtsFunPersonnelManagementIface.UpdateButtons;
var
  UnionType: TSgtsFunPersonnelManagementIfaceUnionType;
begin
  if DataSet.Active and not DataSet.IsEmpty then begin
    UnionType:=TSgtsFunPersonnelManagementIfaceUnionType(DataSet.FieldByName('UNION_TYPE').AsInteger);
    case UnionType of
      utDivision: begin
        UpdateClass:=TSgtsFunDivisionUpdateIface;
        DeleteClass:=TSgtsFunDivisionDeleteIface;
      end;
      utPersonnel: begin
        UpdateClass:=TSgtsFunPersonnelUpdateIface;
        DeleteClass:=TSgtsFunPersonnelDeleteIface;
      end;
      utAccount: begin
        UpdateClass:=TSgtsFunAccountUpdateIface;
        DeleteClass:=TSgtsFunAccountDeleteIface;
      end;
    end;
  end;
  inherited UpdateButtons;
end;

{ TSgtsFunPersonnelManagementForm }

constructor TSgtsFunPersonnelManagementForm.Create(ACoreIntf: ISgtsCore);
var
  i: Integer;
begin
  inherited Create(ACoreIntf);
  for i:=0 to PageControlInfo.PageCount-1 do begin
    PageControlInfo.Pages[i].TabVisible:=false;
    PageControlInfo.Pages[i].Visible:=true;
  end;
  PageControlInfo.Visible:=false;  
end;

procedure TSgtsFunPersonnelManagementForm.TreeReadNodeFromDB(Node: PSgtsTreeDBNode);
var
  UnionType: TSgtsFunPersonnelManagementIfaceUnionType;
begin
  inherited TreeReadNodeFromDB(Node);
  if Assigned(Node) then begin
    with Iface do begin
      if DataSet.Active and not DataSet.IsEmpty then begin
        UnionType:=TSgtsFunPersonnelManagementIfaceUnionType(DataSet.FieldByName('UNION_TYPE').AsInteger);
        case UnionType of
          utPersonnel: begin
            Node.NormalIndex:=3;
            Node.SelectIndex:=3;
            Node.LastIndex:=3;
            Node.OpenIndex:=3;
          end;
          utAccount: begin
            Node.NormalIndex:=4;
            Node.SelectIndex:=4;
            Node.LastIndex:=4;
            Node.OpenIndex:=4;
          end;
        end;
      end;
    end;
  end;
end;

end.
