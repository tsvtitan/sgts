unit SgtsRbkPointTypeEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls, DB,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkPointTypeEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    MemoNote: TMemo;
    LabelNote: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkPointTypeInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkPointTypeUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkPointTypeDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkPointTypeEditForm: TSgtsRbkPointTypeEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs;

{$R *.dfm}

{ TSgtsRbkPointTypeInsertIface }

procedure TSgtsRbkPointTypeInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPointTypeEditForm;
  InterfaceName:=SInterfacePointTypeInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertPointType;
    with ExecuteDefs do begin
      AddKey('POINT_TYPE_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
    end;
  end;
end;

{ TSgtsRbkPointTypeUpdateIface }

procedure TSgtsRbkPointTypeUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPointTypeEditForm;
  InterfaceName:=SInterfacePointTypeUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdatePointType;
    with ExecuteDefs do begin
      AddKeyLink('POINT_TYPE_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
    end;
  end;
end;

{ TSgtsRbkPointTypeDeleteIface }

procedure TSgtsRbkPointTypeDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfacePointTypeDelete;
  DeleteQuestion:='Удалить тип точки %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeletePointType;
    with ExecuteDefs do begin
      AddKeyLink('POINT_TYPE_ID');
      AddInvisible('NAME').ParamType:=ptUnknown;
    end;
  end;
end;

end.
