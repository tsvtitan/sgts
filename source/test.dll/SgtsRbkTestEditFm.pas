unit SgtsRbkTestEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls, DB,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsCoreIntf;

type
  TSgtsRbkTestEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    MemoNote: TMemo;
    LabelNote: TLabel;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkTestInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkTestUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkTestDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkTestEditForm: TSgtsRbkTestEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs;

{$R *.dfm}

{ TSgtsRbkTestInsertIface }

procedure TSgtsRbkTestInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkTestEditForm;
  InterfaceName:='�������� ������ � �������� �������';
  with DataSet do begin
    ProviderName:='I_TEST';
    with ExecuteDefs do begin  
      AddKey('TEST_ID').ProviderName:='GET_TEST_ID';
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
    end;
    CheckProvider:=false;
  end;
end;

{ TSgtsRbkTestUpdateIface }

procedure TSgtsRbkTestUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkTestEditForm;
  InterfaceName:='��������� ������ � �������� �������';
  with DataSet do begin
    ProviderName:='U_TEST';
    with ExecuteDefs do begin
      AddKeyLink('TEST_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
    end;
    CheckProvider:=false;
  end;
end;

{ TSgtsRbkTestDeleteIface }

procedure TSgtsRbkTestDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:='�������� ������ � �������� �������';
  DeleteQuestion:='������� ������ � ������ %NAME?';
  with DataSet do begin
    ProviderName:='D_TEST';
    with ExecuteDefs do begin
      AddKeyLink('TEST_ID');
      AddInvisible('NAME').ParamType:=ptUnknown;
    end;
    CheckProvider:=false;
  end;
end;
end.
