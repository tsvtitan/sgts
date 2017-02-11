unit SgtsRbkRolesFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ExtCtrls, ComCtrls, ToolWin,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsCDS,
  SgtsCoreIntf, StdCtrls, DBCtrls, Grids, DBGrids;

type
  TSgtsRbkRolesForm = class(TSgtsDataGridForm)
    PanelInfo: TPanel;
    GroupBoxInfo: TGroupBox;
    PanelNote: TPanel;
    DBMemoNote: TDBMemo;
    Splitter: TSplitter;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkRolesIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkRolesForm: TSgtsRbkRolesForm;

implementation

uses SgtsProviderConsts, SgtsIface, SgtsConsts, SgtsRbkRoleEditFm,
     SgtsSelectDefs;

{$R *.dfm}

{ TSgtsRbkRolesIface }

procedure TSgtsRbkRolesIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkRolesForm;
  InterfaceName:=SInterfaceRoles;
  InsertClass:=TSgtsRbkRoleInsertIface;
  UpdateClass:=TSgtsRbkRoleUpdateIface;
  DeleteClass:=TSgtsRbkRoleDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectRoles;
    with SelectDefs do begin
      AddKey('ACCOUNT_ID');
      Add('NAME','Наименование');
      AddInvisible('DESCRIPTION');
      AddInvisible('IS_ROLE');
    end;
  end;
end;

{ TSgtsRbkRolesForm }

constructor TSgtsRbkRolesForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
