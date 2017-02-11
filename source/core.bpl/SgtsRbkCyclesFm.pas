unit SgtsRbkCyclesFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ExtCtrls, ComCtrls, ToolWin, StdCtrls, DBCtrls,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsCDS,
  SgtsCoreIntf, SgtsSelectDefs, Grids, DBGrids;

type
  TSgtsRbkCyclesForm = class(TSgtsDataGridForm)
    PanelInfo: TPanel;
    GroupBoxInfo: TGroupBox;
    PanelNote: TPanel;
    DBMemoDescription: TDBMemo;
    Splitter: TSplitter;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkCyclesIface=class(TSgtsDataGridIface)
  private
    function GetCycleMonth(Def: TSgtsSelectDef): Variant;
  public
    procedure Init; override;
  end;

var
  SgtsRbkCyclesForm: TSgtsRbkCyclesForm;

function GetMonthNameByIndex(Index: Integer): String;

implementation

uses SgtsProviderConsts, SgtsIface, SgtsConsts, SgtsRbkCycleEditFm,
     SgtsDatabaseCDS, SgtsGetRecordsConfig;

{$R *.dfm}

function GetMonthNameByIndex(Index: Integer): String;
begin
  case Index of
    0: Result:='Январь';
    1: Result:='Февраль';
    2: Result:='Март';
    3: Result:='Апрель';
    4: Result:='Май';
    5: Result:='Июнь';
    6: Result:='Июль';
    7: Result:='Август';
    8: Result:='Сентябрь';
    9: Result:='Октябрь';
    10: Result:='Ноябрь';
    11: Result:='Декабрь';
  else
    Result:='';  
  end;
end;

{ TSgtsRbkCyclesIface }

procedure TSgtsRbkCyclesIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkCyclesForm;
  InterfaceName:=SInterfaceCycles;
  InsertClass:=TSgtsRbkCycleInsertIface;
  UpdateClass:=TSgtsRbkCycleUpdateIface;
  DeleteClass:=TSgtsRbkCycleDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectCycles;
    with SelectDefs do begin
      AddKey('CYCLE_ID');
      Add('CYCLE_NUM','Номер',50);
      Add('CYCLE_YEAR','Год',60);
      AddCalc('CYCLE_MONTH_EX','Месяц','CYCLE_MONTH',GetCycleMonth,ftString,50,100);
      AddDrawCheck('IS_CLOSE_EX','Закрыт','IS_CLOSE',30);
      AddInvisible('DESCRIPTION');
    end;
    Orders.Add('CYCLE_NUM',otAsc);
  end;
end;

function TSgtsRbkCyclesIface.GetCycleMonth(Def: TSgtsSelectDef): Variant;
var
  S: String;
begin
  Result:=Null;
  S:=GetMonthNameByIndex(DataSet.FieldByName(Def.CalcName).AsInteger);
  if Trim(S)<>'' then
    Result:=S;
end;

{ TSgtsRbkCyclesForm }

constructor TSgtsRbkCyclesForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
