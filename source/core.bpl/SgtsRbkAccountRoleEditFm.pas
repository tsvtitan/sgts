unit SgtsRbkAccountRoleEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkAccountRoleEditForm = class(TSgtsDataEditForm)
    LabelAccount: TLabel;
    EditAccount: TEdit;
    ButtonAccount: TButton;
    LabelRole: TLabel;
    EditRole: TEdit;
    ButtonRole: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkAccountRoleInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkAccountRoleUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkAccountRoleDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkAccountRoleRoleEditForm: TSgtsRbkAccountRoleEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkAccountsFm, SgtsRbkRolesFm;

{$R *.dfm}

{ TSgtsRbkAccountRoleInsertIface }

procedure TSgtsRbkAccountRoleInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkAccountRoleEditForm;
  InterfaceName:=SInterfaceAccountRoleInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertAccountRole;
    with ExecuteDefs do begin
      AddEditLink('ACCOUNT_ID','EditAccount','LabelAccount','ButtonAccount',
                  TSgtsRbkAccountsIface,'ACCOUNT_NAME','NAME','',true);
      AddEditLink('ROLE_ID','EditRole','LabelRole','ButtonRole',
                  TSgtsRbkRolesIface,'ROLE_NAME','NAME','ACCOUNT_ID',true);
    end;
  end;
end;

{ TSgtsRbkAccountRoleUpdateIface }

procedure TSgtsRbkAccountRoleUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkAccountRoleEditForm;
  InterfaceName:=SInterfaceAccountRoleUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateAccountRole;
    with ExecuteDefs do begin
      AddEditLink('ACCOUNT_ID','EditAccount','LabelAccount','ButtonAccount',
                  TSgtsRbkAccountsIface,'ACCOUNT_NAME','NAME','',true,true);
      AddEditLink('ROLE_ID','EditRole','LabelRole','ButtonRole',
                  TSgtsRbkRolesIface,'ROLE_NAME','NAME','ACCOUNT_ID',true,true);
    end;
  end;
end;

{ TSgtsRbkAccountRoleDeleteIface }

procedure TSgtsRbkAccountRoleDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceAccountRoleDelete;
  DeleteQuestion:='Удалить доступ учетной записи: %ACCOUNT_NAME к роли %ROLE_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteAccountRole;
    with ExecuteDefs do begin
      AddKeyLink('ACCOUNT_ID');
      AddKeyLink('ROLE_ID');
      AddInvisible('ACCOUNT_NAME');
      AddInvisible('ROLE_NAME');
    end;
  end;
end;

end.
