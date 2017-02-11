unit SgtsKgesGraphPeriodIface;

interface

uses Classes, Contnrs,
     SgtsKgesGraphFm, SgtsCoreIntf,
     SgtsKgesGraphPeriodRefreshFm, SgtsDatabaseCDS;

type

  TSgtsKgesGraphPeriodIface=class(TSgtsKgesGraphIface)
  private
    FHistoryDataSets: TSgtsDatabaseCDSs;
    function GetRefreshIface: TSgtsKgesGraphPeriodRefreshIface;
  protected
    procedure AutoChartTitles; override;
    procedure CreateAllSeriesByAxisParams; override;
    procedure CreateDataSetFilters; override;

    procedure ClearHistoryDataSets;

    property HistoryDataSets: TSgtsDatabaseCDSs read FHistoryDataSets;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure OpenDataSets; override;
    procedure CloseDataSets; override;

    property RefreshIface: TSgtsKgesGraphPeriodRefreshIface read GetRefreshIface;
  end;

implementation

uses SysUtils, Variants, Controls,
     SgtsGetRecordsConfig, SgtsGraphChartFm, SgtsKgesGraphsConsts, SgtsKgesGraphRefreshFm,
     SgtsGraphFm, SgtsGraphChartSeriesDefs, SgtsPeriodExFm;

{ TSgtsKgesGraphPeriodIface }

constructor TSgtsKgesGraphPeriodIface.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FHistoryDataSets:=TSgtsDatabaseCDSs.Create(false);
end;

destructor TSgtsKgesGraphPeriodIface.Destroy; 
begin
  FHistoryDataSets.Free;
  inherited Destroy;
end;

function TSgtsKgesGraphPeriodIface.GetRefreshIface: TSgtsKgesGraphPeriodRefreshIface;
begin
  Result:=TSgtsKgesGraphPeriodRefreshIface(inherited RefreshIface);
end;

procedure TSgtsKgesGraphPeriodIface.Init;
begin
  inherited Init;
  RefreshClass:=TSgtsKgesGraphPeriodRefreshIface;
end;

procedure TSgtsKgesGraphPeriodIface.ClearHistoryDataSets;
var
  i: Integer;
begin
  for i:=0 to FHistoryDataSets.Count-1 do begin
    DataSets.Remove(HistoryDataSets.Items[i]);
  end;
  FHistoryDataSets.Clear;
end;

procedure TSgtsKgesGraphPeriodIface.CreateAllSeriesByAxisParams;
var
  Param: TSgtsKgesGraphAxisParam;
  History: TSgtsKgesGraphHistory;
  i: Integer;
  DataSet: TSgtsDatabaseCDS;
begin
  if Assigned(RefreshIface) then begin
    ClearHistoryDataSets;
    if RefreshIface.Histories.Count>0 then begin
      Param:=RefreshIface.BottomAxisParams.GetFirstCheck;
      if Assigned(Param) then begin
        CreateSeriesByAxisParams(RefreshIface.LeftAxisParams,atLeftBottom,Param,false);
        CreateSeriesByAxisParams(RefreshIface.RightAxisParams,atRightBottom,Param,false);
        for i:=0 to RefreshIface.Histories.Count-1 do begin
          History:=RefreshIface.Histories.Items[i];
          DataSet:=CreateDataSet(ProviderName);
          FHistoryDataSets.Add(DataSet);
          CreateSeriesByAxisParams(RefreshIface.LeftAxisParams,atLeftBottom,Param,false,DataSet,'',History.Caption,false);
          CreateSeriesByAxisParams(RefreshIface.RightAxisParams,atRightBottom,Param,false,DataSet,'',History.Caption,false);
        end;
      end;
    end else begin
      inherited CreateAllSeriesByAxisParams;
    end;
  end;
end;

