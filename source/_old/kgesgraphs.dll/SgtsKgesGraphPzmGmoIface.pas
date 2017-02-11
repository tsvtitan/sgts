unit SgtsKgesGraphPzmGmoIface;

interface

uses SysUtils,
     SgtsKgesGraphPeriodPointsIface;

type

  TSgtsKgesGraphPzmGmoIface=class(TSgtsKgesGraphPeriodPointsIface)
  public
    procedure Init; override;
  end;


implementation

uses SgtsConsts, SgtsKgesGraphsConsts, SgtsProviderConsts,
     SgtsKgesGraphPzmGmoRefreshFm;

{ TSgtsKgesGraphPzmPeriodIface }

procedure TSgtsKgesGraphPzmGmoIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceGraphPzmGmo;
  RefreshClass:=TSgtsKgesGraphPzmGmoRefreshIface;
  ProviderName:=SProviderSelectPzmJournalObservationsGmo;
  MenuPath:=Format(SGraphMenu,['Пьезометры\Результаты наблюдений']);
  Caption:='Пьезометры. Результаты наблюдений';
end;

end.

