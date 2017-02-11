unit SgtsRbkGroupEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls, DB,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkGroupEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    MemoNote: TMemo;
    LabelNote: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkGroupInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkGroupUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkGroupDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkGroupEditForm: TSgtsRbkGroupEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs;

{$R *.dfm}

{ TSgtsRbkGroupInsertIface }

procedure TSgtsRbkGroupInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkGroupEditForm;
  InterfaceName:=SInterfaceGroupInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertGroup;
    with ExecuteDefs do begin
      AddKey('GROUP_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
    end;
  end;
end;

{ TSgtsRbkGroupUpdateIface }

procedure TSgtsRbkGroupUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkGroupEditForm;
  InterfaceName:=SInterfaceGroupUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateGroup;
    with ExecuteDefs do begin
      AddKeyLink('GROUP_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
    end;
  end;
end;

{ TSgtsRbkGroupDeleteIface }

procedure TSgtsRbkGroupDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceGroupDelete;
  DeleteQuestion:='Удалить группу %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteGroup;
    with ExecuteDefs do begin
      AddKeyLink('GROUP_ID');
      AddInvisible('NAME').ParamType:=ptUnknown;
    end;
  end;
end;

{ TSgtsRbkInsertGroupForm }

end.
