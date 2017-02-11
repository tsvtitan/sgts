unit SgtsRbkAccountEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls, CheckLst,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsCoreIntf, SgtsExecuteDefs;

type
  TSgtsRoleInfo=class(TObject)
  private
    FRoleId: Variant;
  public
    property RoleId: Variant read FRoleId write FRoleId;
  end;

  TSgtsRbkAccountEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    LabelPass: TLabel;
    EditPass: TEdit;
    LabelPersonnel: TLabel;
    EditPersonnel: TEdit;
    ButtonPersonnel: TButton;
    GroupBoxRoles: TGroupBox;
    PanelRoles: TPanel;
    CheckListBoxRoles: TCheckListBox;
    ButtonAdjustment: TButton;
    procedure CheckListBoxRolesClick(Sender: TObject);
    procedure ToolButtonDefaultClick(Sender: TObject);
    procedure ButtonAdjustmentClick(Sender: TObject);
  private
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;

  end;

  TSgtsRbkAccountInsertIface=class(TSgtsDataInsertIface)
  private
    FKey: TSgtsExecuteDefKey;
    FAdjustmentDef: TSgtsExecuteDefInvisible;
  public
    procedure Init; override;
    procedure SetDefValues; override;
    procedure Insert; override;

    property AdjustmentDef: TSgtsExecuteDefInvisible read FAdjustmentDef;
  end;

  TSgtsRbkAccountUpdateIface=class(TSgtsDataUpdateIface)
  private
    FKeyLink: TSgtsExecuteDefKeyLink;
    FAdjustmentDef: TSgtsExecuteDefInvisible;
  public
    procedure Init; override;
    procedure SetDefValues; override;
    procedure Update; override;

    property AdjustmentDef: TSgtsExecuteDefInvisible read FAdjustmentDef;
  end;

  TSgtsRbkAccountDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkAccountEditForm: TSgtsRbkAccountEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs,
     SgtsRbkPersonnelsFm, SgtsGetRecordsConfig, SgtsFieldEditFm, SgtsFieldEditFmIntf,
  SgtsCoreObj;

{$R *.dfm}

procedure ClearRoles(CheckListBox: TCheckListBox);
var
  i: Integer;
  Obj: TSgtsRoleInfo;
begin
  for i:=0 to CheckListBox.Items.Count-1 do begin
    Obj:=TSgtsRoleInfo(CheckListBox.Items.Objects[i]);
    Obj.Free;
  end;
  CheckListBox.Clear;
end;

procedure FillRoles(CoreIntf: ISgtsCore; CheckListBox: TCheckListBox);
var
  DS: TSgtsDatabaseCDS;
  Obj: TSgtsRoleInfo;
begin
  DS:=TSgtsDatabaseCDS.Create(CoreIntf);
  CheckListBox.Items.BeginUpdate;
  try
    ClearRoles(CheckListBox);
    DS.ProviderName:=SProviderSelectRoles;
    DS.SelectDefs.AddInvisible('ACCOUNT_ID');
    DS.SelectDefs.AddInvisible('NAME');
    DS.Open;
    if DS.Active then begin
      DS.First;
      while not DS.Eof do begin
        Obj:=TSgtsRoleInfo.Create;
        Obj.RoleId:=DS.FieldByName('ACCOUNT_ID').Value;
        CheckListBox.Items.AddObject(DS.FieldByName('NAME').AsString,Obj);
        DS.Next;
      end;
    end;
  finally
    CheckListBox.Items.EndUpdate;
    DS.Free;
  end;
end;

procedure CheckedRoles(CoreIntf: ISgtsCore; CheckListBox: TCheckListBox; AccountId: Variant);
var
  DS: TSgtsDatabaseCDS;
  Obj: TSgtsRoleInfo;
  i: Integer;
  FilterGroup: TSgtsGetRecordsConfigFilterGroup;
