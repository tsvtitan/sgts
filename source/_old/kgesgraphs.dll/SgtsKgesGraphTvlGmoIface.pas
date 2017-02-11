unit SgtsKgesGraphTvlGmoIface;

interface

uses SysUtils,
     SgtsKgesGraphPeriodPointsIface;

type

  TSgtsKgesGraphTvlGmoIface=class(TSgtsKgesGraphPeriodPointsIface)
  public
    procedure Init; override;
  end;


implementation

uses SgtsConsts, SgtsKgesGraphsConsts, SgtsProviderConsts,
     SgtsKgesGraphTvlGmoRefreshFm;

{ TSgtsKgesGraphPzmPeriodIface }

procedure TSgtsKgesGraphTvlGmoIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceGraphTvlGmo;
  RefreshClass:=TSgtsKgesGraphTvlGmoRefreshIface;
  ProviderName:=SProviderSelectTvlJournalObservationsGmo;
  MenuPath:=Format(SGraphMenu,['Влажность\Результаты наблюдений']);
  Caption:='Влажность. Результаты наблюдений';
end;

end.

