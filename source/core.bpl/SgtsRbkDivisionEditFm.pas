unit SgtsRbkDivisionEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls, DB,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsExecuteDefs, SgtsControls, SgtsCoreIntf;

type
  TSgtsRbkDivisionEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    MemoNote: TMemo;
    LabelNote: TLabel;
    LabelParent: TLabel;
    EditParent: TEdit;
    ButtonParent: TButton;
    LabelPriority: TLabel;
    EditPriority: TEdit;
    procedure ButtonParentClick(Sender: TObject);
    procedure EditParentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkDivisionInsertIface=class(TSgtsDataInsertIface)
  private
    FIdDef: TSgtsExecuteDefKey;
    FParentIdDef: TSgtsExecuteDefEditLink;
    FNameDef: TSgtsExecuteDefEdit;
    FPriorityDef: TSgtsExecuteDefEditInteger;
  protected
    function GetPriority: Variant; virtual;

    property IdDef: TSgtsExecuteDefKey read FIdDef;
    property ParentIdDef: TSgtsExecuteDefEditLink read FParentIdDef;
    property NameDef: TSgtsExecuteDefEdit read FNameDef;
    property PriorityDef: TSgtsExecuteDefEditInteger read FPriorityDef;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsRbkDivisionInsertChildIface=class(TSgtsRbkDivisionInsertIface)
  protected
  public
    procedure Init; override;
    procedure SetDefValues; override;
    function CanShow: Boolean; override;
  end;

  TSgtsRbkDivisionUpdateIface=class(TSgtsDataUpdateIface)
  private
    FIdDef: TSgtsExecuteDefKeyLink;
    FParentIdDef: TSgtsExecuteDefEditLink;
    FNameDef: TSgtsExecuteDefEdit;
    FPriorityDef: TSgtsExecuteDefEditInteger;
    procedure ParentIdCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
  protected
    function GetPriority: Variant; virtual;
    
    property IdDef: TSgtsExecuteDefKeyLink read FIdDef;
    property ParentIdDef: TSgtsExecuteDefEditLink read FParentIdDef;
    property NameDef: TSgtsExecuteDefEdit read FNameDef;
    property PriorityDef: TSgtsExecuteDefEditInteger read FPriorityDef;
  public
    procedure Init; override;
  end;

  TSgtsRbkDivisionDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkDivisionEditForm: TSgtsRbkDivisionEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts, SgtsGetRecordsConfig,
     SgtsDatabaseCDS, SgtsDialogs, SgtsRbkDivisionsFm, SgtsCDS, SgtsUtils,
     SgtsDataIfaceIntf;

{$R *.dfm}

function InternalGetPriority(IfaceIntf: ISgtsDataIface; ParentIdDef: TSgtsExecuteDefEditLink): Variant;
var
  DS: TSgtsCDS;
  ParentId: Variant;
begin
  Result:=1;
  with IfaceIntf do begin
    if DataSet.Active and not DataSet.IsEmpty then begin
      ParentId:=ParentIdDef.Value;
      DS:=TSgtsCDS.Create(nil);
      try
        DS.Data:=DataSet.Data;
        DS.AddIndexDef('PRIORITY',tsAsc);
        DS.Filter:=Format('PARENT_ID=%s',[iff(VarIsNull(ParentId),'NULL',VarToStr(ParentId))]);
        DS.Filtered:=true;
        DS.SetIndexBySort('PRIORITY',tsAsc);
        DS.Last;
        Result:=DS.FieldByName('PRIORITY').AsInteger+1;
      finally
        DS.Free;
      end;
    end;
  end;
end;

{ TSgtsRbkDivisionInsertIface }

procedure TSgtsRbkDivisionInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkDivisionEditForm;
  InterfaceName:=SInterfaceDivisionInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertDivision;
    with ExecuteDefs do begin
      FIdDef:=AddKey('DIVISION_ID');
      FParentIdDef:=AddEditLink('PARENT_ID','EditParent','LabelParent','ButtonParent',
                                TSgtsRbkDivisionsIface,'PARENT_NAME','NAME','DIVISION_ID',false);
      FNameDef:=AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
      FPriorityDef:=AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

procedure TSgtsRbkDivisionInsertIface.SetDefValues;
var
  Field: TField;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    Field:=IfaceIntf.DataSet.FindField(FParentIdDef.FieldName);
    if Assigned(Field) then begin
      FParentIdDef.DefaultValue:=Field.Value;
      FParentIdDef.SetDefault;
    end;
    Field:=IfaceIntf.DataSet.FindField(FParentIdDef.Link.FieldName);
    if Assigned(Field) then begin
      FParentIdDef.Link.DefaultValue:=Field.Value;
      FParentIdDef.Link.SetDefault;
    end;
    FPriorityDef.DefaultValue:=GetPriority;
    FPriorityDef.SetDefault;
  end;
