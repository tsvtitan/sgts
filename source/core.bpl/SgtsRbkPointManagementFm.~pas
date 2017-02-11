unit SgtsRbkPointManagementFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, StdCtrls, ComCtrls,
  ExtCtrls, ToolWin,
  SgtsFm, SgtsDataTreeFm, SgtsDbTree, SgtsGetRecordsConfig, SgtsCoreIntf;

type
  TSgtsRbkPointManagementIface=class;

  TSgtsRbkPointManagementForm = class(TSgtsDataTreeForm)
  private
    function GetIface: TSgtsRbkPointManagementIface;
    procedure TreeCanSelectNode(Node: PSgtsTreeDBNode; var CanSelectNode: Boolean);
  protected
    procedure TreeReadNodeFromDB(Node: PSgtsTreeDBNode); override;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;

    property Iface: TSgtsRbkPointManagementIface read GetIface;
  end;

  TSgtsRbkPointManagementIfaceUnionType=(utMeasureType,utRoute,utPoint,utConverter);

  TSgtsRbkPointManagementIface=class(TSgtsDataTreeIface)
  private
    FSelectUnionType: Boolean;
    FUnionType: TSgtsRbkPointManagementIfaceUnionType;
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;

    property UnionType: TSgtsRbkPointManagementIfaceUnionType read FUnionType;
    property SelectUnionType: Boolean read FSelectUnionType;
  public
    procedure Init; override;
    function CanShow: Boolean; override;
    function CanSelect: Boolean; override;
    function SelectByUnionType(Fields: String; Values: Variant; var Data: String;
                               UnionType: TSgtsRbkPointManagementIfaceUnionType;
                               FilterGroups: TSgtsGetRecordsConfigFilterGroups=nil;
                               MultiSelect: Boolean=false): Boolean;
  end;

var
  SgtsRbkPointManagementForm: TSgtsRbkPointManagementForm;

implementation

uses VirtualTrees,
     SgtsConsts, SgtsProviderConsts, SgtsDataFm, SgtsDataIfaceIntf;

{$R *.dfm}

{ TSgtsRbkPointManagementIface }

procedure TSgtsRbkPointManagementIface.Init; 
begin
  inherited Init;
  FormClass:=TSgtsRbkPointManagementForm;
//  InterfaceName:=SInterfaceRbkPointManagement;
  with DataSet do begin
    ProviderName:=SProviderSelectPointManagement;
    with SelectDefs do begin
      AddKey('TREE_ID');
      Add('NAME','Наименование',150);
      AddInvisible('DESCRIPTION');
      AddInvisible('TREE_PARENT_ID');
      AddInvisible('UNION_ID');
      AddInvisible('UNION_PARENT_ID');
      AddInvisible('UNION_TYPE');
      AddInvisible('PARENT_NAME');
      AddInvisible('PRIORITY');
    end;
    KeyFieldName:='TREE_ID';
    ViewFieldName:='NAME';
    ParentFieldName:='TREE_PARENT_ID';
  end;
end;

procedure TSgtsRbkPointManagementIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with Form.Tree do begin
      if Mode=imMultiSelect then
        TreeOptions.SelectionOptions:=TreeOptions.SelectionOptions+[toLevelSelectConstraint,toSiblingSelectConstraint]
      else
        TreeOptions.SelectionOptions:=TreeOptions.SelectionOptions-[toLevelSelectConstraint,toSiblingSelectConstraint];
    end;
  end;
end;

function TSgtsRbkPointManagementIface.CanShow: Boolean;
begin
  Result:=Assigned(CoreIntf);
end;

function TSgtsRbkPointManagementIface.CanSelect: Boolean;
var
  UnionType: TSgtsRbkPointManagementIfaceUnionType; 
begin
  Result:=inherited CanSelect;
  if FSelectUnionType then begin
    if DataSet.Active then begin
      UnionType:=TSgtsRbkPointManagementIfaceUnionType(DataSet.FieldByName('UNION_TYPE').AsInteger);
      Result:=UnionType=FUnionType;
    end;  
  end;
end;

function TSgtsRbkPointManagementIface.SelectByUnionType(Fields: String; Values: Variant; var Data: String;
                                                        UnionType: TSgtsRbkPointManagementIfaceUnionType;
                                                        FilterGroups: TSgtsGetRecordsConfigFilterGroups=nil;
                                                        MultiSelect: Boolean=false): Boolean;
begin
  FSelectUnionType:=true;
  FUnionType:=UnionType;
  Result:=SelectVisible(Fields,Values,Data,FilterGroups,MultiSelect);
end;

{ TSgtsRbkPointManagementForm }

constructor TSgtsRbkPointManagementForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  Tree.OnCanSelectNode:=TreeCanSelectNode;
end;

function TSgtsRbkPointManagementForm.GetIface: TSgtsRbkPointManagementIface;
begin
  Result:=TSgtsRbkPointManagementIface(inherited Iface);
end;

procedure TSgtsRbkPointManagementForm.TreeCanSelectNode(Node: PSgtsTreeDBNode; var CanSelectNode: Boolean);
begin
  if Iface.SelectUnionType then
    if Assigned(Node) then begin
      CanSelectNode:=(TSgtsRbkPointManagementIfaceUnionType(Node.Data)=Iface.UnionType) or (Tree.SelectedCount=0);
    end else
      CanSelectNode:=false;
end;

procedure TSgtsRbkPointManagementForm.TreeReadNodeFromDB(Node: PSgtsTreeDBNode);
var
  AUnionType: TSgtsRbkPointManagementIfaceUnionType;
begin
  inherited TreeReadNodeFromDB(Node);
  if Assigned(Node) then begin
    with Iface do begin
      if DataSet.Active and not DataSet.IsEmpty then begin
        AUnionType:=TSgtsRbkPointManagementIfaceUnionType(DataSet.FieldByName('UNION_TYPE').AsInteger);
        Node.Data:=Pointer(AUnionType);
        case AUnionType of
          utMeasureType: begin
            Node.NormalIndex:=0;
            Node.SelectIndex:=0;
            Node.LastIndex:=0;
            Node.OpenIndex:=0;
          end;
          utRoute: begin
            Node.NormalIndex:=1;
            Node.SelectIndex:=1;
            Node.LastIndex:=1;
            Node.OpenIndex:=1;
          end;
          utPoint: begin
            Node.NormalIndex:=2;
            Node.SelectIndex:=2;
            Node.LastIndex:=2;
            Node.OpenIndex:=2;
          end;
          utConverter: begin
            Node.NormalIndex:=3;
            Node.SelectIndex:=3;
            Node.LastIndex:=3;
            Node.OpenIndex:=3;
          end;
        end;
      end;
    end;
  end;
end;


end.
