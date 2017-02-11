unit SgtsRbkMeasureTypeParamsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, 
  SgtsCoreIntf, StdCtrls;

type
  TSgtsRbkMeasureTypeParamsForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkMeasureTypeParamsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkMeasureTypeParamsForm: TSgtsRbkMeasureTypeParamsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkMeasureTypeParamEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkMeasureTypeParamsIface }

procedure TSgtsRbkMeasureTypeParamsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkMeasureTypeParamsForm;
  InterfaceName:=SInterfaceMeasureTypeParams;
  InsertClass:=TSgtsRbkMeasureTypeParamInsertIface;
  UpdateClass:=TSgtsRbkMeasureTypeParamUpdateIface;
  DeleteClass:=TSgtsRbkMeasureTypeParamDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectMeasureTypeParams;
    with SelectDefs do begin
      AddInvisible('MEASURE_TYPE_ID');
      AddInvisible('PARAM_ID');
      Add('MEASURE_TYPE_NAME','Вид измерения',150);
      Add('PARAM_NAME','Параметр',150);
      Add('PRIORITY','Порядок',40);
    end;
  end;
end;

{ TSgtsRbkMeasureTypeParamsForm }

constructor TSgtsRbkMeasureTypeParamsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