begin
  DS:=TSgtsDatabaseCDS.Create(CoreIntf);
  CheckListBox.Items.BeginUpdate;
  try
    DS.ProviderName:=SProviderSelectAccountsRoles;
    DS.SelectDefs.AddInvisible('ROLE_ID');
    FilterGroup:=DS.FilterGroups.Add;
    FilterGroup.Filters.Add('ACCOUNT_ID',fcEqual,AccountId);
    DS.Open;
    if DS.Active then begin
      DS.First;
      while not DS.Eof do begin
        for i:=0 to CheckListBox.Items.Count-1 do begin
          Obj:=TSgtsRoleInfo(CheckListBox.Items.Objects[i]);
          if Obj.RoleId=DS.FieldByName('ROLE_ID').Value then begin
            CheckListBox.Checked[i]:=true;
            break;
          end;
        end;
        DS.Next;
      end;
    end;
  finally
    CheckListBox.Items.EndUpdate;
    DS.Free;
  end;
end;

procedure InsertRoles(CoreIntf: ISgtsCore; CheckListBox: TCheckListBox; AccountId: Variant);
var
  DS: TSgtsDatabaseCDS;
  Obj: TSgtsRoleInfo;
  i: Integer;
begin
  for i:=0 to CheckListBox.Items.Count-1 do begin
    if CheckListBox.Checked[i] then begin
      Obj:=TSgtsRoleInfo(CheckListBox.Items.Objects[i]);
      DS:=TSgtsDatabaseCDS.Create(CoreIntf);
      try
        DS.ProviderName:=SProviderInsertAccountRole;
        DS.ExecuteDefs.AddKeyLink('ACCOUNT_ID').Value:=AccountId;
        DS.ExecuteDefs.AddKeyLink('ROLE_ID').Value:=Obj.RoleId;
        DS.Execute;
      finally
        DS.Free;
      end;
    end;
  end;
end;

procedure DeleteRoles(CoreIntf: ISgtsCore; AccountId: Variant);
var
  DS: TSgtsDatabaseCDS;
begin
  DS:=TSgtsDatabaseCDS.Create(CoreIntf);
  try
    DS.ProviderName:=SProviderClearAccountRole;
    DS.ExecuteDefs.AddKeyLink('ACCOUNT_ID').Value:=AccountId;
    DS.Execute;
  finally
    DS.Free;
  end;
end;

{ TSgtsRbkAccountInsertIface }

