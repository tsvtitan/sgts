unit SgtsRbkRoleEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkRoleEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    MemoNote: TMemo;
    LabelNote: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkRoleInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkRoleUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkRoleDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkRoleEditForm: TSgtsRbkRoleEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs;

{$R *.dfm}

{ TSgtsRbkRoleInsertIface }

procedure TSgtsRbkRoleInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkRoleEditForm;
  InterfaceName:=SInterfaceRoleInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertRole;
    with ExecuteDefs do begin
      AddKey('ACCOUNT_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
      with AddInvisible('IS_ROLE') do Value:=1;
    end;
  end;
end;

{ TSgtsRbkRoleUpdateIface }

procedure TSgtsRbkRoleUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkRoleEditForm;
  InterfaceName:=SInterfaceRoleUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateRole;
    with ExecuteDefs do begin
      AddKeyLink('ACCOUNT_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
      with AddInvisible('IS_ROLE') do Value:=1;
    end;
  end;
end;

{ TSgtsRbkRoleDeleteIface }

procedure TSgtsRbkRoleDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceRoleDelete;
  DeleteQuestion:='Удалить роль %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteRole;
    with ExecuteDefs do begin
      AddKeyLink('ACCOUNT_ID');
      AddInvisible('NAME');
    end;
  end;
end;

{ TSgtsRbkInsertRoleForm }

end.
