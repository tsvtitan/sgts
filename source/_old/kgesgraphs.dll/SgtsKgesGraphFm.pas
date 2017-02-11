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
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure InitByIface(AIface: TSgtsFormIface); override;
  end;

  TSgtsKgesGraphIface=class(TSgtsGraphChartIface)
  private
    FAutoTitles: Boolean;
    FProviderName: String;
    FDefaultDataSet: TSgtsDatabaseCDS;
    function GetRefreshIface: TSgtsKgesGraphRefreshIface;
    procedure SetProviderName(Value: String);
  protected
    function GetFormClass: TSgtsFormClass; override;
    procedure AfterCreateForm(AForm: TSgtsForm); override;
    function GetSeriesDefName(Param: TSgtsKgesGraphAxisParam): String; virtual;
    procedure CreateSeriesByAxisParams(AxisParams: TSgtsKgesGraphAxisParams; AxisType: TSgtsGraphChartSeriesDefAxisType;
                                       XParam: TSgtsKgesGraphAxisParam; ParamUseFilter: Boolean;
                                       DataSet: TSgtsDatabaseCDS=nil; DataSetFilter: String='';
                                       FootTitle: String=''; XMerging: Boolean=false); virtual;
    procedure AutoChartTitles; virtual;
    procedure CreateAllSeriesByAxisParams; virtual;
    procedure CreateDataSetFilters; virtual;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure Init; override;

    procedure CloseDataSets; override;
    procedure OpenDataSets; override;

    property RefreshIface: TSgtsKgesGraphRefreshIface read GetRefreshIface;
    property AutoTitles: Boolean read FAutoTitles write FAutoTitles;
    property ProviderName: String read FProviderName write SetProviderName;
    property DefaultDataSet: TSgtsDatabaseCDS read FDefaultDataSet; 
  end;

var
  SgtsKgesGraphForm: TSgtsKgesGraphForm;

implementation

uses SgtsGraphFm, SgtsKgesGraphsConsts, SgtsCDS, SgtsGetRecordsConfig,
     SgtsObj, SgtsUtils, SgtsConfigIntf;

{$R *.dfm}

{ TSgtsKgesGraphIface }

constructor TSgtsKgesGraphIface.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FDefaultDataSet:=CreateDataSet();
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

procedure TSgtsKgesGraphIface.SetProviderName(Value: String);
var
  i: Integer;
begin
  FProviderName:=Value;
  for i:=0 to DataSets.Count-1 do begin
    DataSets.Items[i].ProviderName:=Value;
  end;
end;

procedure TSgtsKgesGraphIface.Init;
begin
  inherited Init;
  RefreshClass:=TSgtsKgesGraphRefreshIface;
end;

procedure TSgtsKgesGraphIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(RefreshIface) then begin
    if Trim(RefreshIface.GraphName)='' then begin
      RefreshIface.GraphName:=Caption;
      RefreshIface.DefaultGraphName:=Caption;
    end;
  end;
end;

function TSgtsKgesGraphIface.GetSeriesDefName(Param: TSgtsKgesGraphAxisParam): String;
begin
  Result:=Format(SSeriesDefName,[SeriesDefs.Count+1]);
end;

procedure TSgtsKgesGraphIface.CreateSeriesByAxisParams(AxisParams: TSgtsKgesGraphAxisParams; AxisType: TSgtsGraphChartSeriesDefAxisType;
                                                       XParam: TSgtsKgesGraphAxisParam; ParamUseFilter: Boolean;
                                                       DataSet: TSgtsDatabaseCDS=nil; DataSetFilter: String='';
                                                       FootTitle: String=''; XMerging: Boolean=false);

   function OldDS(InDS: TSgtsDatabaseCDS): Boolean;
   var
     Def: TSgtsGraphChartSeriesDef;
   begin
     Result:=false;
     if SeriesDefs.Count>0 then begin
       Def:=SeriesDefs.Items[SeriesDefs.Count-1];
       if Assigned(Def.DataSet) and
          (Def.DataSet is TSgtsDatabaseCDS) then begin
         Result:=TSgtsDatabaseCDS(Def.DataSet)=InDS;
       end;   
     end;
   end;

var
  i: Integer;
  S: String;
  DS: TSgtsDatabaseCDS;
  Param: TSgtsKgesGraphAxisParam;
  First: Boolean;
  Def: TSgtsGraphChartSeriesDef;
