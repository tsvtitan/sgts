unit SgtsKgesGraphHmzIntensityRefreshFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, CheckLst, Menus,
  SgtsKgesGraphPeriodRefreshFm, SgtsCoreIntf;

type
  TSgtsKgesGraphHmzIntensityRefreshForm = class(TSgtsKgesGraphPeriodRefreshForm)
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsKgesGraphHmzIntensityRefreshIface=class(TSgtsKgesGraphPeriodRefreshIface)
  public
    procedure Init; override;
  end;

var
  SgtsKgesGraphHmzIntensityRefreshForm: TSgtsKgesGraphHmzIntensityRefreshForm;

implementation

uses SgtsConsts, SgtsGraphFm, SgtsKgesGraphsConsts, SgtsProviderConsts,
     SgtsKgesGraphRefreshFm;

{$R *.dfm}

{ TSgtsKgesGraphHmzIntensityRefreshIface }

procedure TSgtsKgesGraphHmzIntensityRefreshIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsKgesGraphHmzIntensityRefreshForm;
  Caption:='Условия графиков по Химанализу';
  GraphName:='Интенсивность выноса кальция через контролируемые скважины дренажа 1-го ряда';

  with LeftAxisParams do begin
    Add('Интенсивность','INTENSITY');
    Add('Расход','EXPENSE');
  end;

  with BottomAxisParams do begin
    Add('Дата наблюдения','DATE_OBSERVATION');
    Add('Цикл','CYCLE_NUM').XMerging:=false;
  end;

  RightAxisParams.CopyFrom(LeftAxisParams);
end;

{ TSgtsKgesGraphHmzIntensityRefreshForm }

constructor TSgtsKgesGraphHmzIntensityRefreshForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);

end;

end.
