unit SgtsRbkInstrumentTypeEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls, DB,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkInstrumentTypeEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    MemoNote: TMemo;
    LabelNote: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkInstrumentTypeInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkInstrumentTypeUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkInstrumentTypeDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkInstrumentTypeEditForm: TSgtsRbkInstrumentTypeEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs;

{$R *.dfm}

{ TSgtsRbkInstrumentTypeInsertIface }

procedure TSgtsRbkInstrumentTypeInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkInstrumentTypeEditForm;
  InterfaceName:=SInterfaceInstrumentTypeInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertInstrumentType;
    with ExecuteDefs do begin
      AddKey('INSTRUMENT_TYPE_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
    end;
  end;
end;

{ TSgtsRbkInstrumentTypeUpdateIface }

procedure TSgtsRbkInstrumentTypeUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkInstrumentTypeEditForm;
  InterfaceName:=SInterfaceInstrumentTypeUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateInstrumentType;
    with ExecuteDefs do begin
      AddKeyLink('INSTRUMENT_TYPE_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
    end;
  end;
end;

{ TSgtsRbkInstrumentTypeDeleteIface }

procedure TSgtsRbkInstrumentTypeDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceInstrumentTypeDelete;
  DeleteQuestion:='Удалить тип прибора %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteInstrumentType;
    with ExecuteDefs do begin
      AddKeyLink('INSTRUMENT_TYPE_ID');
      AddInvisible('NAME').ParamType:=ptUnknown;
    end;
  end;
end;

end.
