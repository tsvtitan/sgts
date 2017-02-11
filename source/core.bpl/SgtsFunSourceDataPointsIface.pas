unit SgtsFunSourceDataPointsIface;

interface

uses SgtsCoreIntf,
     SgtsRbkPointsFm, SgtsRbkPointEditFm;

type
  TSgtsFunSourceDataPointsIface=class(TSgtsRbkPointsIface)
  private
    FPointId: Variant;
{  protected
    function GetAsModal: Boolean; override;}
  public
    constructor CreateByPointId(ACoreIntf: ISgtsCore; APointId: Variant);
    procedure Init; override;
    function CanRefresh: Boolean; override;
    function CanDetail: Boolean; override;
  end;

  TSgtsFunSourceDataPointDetailIface=class(TSgtsRbkPointUpdateIface)
  public
    procedure Init; override;
  end;

implementation

uses SgtsFm, SgtsDataFm, SgtsConsts, SgtsGetRecordsConfig;

{ TSgtsFunSourceDataPointIface }

constructor TSgtsFunSourceDataPointsIface.CreateByPointId(ACoreIntf: ISgtsCore; APointId: Variant);
begin
  inherited Create(ACoreIntf);
  FPointId:=APointId;
  DetailClass:=TSgtsFunSourceDataPointDetailIface;
end;

procedure TSgtsFunSourceDataPointsIface.Init;
begin
  inherited Init;
  with DataSet do begin
    FilterGroups.Clear;
    FilterGroups.Add.Filters.Add('POINT_ID',fcEqual,FPointId);
  end;
end;

function TSgtsFunSourceDataPointsIface.CanRefresh: Boolean;
begin
  Result:=CanShow;
  if Result then begin
    if Assigned(Database) then
      Result:=Result and Database.ProviderExists(DataSet.ProviderName);
  end;
end;

function TSgtsFunSourceDataPointsIface.CanDetail: Boolean;
begin
  Result:=DataSet.Active and
          not DataSet.IsEmpty and
          PermissionExists(SPermissionNameDetail);
end;

{function TSgtsFunSourceDataPointsIface.GetAsModal: Boolean;
begin
  Result:=true;
end;}

{ TSgtsFunSourceDataPointDetailIface }

procedure TSgtsFunSourceDataPointDetailIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfacePointDetail;
end;


end.