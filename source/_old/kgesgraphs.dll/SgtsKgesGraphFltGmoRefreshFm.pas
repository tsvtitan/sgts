unit SgtsKgesGraphFltGmoRefreshFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, CheckLst, Menus,
  SgtsKgesGraphPeriodPointsRefreshFm, SgtsCoreIntf;

type
  TSgtsKgesGraphFltGmoRefreshForm = class(TSgtsKgesGraphPeriodPointsRefreshForm)
  end;

  TSgtsKgesGraphFltGmoRefreshIface=class(TSgtsKgesGraphPeriodPointsRefreshIface)
  public
    procedure Init; override;
  end;

var
  SgtsKgesGraphFltGmoRefreshForm: TSgtsKgesGraphFltGmoRefreshForm;

implementation

uses SgtsConsts, SgtsGraphFm, SgtsKgesGraphsConsts, SgtsProviderConsts,
     SgtsKgesGraphRefreshFm;

{$R *.dfm}

{ TSgtsKgesGraphFltGmoRefreshIface }

procedure TSgtsKgesGraphFltGmoRefreshIface.Init;
var
  MetrGroup: Integer;
  TemperatureGroup: Integer;
  ExpenseVolumeGroup: Integer;
begin
  inherited Init;
  FormClass:=TSgtsKgesGraphFltGmoRefreshForm;
  Caption:='Условия графиков по Фильтрации';
  GraphName:='Результаты наблюдений за фильтрационными расходами';

  MeasureTypes.Add(2581);
  MeasureTypes.Add(2582);
  MeasureTypes.Add(2583);
  MeasureTypes.Add(2584);
  MeasureTypes.Add(2585);
  MeasureTypes.Add(2626);

  MetrGroup:=0;
  TemperatureGroup:=1;
  ExpenseVolumeGroup:=2;

  with LeftAxisParams do begin
    Add('Замеренный объем','VOLUME',-1,true);
    Add('Время замера','TIME',-1,true);
    Add('Расход','EXPENSE',-1,true);
    Add('Температура воды','T_WATER',-1,true);

    Add('Уровень верхнего бьефа','UVB',MetrGroup);
    Add('Уровень нижнего бьефа','UNB',MetrGroup);
    Add('Приращение УВБ','UVB_INC');
    Add('Температура воздуха','T_AIR',TemperatureGroup);
    Add('Температура воздуха за 10 суток','T_AIR_10',TemperatureGroup);
    Add('Температура воздуха за 30 суток','T_AIR_30',TemperatureGroup);
    Add('Температура воды в вернем бьефе','GMO_T_WATER',TemperatureGroup);
    Add('Осадков за сутки','RAIN_DAY');
    Add('Осадков с начала года','RAIN_YEAR');
    Add('Осадков за период','RAIN_PERIOD');
    Add('Сброс','UNSET',ExpenseVolumeGroup);
    Add('Приток','INFLUX',ExpenseVolumeGroup);
    Add('Объем водохранилища','V_VAULT');
  end;

  with BottomAxisParams do begin
    Add('Дата наблюдения','DATE_OBSERVATION');
    Add('Цикл','CYCLE_NUM');
    CopyFrom(LeftAxisParams,false,false);
  end;

  with RightAxisParams do begin
    CopyFrom(LeftAxisParams);
  end;
end;

{ TSgtsKgesGraphFltGmoRefreshForm }

end.
