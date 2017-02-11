unit SgtsRbkRolesAndAccountsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsSelectDefs,  
  SgtsCoreIntf, StdCtrls;

type
  TSgtsRbkRolesAndAccountsForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkRolesAndAccountsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkRolesAndAccountsForm: TSgtsRbkRolesAndAccountsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsConsts, SgtsGetRecordsConfig;

{$R *.dfm}

{ TSgtsRbkRolesAndAccountsIface }

procedure TSgtsRbkRolesAndAccountsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkRolesAndAccountsForm;
  InterfaceName:=SInterfaceRolesAndAccounts;
  with DataSet do begin
    ProviderName:=SProviderSelectRolesAndAccounts;
    with SelectDefs do begin
      AddKey('ACCOUNT_ID');
      Add('NAME','Наименование',200);
      AddDrawCheck('IS_ROLE_EX','Признак роли','IS_ROLE',50).Alignment:=daCenter;
    end;
    Orders.Add('IS_ROLE',otDesc);
  end;
end;

{ TSgtsRbkRolesAndAccountsForm }

constructor TSgtsRbkRolesAndAccountsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
