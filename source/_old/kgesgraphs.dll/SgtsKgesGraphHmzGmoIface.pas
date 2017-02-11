unit SgtsKgesGraphHmzGmoIface;

interface

uses SysUtils,
     SgtsKgesGraphPeriodPointsIface;

type

  TSgtsKgesGraphHmzGmoIface=class(TSgtsKgesGraphPeriodPointsIface)
  public
    procedure Init; override;
  end;


implementation

uses SgtsConsts, SgtsKgesGraphsConsts, SgtsProviderConsts,
     SgtsKgesGraphHmzGmoRefreshFm, SgtsIface;

{ TSgtsKgesGraphPzmPeriodIface }

procedure TSgtsKgesGraphHmzGmoIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceGraphHmzGmo;
  RefreshClass:=TSgtsKgesGraphHmzGmoRefreshIface;
  ProviderName:=SProviderSelectHmzJournalObservationsGmo;
  MenuIndex:=0;
  MenuPath:=Format(SGraphMenu,['Химанализ\Результаты наблюдений']);
  Caption:='Химанализ. Результаты наблюдений';
end;

end.

