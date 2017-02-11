unit SgtsDbTree;

interface

uses Classes, DB, VirtualDbTree, VirtualTrees,
     SgtsSelectDefs;

type
  TSgtsTreeDBNode=packed record
    Text: WideString;
    NormalIndex: Integer;
    SelectIndex: Integer;
    LastIndex: Integer;
    OpenIndex: Integer;
    Node: PVirtualNode;
    Data: Pointer;
    Value: Variant;
  end;
  PSgtsTreeDBNode=^TSgtsTreeDBNode;

  TSgtsDbTreeReadNodeFromDBEvent=procedure(Node: PSgtsTreeDBNode) of object;
  TSgtsDbTreeCanSelectEvent=procedure(Node: PSgtsTreeDBNode; var CanSelectNode: Boolean) of object;
  TSgtsDbTreeCanWriteToDataSetEvent=function(Node: PSgtsTreeDBNode): Boolean of object;
  TSgtsDbTreeGetAttachModeEvent=function(Node: PSgtsTreeDBNode): TVTNodeAttachMode of object;
  TSgtsDbTreeWritingDataSetEvent=procedure(Node: PSgtsTreeDBNode; var Allow: Boolean) of object;

  TSgtsDbTree=class(TBaseVirtualDBTree)
  private
    FOnReadNodeFromDB: TSgtsDbTreeReadNodeFromDBEvent;
    FOnCanSelectNode: TSgtsDbTreeCanSelectEvent;
    FOnCanWriteToDataSet: TSgtsDbTreeCanWriteToDataSetEvent;
    FOnGetAttachMode: TSgtsDbTreeGetAttachModeEvent;
    FOnWritingDataSet: TSgtsDbTreeWritingDataSetEvent;
    function GetTreeOptions: TVirtualTreeOptions;
    Function GetNodeText(Node: PVirtualNode): WideString;
    Procedure SetNodeText(Node: PVirtualNode; Const Value: WideString);
  protected
    procedure DataLinkChanged; override;
    function CanSelect(Node: PVirtualNode): Boolean; override;
    procedure DoReadNodeFromDB(Node: PVirtualNode); override;
    Function DoCompare(Node1, Node2: PVirtualNode; Column: Integer): Integer; Override;
    Procedure DoGetText(Node: PVirtualNode; Column: Integer; TextType: TVSTTextType; Var Text: WideString); Override;
    Procedure DoNewText(Node: PVirtualNode; Column: Integer; Text: WideString); Override;
    Procedure DoNodeDataChanged(Node: PVirtualNode; Field: TField; Var UpdateNode: Boolean); Override;
    procedure DoGetImageIndex(Node: PVirtualNode; Kind: TVTImageKind; Column: Integer;
                              var Ghosted: Boolean; var Index: Integer); override;
    function DoFocusChanging(OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: Integer): Boolean; override;
    function CanWriteToDataSet(Node: PVirtualNode; Column: Integer; ChangeMode: TDBVTChangeMode): Boolean; override;
    function GetAttachMode(Node: PVirtualNode): TVTNodeAttachMode; override;
    procedure DoWritingDataSet(Node: PVirtualNode; Column: Integer; ChangeMode: TDBVTChangeMode; Var Allow: Boolean); override;
  public
    constructor Create(Owner: TComponent); override;

    Property NodeText[Node: PVirtualNode]: WideString Read GetNodeText Write SetNodeText;
    property OnReadNodeFromDB: TSgtsDbTreeReadNodeFromDBEvent read FOnReadNodeFromDB write FOnReadNodeFromDB;
    property OnCanSelectNode: TSgtsDbTreeCanSelectEvent read FOnCanSelectNode write FOnCanSelectNode;
    property OnCanWriteToDataSet: TSgtsDbTreeCanWriteToDataSetEvent read FOnCanWriteToDataSet write FOnCanWriteToDataSet;
    property OnGetAttachMode: TSgtsDbTreeGetAttachModeEvent read FOnGetAttachMode write FOnGetAttachMode;
    property OnWritingDataSet: TSgtsDbTreeWritingDataSetEvent read FOnWritingDataSet write FOnWritingDataSet;
  published
    property TreeOptions: TVirtualTreeOptions read GetTreeOptions;
  end;

procedure CreateTreeColumnsBySelectDefs(Tree: TSgtsDbTree; SelectDefs: TSgtsSelectDefs);

implementation

uses Graphics;

type
  TSgtsTreeColumn=class(TVirtualTreeColumn)
  private
    FDef: TSgtsSelectDef;
  public
    property Def: TSgtsSelectDef read FDef write FDef;
  end;  
  
procedure CreateTreeColumnsBySelectDefs(Tree: TSgtsDbTree; SelectDefs: TSgtsSelectDefs);
var
  i: Integer;
  Column: TSgtsTreeColumn;
  ADef: TSgtsSelectDef;
begin
  Tree.Header.Columns.Clear;
  with SelectDefs do
    for i:=0 to Count-1 do begin
      ADef:=Items[i];
      if ADef.Visible then begin
        Column:=TSgtsTreeColumn.Create(Tree.Header.Columns);
        with Column do begin
          Def:=ADef;
          Text:=ADef.Caption;
{          FieldName:=ADef.Name;
          case ADef.FieldKind of
            fkCalculated: FieldName:=ADef.Name;
          end;}
          case ADef.Alignment of
            daLeft: Alignment:=taLeftJustify;
            daRight: Alignment:=taRightJustify;
            daCenter: Alignment:=taCenter;
          end;
          if ADef.Width>0 then
            Width:=ADef.Width
          else
            if ADef.Width=0 then begin
              Width:=50;
              ADef.Width:=50;
            end;  
        end;
      end;
    end;
