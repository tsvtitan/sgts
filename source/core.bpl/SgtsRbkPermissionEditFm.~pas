unit SgtsRbkPermissionEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls,
  SgtsCoreIntf;

type
  TSgtsRbkPermissionEditForm = class(TSgtsDataEditForm)
    LabelInterface: TLabel;
    LabelAccount: TLabel;
    EditAccount: TEdit;
    ButtonAccount: TButton;
    ComboBoxInterface: TComboBox;
    LabelPermission: TLabel;
    ComboBoxPermission: TComboBox;
    LabelValue: TLabel;
    ComboBoxValue: TComboBox;
    procedure ComboBoxInterfaceChange(Sender: TObject);
    procedure ComboBoxPermissionChange(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkPermissionInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
    procedure Insert; override;
  end;

  TSgtsRbkPermissionUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
    procedure Update; override;
  end;

  TSgtsRbkPermissionDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
    procedure Delete; override;
  end;
  
var
  SgtsRbkPermissionEditForm: TSgtsRbkPermissionEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkRolesAndAccountsFm, SgtsCoreObj, ComObj;

{$R *.dfm}

{ TSgtsRbkPermissionInsertIface }

procedure TSgtsRbkPermissionInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPermissionEditForm;
  InterfaceName:=SInterfacePermissionInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertPermission;
    with ExecuteDefs do begin
      AddKey('PERMISSION_ID');
      AddEditLink('ACCOUNT_ID','EditAccount','LabelAccount','ButtonAccount',
                  TSgtsRbkRolesAndAccountsIface,'ACCOUNT_NAME','NAME','',true);
      AddCombo('INTERFACE','ComboBoxInterface','LabelInterface',true);
      AddCombo('PERMISSION','ComboBoxPermission','LabelPermission',true);
      AddCombo('PERMISSION_VALUE','ComboBoxValue','LabelValue',true);
    end;
  end;
end;

procedure TSgtsRbkPermissionInsertIface.Insert; 
begin
  inherited Insert;
  CoreIntf.CheckPermissions;
end;

{ TSgtsRbkPermissionUpdateIface }

procedure TSgtsRbkPermissionUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPermissionEditForm;
  InterfaceName:=SInterfacePermissionUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdatePermission;
    with ExecuteDefs do begin
      AddKeyLink('PERMISSION_ID');
      AddEditLink('ACCOUNT_ID','EditAccount','LabelAccount','ButtonAccount',
                  TSgtsRbkRolesAndAccountsIface,'ACCOUNT_NAME','NAME','',true);
      AddCombo('INTERFACE','ComboBoxInterface','LabelInterface',true);
      AddCombo('PERMISSION','ComboBoxPermission','LabelPermission',true);
      AddCombo('PERMISSION_VALUE','ComboBoxValue','LabelValue',true);
    end;
  end;
end;

procedure TSgtsRbkPermissionUpdateIface.Update;
begin
  inherited Update;
  CoreIntf.CheckPermissions;
end;

{ TSgtsRbkPermissionDeleteIface }

procedure TSgtsRbkPermissionDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfacePermissionDelete;
  DeleteQuestion:='Удалить право: %PERMISSION на интерфейс: %INTERFACE у учетной записи (роли): %ACCOUNT_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeletePermission;
    with ExecuteDefs do begin
      AddKeyLink('PERMISSION_ID');
      AddInvisible('PERMISSION');
      AddInvisible('INTERFACE');
      AddInvisible('ACCOUNT_NAME');
    end;
  end;
end;

procedure TSgtsRbkPermissionDeleteIface.Delete;
begin
  inherited Delete;
  CoreIntf.CheckPermissions;
end;

{ TSgtsRbkPermissionEditForm }

constructor TSgtsRbkPermissionEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  with ACoreIntf do begin
    GetInterfaceNames(ComboBoxInterface.Items);
  end;
end;

procedure TSgtsRbkPermissionEditForm.ComboBoxInterfaceChange(
  Sender: TObject);
var
  S: String;
begin
  ComboBoxPermission.Clear;
  ComboBoxValue.Clear;
  if ComboBoxInterface.ItemIndex<>-1 then begin
    S:=ComboBoxInterface.Items.Strings[ComboBoxInterface.ItemIndex];
    CoreIntf.GetInterfacePermissions(S,ComboBoxPermission.Items);
  end;
end;

procedure TSgtsRbkPermissionEditForm.ComboBoxPermissionChange(
  Sender: TObject);
var
  S1,S2: String;
begin
  ComboBoxValue.Clear;
  if (ComboBoxPermission.ItemIndex<>-1) and (ComboBoxInterface.ItemIndex<>-1) then begin
    S1:=ComboBoxInterface.Items.Strings[ComboBoxInterface.ItemIndex];
    S2:=ComboBoxPermission.Items.Strings[ComboBoxPermission.ItemIndex];
    CoreIntf.GetInterfacePermissionValues(S1,S2,ComboBoxValue.Items);
  end;
end;

end.