procedure TSgtsRbkAccountInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkAccountEditForm;
  InterfaceName:=SInterfaceAccountInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertAccount;
    with ExecuteDefs do begin
      FKey:=AddKey('ACCOUNT_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddEdit('PASS','EditPass','LabelPass',false);
      AddEditLink('PERSONNEL_ID','EditPersonnel','LabelPersonnel','ButtonPersonnel',
                  TSgtsRbkPersonnelsIface,'PERSONNEL_NAME','','',true);
      with AddInvisible('IS_ROLE') do Value:=0;
      FAdjustmentDef:=AddInvisible('ADJUSTMENT');
    end;
  end;
end;

procedure TSgtsRbkAccountInsertIface.SetDefValues;
begin
  inherited SetDefValues;
  if Assigned(Form) then begin
    with TSgtsRbkAccountEditForm(Form) do begin
      FillRoles(CoreIntf,CheckListBoxRoles);
    end;
  end;
end;

procedure TSgtsRbkAccountInsertIface.Insert;
begin
  inherited Insert;
  if Assigned(Form) then begin
    with TSgtsRbkAccountEditForm(Form) do begin
      InsertRoles(CoreIntf,CheckListBoxRoles,FKey.Value);
    end;
  end;
end;

{ TSgtsRbkAccountUpdateIface }

procedure TSgtsRbkAccountUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkAccountEditForm;
  InterfaceName:=SInterfaceAccountUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateAccount;
    with ExecuteDefs do begin
      FKeyLink:=AddKeyLink('ACCOUNT_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddEdit('PASS','EditPass','LabelPass',false);
      AddEditLink('PERSONNEL_ID','EditPersonnel','LabelPersonnel','ButtonPersonnel',
                  TSgtsRbkPersonnelsIface,'PERSONNEL_NAME','','',true);
      with AddInvisible('IS_ROLE') do Value:=0;
      FAdjustmentDef:=AddInvisible('ADJUSTMENT');
    end;
  end;
end;

procedure TSgtsRbkAccountUpdateIface.SetDefValues;
var
  Stream: TMemoryStream;
begin
  inherited SetDefValues;
  if Assigned(Database) then begin
    if FKeyLink.Value=Database.AccountId then begin
      Stream:=TMemoryStream.Create;
      try
        CoreIntf.DatabaseConfig.SaveToStream(Stream);
        Stream.Position:=0;
        FAdjustmentDef.LoadValueFromStream(Stream);
        FAdjustmentDef.DefaultValue:=FAdjustmentDef.Value;
      finally
        Stream.Free;
      end;
    end;
  end;
  if Assigned(Form) then begin
    with TSgtsRbkAccountEditForm(Form) do begin
      FillRoles(CoreIntf,CheckListBoxRoles);
      CheckedRoles(CoreIntf,CheckListBoxRoles,FKeyLink.Value);
    end;
  end;
end;

procedure TSgtsRbkAccountUpdateIface.Update;
var
  Stream: TMemoryStream;
begin
  inherited Update;
  if Assigned(Database) then begin
    if FKeyLink.Value=Database.AccountId then begin
      Stream:=TMemoryStream.Create;
      try
        FAdjustmentDef.SaveValueToStream(Stream);
        Stream.Position:=0;
        CoreIntf.DatabaseConfig.LoadFromStream(Stream);
        CoreIntf.ReadParams;
        CoreIntf.DatabaseConfig.SaveToDatabase;
      finally
        Stream.Free;
      end;
    end;
  end;  
  if Assigned(Form) then begin
    with TSgtsRbkAccountEditForm(Form) do begin
      DeleteRoles(CoreIntf,FKeyLink.Value);
      InsertRoles(CoreIntf,CheckListBoxRoles,FKeyLink.Value);
    end;
  end;
end;

{ TSgtsRbkAccountDeleteIface }

procedure TSgtsRbkAccountDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceAccountDelete;
  DeleteQuestion:='Удалить учетную запись %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteAccount;
    with ExecuteDefs do begin
      AddKeyLink('ACCOUNT_ID');
      AddInvisible('NAME');
    end;
  end;
end;

{ TSgtsRbkInsertAccountForm }

constructor TSgtsRbkAccountEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;

destructor TSgtsRbkAccountEditForm.Destroy;
begin
  ClearRoles(CheckListBoxRoles);
  inherited Destroy;
end;

procedure TSgtsRbkAccountEditForm.CheckListBoxRolesClick(Sender: TObject);
begin
  ChangeFlag:=true;
  Iface.SetChanges;
end;

procedure TSgtsRbkAccountEditForm.ToolButtonDefaultClick(Sender: TObject);
begin
  ChangeFlag:=false;
  inherited;
  Iface.SetDefValues;
  Iface.SetChanges;
end;

procedure TSgtsRbkAccountEditForm.ButtonAdjustmentClick(Sender: TObject);
var
  OldCursor: TCursor;
  AdjustmentDef: TSgtsExecuteDefInvisible;
  AIface: TSgtsFieldEditIface;
  Value: Variant;
begin
  AdjustmentDef:=nil;
  if Iface is TSgtsRbkAccountInsertIface then
    AdjustmentDef:=TSgtsRbkAccountInsertIface(Iface).AdjustmentDef;
  if Iface is TSgtsRbkAccountUpdateIface then
    AdjustmentDef:=TSgtsRbkAccountUpdateIface(Iface).AdjustmentDef;

  if Assigned(AdjustmentDef) then begin
    OldCursor:=Screen.Cursor;
    Screen.Cursor:=crHourGlass;
    try
      AIface:=TSgtsFieldEditIface.Create(CoreIntf);
      try
        AIface.Init;
        AIface.Caption:=ButtonAdjustment.Caption;
        if AIface.Show(AdjustmentDef.Value,Value,etDefault) then begin
          AdjustmentDef.Value:=Value;
          AdjustmentDef.Change(ButtonAdjustment);
        end;
        AIface.Done;
      finally
        AIface.Free;
      end;
    finally
      Screen.Cursor:=OldCursor;
    end;
  end;
end;

end.
