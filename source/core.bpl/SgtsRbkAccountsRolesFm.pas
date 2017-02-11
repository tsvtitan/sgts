unit SgtsRbkAccountsRolesFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, 
  SgtsCoreIntf, StdCtrls;

type
  TSgtsRbkAccountsRolesForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkAccountsRolesIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkAccountsRolesForm: TSgtsRbkAccountsRolesForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkAccountRoleEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkAccountsRolesIface }

procedure TSgtsRbkAccountsRolesIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkAccountsRolesForm;
  InterfaceName:=SInterfaceAccountsRoles;
  InsertClass:=TSgtsRbkAccountRoleInsertIface;
  UpdateClass:=TSgtsRbkAccountRoleUpdateIface;
  DeleteClass:=TSgtsRbkAccountRoleDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectAccountsRoles;
    with SelectDefs do begin
      AddInvisible('ACCOUNT_ID');
      AddInvisible('ROLE_ID');
      Add('ACCOUNT_NAME','Учетная запись',150);
      Add('ROLE_NAME','Роль',150);
    end;
  end;
end;

{ TSgtsRbkAccountsRolesForm }

constructor TSgtsRbkAccountsRolesForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
