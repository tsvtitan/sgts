unit SgtsRbkMeasureUnitEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls, DB,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkMeasureUnitEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    MemoNote: TMemo;
    LabelNote: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkMeasureUnitInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkMeasureUnitUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkMeasureUnitDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkMeasureUnitEditForm: TSgtsRbkMeasureUnitEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs;

{$R *.dfm}

{ TSgtsRbkMeasureUnitInsertIface }

procedure TSgtsRbkMeasureUnitInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkMeasureUnitEditForm;
  InterfaceName:=SInterfaceMeasureUnitInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertMeasureUnit;
    with ExecuteDefs do begin
      AddKey('MEASURE_UNIT_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
    end;
  end;
end;

{ TSgtsRbkMeasureUnitUpdateIface }

procedure TSgtsRbkMeasureUnitUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkMeasureUnitEditForm;
  InterfaceName:=SInterfaceMeasureUnitUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateMeasureUnit;
    with ExecuteDefs do begin
      AddKeyLink('MEASURE_UNIT_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
    end;
  end;
end;

{ TSgtsRbkMeasureUnitDeleteIface }

procedure TSgtsRbkMeasureUnitDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceMeasureUnitDelete;
  DeleteQuestion:='Удалить единицу измерения %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteMeasureUnit;
    with ExecuteDefs do begin
      AddKeyLink('MEASURE_UNIT_ID');
      AddInvisible('NAME').ParamType:=ptUnknown;
    end;
  end;
end;

end.
