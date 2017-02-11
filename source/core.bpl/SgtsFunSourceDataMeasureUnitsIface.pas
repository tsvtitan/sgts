unit SgtsFunSourceDataMeasureUnitsIface;

interface

uses
  SgtsCoreIntf,
  SgtsRbkMeasureUnitsFm,
  SgtsRbkMeasureUnitEditFm;

type
  TSgtsFunSourceDataMeasureUnitsIface=class(TSgtsRbkMeasureUnitsIface)
  private
    FMeasureUnitId: Variant;
  public
    constructor CreateByMeasureUnitId(ACoreIntf: ISgtsCore; AMeasureUnitId: Variant);
    procedure Init; override;
    function CanRefresh: Boolean; override;
    function CanDetail: Boolean; override;
  end;

  TSgtsFunSourceDataMeasureUnitDetailIface=class(TSgtsRbkMeasureUnitUpdateIface)
  public
    procedure Init; override;
  end;

implementation

uses SgtsFm, SgtsDataFm, SgtsConsts, SgtsGetRecordsConfig;

{ TSgtsFunSourceDataMeasureUnitIface }

constructor TSgtsFunSourceDataMeasureUnitsIface.CreateByMeasureUnitId(ACoreIntf: ISgtsCore; AMeasureUnitId: Variant);
begin
  inherited Create(ACoreIntf);
  FMeasureUnitId:=AMeasureUnitId;
  DetailClass:=TSgtsFunSourceDataMeasureUnitDetailIface;
end;

procedure TSgtsFunSourceDataMeasureUnitsIface.Init;
begin
  inherited Init;
  with DataSet do begin
    FilterGroups.Clear;
    FilterGroups.Add.Filters.Add('MEASURE_UNIT_ID',fcEqual,FMeasureUnitId);
  end;
end;

function TSgtsFunSourceDataMeasureUnitsIface.CanRefresh: Boolean;
begin
  Result:=CanShow;
  if Result then begin
    if Assigned(Database) then
      Result:=Result and Database.ProviderExists(DataSet.ProviderName);
  end;
end;

function TSgtsFunSourceDataMeasureUnitsIface.CanDetail: Boolean;
begin
  Result:=DataSet.Active and
          not DataSet.IsEmpty and
          PermissionExists(SPermissionNameDetail);
end;

{ TSgtsFunSourceDataMeasureUnitDetailIface }

procedure TSgtsFunSourceDataMeasureUnitDetailIface.Init; 
begin
  inherited Init;
  InterfaceName:=SInterfaceMeasureUnitDetail;
end;

end.