procedure TSgtsKgesGraphPeriodIface.CreateDataSetFilters;
var
  D1, D2: TDateTime;
  C1, C2: Integer;
  I: Integer;
  History: TSgtsKgesGraphHistory;
  DataSet: TSgtsDatabaseCDS;
begin
  if Assigned(RefreshIface) then begin
  
    with DefaultDataSet do begin
      FilterGroups.Clear;
      if RefreshIface.PeriodChecked then begin
        with FilterGroups.Add do begin
          if TryStrToDate(RefreshIface.DateBegin,D1) then
            Filters.Add('DATE_OBSERVATION',fcEqualGreater,D1);
          if TryStrToDate(RefreshIface.DateEnd,D2) then
            Filters.Add('DATE_OBSERVATION',fcEqualLess,D2);
        end;
      end else begin
        with FilterGroups.Add do begin
          if TryStrToInt(RefreshIface.CycleBegin,C1) then
            Filters.Add('CYCLE_NUM',fcEqualGreater,C1);
          if TryStrToInt(RefreshIface.CycleEnd,C2) then
            Filters.Add('CYCLE_NUM',fcEqualLess,C2);
        end;
      end;
    end;

    if RefreshIface.Histories.Count=FHistoryDataSets.Count then
      for i:=0 to FHistoryDataSets.Count-1 do begin
        DataSet:=TSgtsDatabaseCDS(FHistoryDataSets.Items[i]);
        History:=RefreshIface.Histories.Items[i];
        with DataSet do begin
          FilterGroups.Clear;
          case History.HistoryType of
            petDate: begin
              with FilterGroups.Add do begin
                Filters.Add('DATE_OBSERVATION',fcEqualGreater,History.DateBegin);
                Filters.Add('DATE_OBSERVATION',fcEqualLess,History.DateEnd);
              end;
            end;
            petCycle: begin
              with FilterGroups.Add do begin
                Filters.Add('CYCLE_NUM',fcEqualGreater,History.CycleBegin);
                Filters.Add('CYCLE_NUM',fcEqualLess,History.CycleEnd);
              end;
            end;
          end;
        end;

    end;
    
  end;
end;

procedure TSgtsKgesGraphPeriodIface.CloseDataSets;
begin
  inherited CloseDataSets;
end;

procedure TSgtsKgesGraphPeriodIface.OpenDataSets;
begin
  inherited OpenDataSets;
end;

procedure TSgtsKgesGraphPeriodIface.AutoChartTitles;
var
  S, S1, S2: String;
  D1, D2: TDateTime;
  C1, C2: Integer;
begin
  inherited AutoChartTitles;
  if Assigned(RefreshIface) then begin
    S:=SAllPeriod;
    if RefreshIface.PeriodChecked then begin
      S1:='';
      if TryStrToDate(RefreshIface.DateBegin,D1) then
        S1:=DateToStr(D1);
      S2:='';  
      if TryStrToDate(RefreshIface.DateEnd,D2) then
        S2:=DateToStr(D2);
      if (Trim(S1)<>'') then
        S:=Format(SFromDate,[S1]);
      if (Trim(S2)<>'') then
        S:=Format(SToDate,[S2]);
      if (Trim(S1)<>'') and (Trim(S2)<>'') then begin
        S:=Format(SFromToDate,[S1,S2]);
      end;
    end else begin
      S:='';
      S1:='';
      if TryStrToInt(RefreshIface.CycleBegin,C1) then
        S1:=IntToStr(C1);
      S2:='';
      if TryStrToInt(RefreshIface.CycleEnd,C2) then
        S2:=IntToStr(C2);
      if (Trim(S1)<>'') then
        S:=Format(SFromCycle,[S1]);
      if (Trim(S2)<>'') then
        S:=Format(SToCycle,[S2]);
      if (Trim(S1)<>'') and (Trim(S2)<>'') then begin
        S:=Format(SFromToCycle,[S1,S2]);
      end;
    end;
    if Trim(S)<>'' then
      ChartTitle.Add(S);
  end;
end;

end.
