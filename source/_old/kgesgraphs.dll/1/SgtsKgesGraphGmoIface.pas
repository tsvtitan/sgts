unit SgtsKgesGraphGmoIface;

interface

uses SysUtils,
     SgtsKgesGraphPeriodIface;

type

  TSgtsKgesGraphGmoIface=class(TSgtsKgesGraphPeriodIface)
  public
    procedure Init; override;
  end;


implementation

uses SgtsConsts, SgtsKgesGraphsConsts, SgtsProviderConsts,
     SgtsKgesGraphGmoRefreshFm;

{ TSgtsKgesGraphGmoIface }

procedure TSgtsKgesGraphGmoIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceGraphGmo;
  RefreshClass:=TSgtsKgesGraphGmoRefreshIface;
  ProviderName:=SProviderSelectGmoJournalObservations;
  MenuPath:=Format(SGraphMenu,['Гидрометеорология\Результаты наблюдений']);
  Caption:='Гидрометеорология. Результаты наблюдений';
end;

end.

