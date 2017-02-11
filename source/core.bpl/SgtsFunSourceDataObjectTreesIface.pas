unit SgtsFunSourceDataObjectTreesIface;

interface

uses
  SgtsCoreIntf,
  SgtsRbkObjectTreesFm,
  SgtsRbkObjectTreeEditFm;

type
  TSgtsFunSourceDataObjectTreesIface=class(TSgtsRbkObjectTreesIface)
  private
    FObjectId: Variant;
  public
    constructor CreateByObjectId(ACoreIntf: ISgtsCore; AObjectId: Variant);
    procedure Init; override;
    function CanRefresh: Boolean; override;
    function CanDetail: Boolean; override;
  end;

  TSgtsFunSourceDataObjectTreeDetailIface=class(TSgtsRbkObjectTreeUpdateIface)
  public
    procedure Init; override;
  end;

implementation

uses SgtsFm, SgtsDataFm, SgtsConsts, SgtsGetRecordsConfig;

{ TSgtsFunSourceDataObjectTreeIface }

constructor TSgtsFunSourceDataObjectTreesIface.CreateByObjectId(ACoreIntf: ISgtsCore; AObjectId: Variant);
begin
  inherited Create(ACoreIntf);
  FObjectId:=AObjectId;
  DetailClass:=TSgtsFunSourceDataObjectTreeDetailIface;
end;

procedure TSgtsFunSourceDataObjectTreesIface.Init;
begin
  inherited Init;
  with DataSet do begin
    FilterGroups.Clear;
    FilterGroups.Add.Filters.Add('OBJECT_ID',fcEqual,FObjectId);
  end;
end;

function TSgtsFunSourceDataObjectTreesIface.CanRefresh: Boolean;
begin
  Result:=CanShow;
  if Result then begin
    if Assigned(Database) then
      Result:=Result and Database.ProviderExists(DataSet.ProviderName);
  end;
end;

function TSgtsFunSourceDataObjectTreesIface.CanDetail: Boolean;
begin
  Result:=DataSet.Active and
          not DataSet.IsEmpty and
          PermissionExists(SPermissionNameDetail);
end;

{ TSgtsFunSourceDataObjectTreeDetailIface }

procedure TSgtsFunSourceDataObjectTreeDetailIface.Init; 
begin
  inherited Init;
  InterfaceName:=SInterfaceObjectTreeDetail;
end;

end.