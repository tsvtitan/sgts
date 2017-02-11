unit SgtsFunSourceDataInstrumentsIface;

interface

uses
  SgtsCoreIntf,
  SgtsRbkInstrumentsFm,
  SgtsRbkInstrumentEditFm;

type
  TSgtsFunSourceDataInstrumentsIface=class(TSgtsRbkInstrumentsIface)
  private
    FInstrumentId: Variant;
  public
    constructor CreateByInstrumentId(ACoreIntf: ISgtsCore; AInstrumentId: Variant);
    procedure Init; override;
    function CanRefresh: Boolean; override;
    function CanDetail: Boolean; override;
  end;

  TSgtsFunSourceDataInstrumentDetailIface=class(TSgtsRbkInstrumentUpdateIface)
  public
    procedure Init; override;
  end;

implementation

uses SgtsFm, SgtsDataFm, SgtsConsts, SgtsGetRecordsConfig;

{ TSgtsFunSourceDataInstrumentIface }

constructor TSgtsFunSourceDataInstrumentsIface.CreateByInstrumentId(ACoreIntf: ISgtsCore; AInstrumentId: Variant);
begin
  inherited Create(ACoreIntf);
  FInstrumentId:=AInstrumentId;
  DetailClass:=TSgtsFunSourceDataInstrumentDetailIface;
end;

procedure TSgtsFunSourceDataInstrumentsIface.Init;
begin
  inherited Init;
  with DataSet do begin
    FilterGroups.Clear;
    FilterGroups.Add.Filters.Add('INSTRUMENT_ID',fcEqual,FInstrumentId);
  end;
end;

function TSgtsFunSourceDataInstrumentsIface.CanRefresh: Boolean;
begin
  Result:=CanShow;
  if Result then begin
    if Assigned(Database) then
      Result:=Result and Database.ProviderExists(DataSet.ProviderName);
  end;
end;

function TSgtsFunSourceDataInstrumentsIface.CanDetail: Boolean;
begin
  Result:=DataSet.Active and
          not DataSet.IsEmpty and
          PermissionExists(SPermissionNameDetail);
end;

{ TSgtsFunSourceDataInstrumentDetailIface }

procedure TSgtsFunSourceDataInstrumentDetailIface.Init; 
begin
  inherited Init;
  InterfaceName:=SInterfaceInstrumentDetail;
end;

end.