end;

{ TSgtsDbTree }


Constructor TSgtsDbTree.Create(Owner: TComponent);
Begin
  Inherited Create(Owner);
  DBNodeDataSize := sizeof(TSgtsTreeDBNode);
End;

function TSgtsDbTree.GetTreeOptions: TVirtualTreeOptions;
begin
  Result:=TVirtualTreeOptions(inherited TreeOptions);
end;

procedure TSgtsDbTree.DataLinkChanged;
begin
  inherited DataLinkChanged;
end;

procedure TSgtsDbTree.DoReadNodeFromDB(Node: PVirtualNode);
var
  Data: PSgtsTreeDBNode;
begin
  NodeText[Node] := ViewField.AsString;
  Data:=GetDBNodeData(Node);
  if Assigned(Data) then
    Data.Node:=Node;
  if Assigned(FOnReadNodeFromDB) then
    FOnReadNodeFromDB(Data);
end;

Procedure TSgtsDbTree.SetNodeText(Node: PVirtualNode; Const Value: WideString);
Begin
  If Assigned(Node) Then PSgtsTreeDBNode(GetDBNodeData(Node)).Text := Value;
End;

Function TSgtsDbTree.GetNodeText(Node: PVirtualNode): WideString;
Begin
  If Assigned(Node) Then Result := PSgtsTreeDBNode(GetDBNodeData(Node)).Text;
End;

Procedure TSgtsDbTree.DoNodeDataChanged(Node: PVirtualNode; Field: TField; Var UpdateNode: Boolean);
Begin
  If Field = ViewField Then Begin
    NodeText[Node] := Field.AsString;
    UpdateNode := True;
  End;
End;

Procedure TSgtsDbTree.DoGetText(Node: PVirtualNode; Column: Integer; TextType: TVSTTextType; Var Text: WideString);
Begin
  If Assigned(Node) And (Node <> RootNode) Then Begin
    If (Column = Header.MainColumn) And (TextType = ttNormal) Then Text := NodeText[Node]
    Else Inherited;
  End;
End;

Procedure TSgtsDbTree.DoNewText(Node: PVirtualNode; Column: Integer; Text: WideString);
Begin
  If Column = Header.MainColumn Then ViewField.AsString := Text;
End;

Function TSgtsDbTree.DoCompare(Node1, Node2: PVirtualNode; Column: Integer): Integer;
Begin
  If Column = Header.MainColumn Then If NodeText[Node1] > NodeText[Node2] Then Result := 1
    Else Result := -1
  Else Result := 0;
End;

procedure TSgtsDbTree.DoGetImageIndex(Node: PVirtualNode; Kind: TVTImageKind; Column: Integer;
                                      var Ghosted: Boolean; var Index: Integer); 
var
  NodeDB: PSgtsTreeDBNode;
begin
  NodeDB:=GetDBNodeData(Node);
  if Assigned(NodeDB) then begin
    case Kind of
      ikNormal,ikSelected: begin
         if Node.ChildCount=0 then begin
           Index:=NodeDB.LastIndex;
         end else begin
           if vsExpanded in Node.States then
             Index:=NodeDB.OpenIndex
           else
             Index:=NodeDB.NormalIndex;
         end;
      end;
    end;
  end;
end;

function TSgtsDbTree.DoFocusChanging(OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: Integer): Boolean;
begin
  Result:=inherited DoFocusChanging(OldNode,NewNode,OldColumn,NewColumn);
end;

function TSgtsDbTree.CanSelect(Node: PVirtualNode): Boolean; 
var
  NodeDB: PSgtsTreeDBNode;
begin
  Result:=inherited CanSelect(Node);
  NodeDB:=GetDBNodeData(Node);
  if Assigned(FOnCanSelectNode) then
    FOnCanSelectNode(NodeDB,Result);
end;

function TSgtsDbTree.CanWriteToDataSet(Node: PVirtualNode; Column: Integer; ChangeMode: TDBVTChangeMode): Boolean;
var
  NodeDB: PSgtsTreeDBNode;
begin
  Result:=inherited CanWriteToDataSet(Node,Column,ChangeMode);
  NodeDB:=GetDBNodeData(Node);
  if Assigned(FOnCanWriteToDataSet) then
    Result:=FOnCanWriteToDataSet(NodeDB);
end;

function TSgtsDbTree.GetAttachMode(Node: PVirtualNode): TVTNodeAttachMode;
var
  NodeDB: PSgtsTreeDBNode;
begin
  Result:=inherited GetAttachMode(Node);
  NodeDB:=GetDBNodeData(Node);
  if Assigned(FOnGetAttachMode) then
    Result:=FOnGetAttachMode(NodeDB);
end;

procedure TSgtsDbTree.DoWritingDataSet(Node: PVirtualNode; Column: Integer; ChangeMode: TDBVTChangeMode; var Allow: Boolean);
var
  NodeDB: PSgtsTreeDBNode;
begin
  inherited DoWritingDataSet(Node,Column,ChangeMode,Allow);
  NodeDB:=GetDBNodeData(Node);
  if Assigned(FOnWritingDataSet) then
    FOnWritingDataSet(NodeDB,Allow);
end;

end.
