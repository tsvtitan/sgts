unit SgtsRbkAlgorithmEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls, DB,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkAlgorithmEditForm = class(TSgtsDataEditForm)
    LabelProcName: TLabel;
    EditProcName: TEdit;
    MemoNote: TMemo;
    LabelNote: TLabel;
    LabelName: TLabel;
    EditName: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkAlgorithmInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkAlgorithmUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkAlgorithmDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkAlgorithmEditForm: TSgtsRbkAlgorithmEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs;

{$R *.dfm}

{ TSgtsRbkAlgorithmInsertIface }

procedure TSgtsRbkAlgorithmInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkAlgorithmEditForm;
  InterfaceName:=SInterfaceAlgorithmInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertAlgorithm;
    with ExecuteDefs do begin
      AddKey('ALGORITHM_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddEdit('PROC_NAME','EditProcName','LabelProcName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
    end;
  end;
end;

{ TSgtsRbkAlgorithmUpdateIface }

procedure TSgtsRbkAlgorithmUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkAlgorithmEditForm;
  InterfaceName:=SInterfaceAlgorithmUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateAlgorithm;
    with ExecuteDefs do begin
      AddKeyLink('ALGORITHM_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddEdit('PROC_NAME','EditProcName','LabelProcName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
    end;
  end;
end;

{ TSgtsRbkAlgorithmDeleteIface }

procedure TSgtsRbkAlgorithmDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceAlgorithmDelete;
  DeleteQuestion:='Удалить алгоритм %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteAlgorithm;
    with ExecuteDefs do begin
      AddKeyLink('ALGORITHM_ID');
      AddInvisible('NAME').ParamType:=ptUnknown;
    end;
  end;
end;

end.
