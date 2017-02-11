unit SgtsKgesGraphFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtDlgs, ImgList, TeeProcs, TeEngine,
  Chart, DbChart, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsGraphChartFm, SgtsFm, SgtsKgesGraphRefreshFm, SgtsCoreIntf, SgtsDatabaseCDS,
  SgtsGraphChartSeriesDefs;

type
  TSgtsKgesGraphForm = class(TSgtsGraphChartForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsKgesGraphIface=class(TSgtsGraphChartIface)
  private
    FDataSet: TSgtsDatabaseCDS;
    FAutoTitles: Boolean;
    function GetRefreshIface: TSgtsKgesGraphRefreshIface;
  protected
    function GetFormClass: TSgtsFormClass; override;
    procedure AfterCreateForm(AForm: TSgtsForm); override;
    function GetSeriesDefName(Param: TSgtsKgesGraphAxisParam): String; virtual;
    function GetSeriesDefDataSet(Param: TSgtsKgesGraphAxisParam): TSgtsDatabaseCDS; virtual;
    procedure CreateSeriesByAxisParams; virtual;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure Init; override;

    procedure CloseDataSets; override;
    procedure OpenDataSets; override;

    property RefreshIface: TSgtsKgesGraphRefreshIface read GetRefreshIface;
    property DataSet: TSgtsDatabaseCDS read FDataSet;
    property AutoTitles: Boolean read FAutoTitles write FAutoTitles;
  end;

var
  SgtsKgesGraphForm: TSgtsKgesGraphForm;

implementation

uses SgtsGraphFm, SgtsKgesGraphsConsts, SgtsCDS, SgtsGetRecordsConfig;

{$R *.dfm}

{ TSgtsKgesGraphIface }

constructor TSgtsKgesGraphIface.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FDataSet:=CreateDataSet();
  FAutoTitles:=true;
end;

destructor TSgtsKgesGraphIface.Destroy;
begin
  inherited Destroy;
end;

function TSgtsKgesGraphIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsKgesGraphForm;
end;

function TSgtsKgesGraphIface.GetRefreshIface: TSgtsKgesGraphRefreshIface;
begin
  Result:=TSgtsKgesGraphRefreshIface(inherited RefreshIface);
end;

procedure TSgtsKgesGraphIface.Init;
begin
  inherited Init;
  RefreshClass:=TSgtsKgesGraphRefreshIface;
end;

function TSgtsKgesGraphIface.GetSeriesDefName(Param: TSgtsKgesGraphAxisParam): String;
begin
  Result:=Format(SSeriesDefName,[SeriesDefs.Count+1]);
end;

function TSgtsKgesGraphIface.GetSeriesDefDataSet(Param: TSgtsKgesGraphAxisParam): TSgtsDatabaseCDS; 
begin
  Result:=nil;
  if DataSets.Count>0 then
    Result:=DataSets.Items[0];
end;

procedure TSgtsKgesGraphIface.CreateSeriesByAxisParams;

  procedure CreateLocal(AxisParams: TSgtsKgesGraphAxisParams; AxisType: TSgtsGraphChartSeriesDefAxisType; XFieldName: String);
  var
    i: Integer;
    S: String;
    DS: TSgtsDatabaseCDS;
    Param: TSgtsKgesGraphAxisParam;
    First: Boolean;
  begin
    First:=true;
    for i:=0 to AxisParams.Count-1 do begin
      Param:=AxisParams.Items[i];
      if Param.Checked then begin
        S:=GetSeriesDefName(Param);
        if FAutoTitles then begin
          ChartFootTitle.Add(Format(SChartFootTitle,[S,Param.Name]));
          if First then begin
            case AxisType of
              atLeftBottom: ChartLeftAxisTitle.Text:=Param.Name;
              atRightBottom: ChartRightAxisTitle.Text:=Param.Name;
            end;
            First:=false;
          end;
        end;  
        DS:=GetSeriesDefDataSet(Param);
        if Assigned(DS) then begin
          with DS.SelectDefs do begin
            AddInvisible(Param.FieldName);
            AddInvisible(XFieldName);
          end;
          DS.Orders.Add(XFieldName,otAsc);
        end;
        case Param.ParamType of
          aptLine: SeriesDefs.AddLine(S,DS,XFieldName,Param.FieldName).AxisType:=AxisType;
          aptPoint: SeriesDefs.AddPoint(S,DS,XFieldName,Param.FieldName).AxisType:=AxisType;
        end;
      end;
    end;
  end;

var
  XFieldName: String;
  Param: TSgtsKgesGraphAxisParam;
begin
  if Assigned(RefreshIface) then begin
    Param:=RefreshIface.BottomAxisParams.GetFirstCheck;
    if Assigned(Param) then begin
      XFieldName:=Param.FieldName;
      if FAutoTitles then begin
        ChartTitle.Text:=RefreshIface.GraphCaption;
        ChartFootTitle.Clear;
        ChartBottomAxisTitle.Text:=Param.Name;
      end;
      CreateLocal(RefreshIface.LeftAxisParams,atLeftBottom,XFieldName);
      CreateLocal(RefreshIface.RightAxisParams,atRightBottom,XFieldName);
    end;
  end;
end;

procedure TSgtsKgesGraphIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
end;

procedure TSgtsKgesGraphIface.CloseDataSets; 
begin
  inherited CloseDataSets;
  SeriesDefs.Clear;
  DataSets.ClearSelectDefs;
end;

procedure TSgtsKgesGraphIface.OpenDataSets;
begin
  CreateSeriesByAxisParams;
  if Assigned(RefreshIface) then begin
    with FDataSet do begin
      FilterGroups.Clear;
      if RefreshIface.ParamPeriodChecked then begin
        FilterGroups.Add.Filters.Add('DATE_OBSERVATION',fcEqualGreater,RefreshIface.ParamDateBegin);
        FilterGroups.Add.Filters.Add('DATE_OBSERVATION',fcEqualLess,RefreshIface.ParamDateEnd);
      end;
      if RefreshIface.ParamCycleChecked then begin
        FilterGroups.Add.Filters.Add('CYCLE_NUM',fcEqualGreater,RefreshIface.ParamCycleMin);
        FilterGroups.Add.Filters.Add('CYCLE_NUM',fcEqualLess,RefreshIface.ParamCycleMax);
      end;
    end;
  end;  
  inherited OpenDataSets;
end;

end.