begin
  if Assigned(AxisParams) and
     Assigned(XParam) then begin
    First:=true;
    for i:=0 to AxisParams.Count-1 do begin
      Param:=AxisParams.Items[i];
      if Param.Checked and
         (Param.UseFilter=ParamUseFilter) then begin
        S:=GetSeriesDefName(Param);
        if FAutoTitles then begin
          if Trim(FootTitle)='' then
            ChartFootTitle.Add(Format(SChartFootTitleEmpty,[S,Param.Name]))
          else
            ChartFootTitle.Add(Format(SChartFootTitle,[S,Param.Name,FootTitle]));
          if First then begin
            case AxisType of
              atLeftBottom: ChartLeftAxisTitle.Text:=Param.Name;
              atRightBottom: ChartRightAxisTitle.Text:=Param.Name;
            end;
            First:=false;
          end;
        end;
        DS:=FDefaultDataSet;
        if Assigned(DataSet) then
          DS:=DataSet;
        if Assigned(DS) then begin
          if not OldDS(DS) then begin
            DS.SelectDefs.Clear;
            DS.Orders.Clear;
          end;
          with DS.SelectDefs do begin
            AddInvisible(Param.FieldName);
            AddInvisible(XParam.FieldName);
          end;
          DS.Orders.Add(XParam.FieldName,otAsc);
        end;
        Def:=nil;
        case Param.ParamType of
          aptLine: Def:=SeriesDefs.AddLine(S,DS,XParam.FieldName,Param.FieldName);
          aptPoint: Def:=SeriesDefs.AddPoint(S,DS,XParam.FieldName,Param.FieldName);
          aptBar: Def:=SeriesDefs.AddBar(S,DS,XParam.FieldName,Param.FieldName);
          aptArea: Def:=SeriesDefs.AddArea(S,DS,XParam.FieldName,Param.FieldName);
        end;
        if Assigned(Def) then begin
          Def.AxisType:=AxisType;
          Def.XMerging:=XParam.XMerging;
          if not Def.XMerging and XMerging then
            Def.XMerging:=XMerging;
          Def.DataSetFilter:=DataSetFilter;
        end;
      end;
    end;
  end;  
end;

procedure TSgtsKgesGraphIface.AutoChartTitles;
var
  Param: TSgtsKgesGraphAxisParam;
begin
  if Assigned(RefreshIface) then begin
    Param:=RefreshIface.BottomAxisParams.GetFirstCheck;
    if Assigned(Param) then begin
      if FAutoTitles then begin
        ChartTitle.Text:=RefreshIface.GraphName;
        ChartFootTitle.Clear;
        ChartBottomAxisTitle.Text:=Param.Name;
      end;
    end;
  end;
end;

procedure TSgtsKgesGraphIface.CreateAllSeriesByAxisParams;
var
  Param: TSgtsKgesGraphAxisParam;
begin
  if Assigned(RefreshIface) then begin
    Param:=RefreshIface.BottomAxisParams.GetFirstCheck;
    if Assigned(Param) then begin
      CreateSeriesByAxisParams(RefreshIface.LeftAxisParams,atLeftBottom,Param,false);
      CreateSeriesByAxisParams(RefreshIface.RightAxisParams,atRightBottom,Param,false);
    end;
  end;
end;

procedure TSgtsKgesGraphIface.CreateDataSetFilters;
begin
end;

procedure TSgtsKgesGraphIface.CloseDataSets;
begin
  inherited CloseDataSets;
  SeriesDefs.Clear;
  DataSets.ClearSelectDefs;
end;

procedure TSgtsKgesGraphIface.OpenDataSets;
begin
  AutoChartTitles;
  CreateAllSeriesByAxisParams;
  CreateDataSetFilters;
  inherited OpenDataSets;
  if Assigned(Form) then
    Form.Chart.ZoomPercent(95);
end;

{ TSgtsKgesGraphForm }

constructor TSgtsKgesGraphForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;

destructor TSgtsKgesGraphForm.Destroy;
begin
  inherited Destroy;
end;

procedure TSgtsKgesGraphForm.InitByIface(AIface: TSgtsFormIface);
var
  S: String;
begin
  inherited InitByIface(AIface);
  S:=ChartComponent.GetStr;
  S:=Iface.ReadParam(SConfigParamChartComponent,S,cmBase64);
  ChartComponent.SetStr(S);
  ResetChartState;
end;

procedure TSgtsKgesGraphForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  S: String;
begin
  if CanClose then begin
    S:=ChartComponent.GetStr;
    Iface.WriteParam(SConfigParamChartComponent,S,cmBase64);
  end;
  inherited;
end;

end.