end;

function TSgtsRbkDivisionInsertIface.GetPriority: Variant;
begin
  Result:=InternalGetPriority(IfaceIntf,FParentIdDef);
end;

{ TSgtsRbkDivisionInsertChildIface }

procedure TSgtsRbkDivisionInsertChildIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceDivisionInsertChild;
end;

function TSgtsRbkDivisionInsertChildIface.CanShow: Boolean;
begin
  Result:=inherited CanShow and
          Assigned(IfaceIntf) and
          not IfaceIntf.DataSet.IsEmpty;
end;

procedure TSgtsRbkDivisionInsertChildIface.SetDefValues;
var
  Field: TField;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    Field:=IfaceIntf.DataSet.FindField(FIdDef.FieldName);
    if Assigned(Field) then begin
      FParentIdDef.DefaultValue:=Field.Value;
      FParentIdDef.SetDefault;
    end;
    Field:=IfaceIntf.DataSet.FindField(FNameDef.FieldName);
    if Assigned(Field) then begin
      FParentIdDef.Link.DefaultValue:=Field.Value;
      FParentIdDef.Link.SetDefault;
    end;
    FPriorityDef.DefaultValue:=GetPriority;
    FPriorityDef.SetDefault;
  end;
end;

{ TSgtsRbkDivisionUpdateIface }

procedure TSgtsRbkDivisionUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkDivisionEditForm;
  InterfaceName:=SInterfaceDivisionUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateDivision;
    with ExecuteDefs do begin
      FIdDef:=AddKeyLink('DIVISION_ID');
      FParentIdDef:=AddEditLink('PARENT_ID','EditParent','LabelParent','ButtonParent',
                                TSgtsRbkDivisionsIface,'PARENT_NAME','NAME','DIVISION_ID',false);
      FParentIdDef.OnCheckValue:=ParentIdCheckValue;
      FNameDef:=AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
      FPriorityDef:=AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

procedure TSgtsRbkDivisionUpdateIface.ParentIdCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
var
  DS: TSgtsDatabaseCDS;
  OldCursor: TCursor;
begin
  OldCursor:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  DS:=TSgtsDatabaseCDS.Create(CoreIntf);
  try
    DS.ProviderName:=SProviderAuditDivisionParentId;
    with DS.ExecuteDefs do begin
      AddInvisible('DIVISION_ID').Value:=FIdDef.Value;
      AddInvisible('PARENT_ID').Value:=NewValue;
    end;
    try
      DS.Execute;
    except
      On E: Exception do begin
        CanSet:=false;
        ShowError(E.Message);
      end;
    end;
  finally
    DS.Free;
    Screen.Cursor:=OldCursor;
  end;
end;

function TSgtsRbkDivisionUpdateIface.GetPriority: Variant;
begin
  Result:=InternalGetPriority(IfaceIntf,FParentIdDef);
end;

{ TSgtsRbkDivisionDeleteIface }

procedure TSgtsRbkDivisionDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceDivisionDelete;
  DeleteQuestion:='Удалить отдел %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteDivision;
    with ExecuteDefs do begin
      AddKeyLink('DIVISION_ID');
      AddInvisible('NAME');
    end;
  end;
end;

{ TSgtsRbkDivisionEditForm }

constructor TSgtsRbkDivisionEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;

procedure TSgtsRbkDivisionEditForm.ButtonParentClick(Sender: TObject);
begin
  if Iface is TSgtsRbkDivisionInsertIface then begin
    with TSgtsRbkDivisionInsertIface(Iface) do begin
      PriorityDef.DefaultValue:=GetPriority;
      PriorityDef.SetDefault;
    end;
  end;
  if Iface is TSgtsRbkDivisionUpdateIface then begin
    with TSgtsRbkDivisionUpdateIface(Iface) do begin
      PriorityDef.DefaultValue:=GetPriority;
      PriorityDef.SetDefault;
    end;
  end;
end;

procedure TSgtsRbkDivisionEditForm.EditParentKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ((Key=VK_DELETE) or (Key=VK_BACK)) then begin
    if Iface is TSgtsRbkDivisionInsertIface then begin
      with TSgtsRbkDivisionInsertIface(Iface) do begin
        PriorityDef.DefaultValue:=GetPriority;
        PriorityDef.SetDefault;
      end;
    end;
    if Iface is TSgtsRbkDivisionUpdateIface then begin
      with TSgtsRbkDivisionUpdateIface(Iface) do begin
        PriorityDef.DefaultValue:=GetPriority;
        PriorityDef.SetDefault;
      end;
    end;
  end;
end;

end.
