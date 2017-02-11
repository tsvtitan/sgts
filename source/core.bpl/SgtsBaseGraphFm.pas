unit SgtsBaseGraphFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtDlgs, ImgList, TeeProcs, TeEngine,
  Chart, DbChart, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsGraphChartFm, SgtsFm, SgtsBaseGraphRefreshFm, SgtsCoreIntf, SgtsDatabaseCDS,
  SgtsGraphChartSeriesDefs;

type
  TSgtsBaseGraphForm = class(TSgtsGraphChartForm)
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure InitByIface(AIface: TSgtsFormIface); override;
  end;

  TSgtsBaseGraphIface=class(TSgtsGraphChartIface)
  private
    FAutoTitles: Boolean;
    FProviderName: String;
    FDefaultDataSet: TSgtsDatabaseCDS;
    FOtherDataSets: TSgtsDatabaseCDSs;
    FGraphId: Integer;
    FDetermination: String;
    FColumns: String;
    function GetRefreshIface: TSgtsBaseGraphRefreshIface;
    procedure SetProviderName(Value: String);
  protected
    function GetFormClass: TSgtsFormClass; override;
    procedure AfterCreateForm(AForm: TSgtsForm); override;
    procedure BeforeShowForm(AForm: TSgtsForm); override;
    function GetSeriesDefName(Param: TSgtsBaseGraphAxisParam): String; virtual;
    procedure CreateSeriesByAxisParams(AxisParams: TSgtsBaseGraphAxisParams; AxisType: TSgtsGraphChartSeriesDefAxisType;
                                       XParam: TSgtsBaseGraphAxisParam; ParamUseFilter: Boolean;
                                       DataSet: TSgtsDatabaseCDS=nil; DataSetFilter: String='';
                                       FootTitle: String=''; XMerging: Boolean=false; Color: TColor=clNone); virtual;
    procedure AutoChartTitles; virtual;
    procedure CreateAllSeriesByAxisParams; virtual;
    procedure CreateDataSetFilters; virtual;

    procedure ClearOtherDataSets;

    property OtherDataSets: TSgtsDatabaseCDSs read FOtherDataSets write FOtherDataSets; 
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure Init; overload; override;
    procedure Init(AGraphId: Integer; AInterfaceName, ADescription, AMenuPath: String;
                   ADetermination, AColumns, AProviderName, ACondition: String); reintroduce; overload;

    procedure CloseDataSets; override;
    procedure OpenDataSets; override;

    property RefreshIface: TSgtsBaseGraphRefreshIface read GetRefreshIface;
    property AutoTitles: Boolean read FAutoTitles write FAutoTitles;
    property ProviderName: String read FProviderName write SetProviderName;

    property DefaultDataSet: TSgtsDatabaseCDS read FDefaultDataSet;
    property GraphId: Integer read FGraphId;
    property Determination: String read FDetermination;
    property Columns: String read FColumns write FColumns;


  end;

var
  SgtsBaseGraphForm: TSgtsBaseGraphForm;

implementation

uses SgtsGraphFm, SgtsConsts, SgtsCDS, SgtsGetRecordsConfig,
     SgtsObj, SgtsUtils, SgtsConfigIntf, SgtsIface, SgtsCoreObj, SgtsSelectDefs;

{$R *.dfm}

{ TSgtsBaseGraphIface }

constructor TSgtsBaseGraphIface.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FDefaultDataSet:=CreateDataSet();
  FOtherDataSets:=TSgtsDatabaseCDSs.Create(false);
  FAutoTitles:=true;
end;

destructor TSgtsBaseGraphIface.Destroy;
begin
  FOtherDataSets.Free;
  inherited Destroy;
end;

function TSgtsBaseGraphIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsBaseGraphForm;
end;

function TSgtsBaseGraphIface.GetRefreshIface: TSgtsBaseGraphRefreshIface;
begin
  Result:=TSgtsBaseGraphRefreshIface(inherited RefreshIface);
end;

procedure TSgtsBaseGraphIface.SetProviderName(Value: String);
var
  i: Integer;
begin
  FProviderName:=Value;
  if Assigned(CoreIntf) and
     Assigned(CoreIntf.DatabaseModules.Current) then
    CoreIntf.DatabaseModules.Current.Database.GetRecordsProviders.AddDefault(Value);
  for i:=0 to DataSets.Count-1 do begin
    DataSets.Items[i].ProviderName:=Value;
  end;
end;

procedure TSgtsBaseGraphIface.ClearOtherDataSets;
var
  i: Integer;
begin
  for i:=0 to FOtherDataSets.Count-1 do begin
    DataSets.Remove(FOtherDataSets.Items[i]);
  end;
  FOtherDataSets.Clear;
end;

procedure TSgtsBaseGraphIface.Init;
begin
  inherited Init;
  RefreshClass:=TSgtsBaseGraphRefreshIface;
end;

procedure TSgtsBaseGraphIface.Init(AGraphId: Integer; AInterfaceName, ADescription, AMenuPath: String;
                                   ADetermination, AColumns, AProviderName, ACondition: String);
begin
  FGraphId:=AGraphId;
  FDetermination:=ADetermination;
  FColumns:=AColumns;
  Caption:=AInterfaceName;
  Init;
  InterfaceName:=AInterfaceName;
  ProviderName:=AProviderName;
  MenuHint:=ADescription;
  MenuPath:=AMenuPath;
  SectionName:=Name+IntToStr(FGraphId);
end;

procedure TSgtsBaseGraphIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(RefreshIface) then begin
    if Trim(RefreshIface.GraphName)='' then begin
      RefreshIface.GraphName:=Caption;
      RefreshIface.DefaultGraphName:=Caption;
    end;
  end;
end;

function TSgtsBaseGraphIface.GetSeriesDefName(Param: TSgtsBaseGraphAxisParam): String;
begin
  Result:=Format(SSeriesDefName,[SeriesDefs.Count+1]);
end;

procedure TSgtsBaseGraphIface.CreateSeriesByAxisParams(AxisParams: TSgtsBaseGraphAxisParams; AxisType: TSgtsGraphChartSeriesDefAxisType;
                                                       XParam: TSgtsBaseGraphAxisParam; ParamUseFilter: Boolean;
                                                       DataSet: TSgtsDatabaseCDS=nil; DataSetFilter: String='';
                                                       FootTitle: String=''; XMerging: Boolean=false; Color: TColor=clNone);

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
  Param: TSgtsBaseGraphAxisParam;
  First: Boolean;
  Def: TSgtsGraphChartSeriesDef;
  Def1: TSgtsSelectDef;
  LabelFieldName: String;
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
        LabelFieldName:=XParam.LabelFieldName;
        DS:=FDefaultDataSet;
        if Assigned(DataSet) then
          DS:=DataSet;
        if Assigned(DS) then begin
          if (Trim(Param.ProviderName)<>'') and
             not AnsiSameText(Param.ProviderName,DS.ProviderName) then begin

            DS:=CreateDataSet(Param.ProviderName);
            FOtherDataSets.Add(DS);
            if not Param.UseFilter then begin
              DataSetFilter:='';
              LabelFieldName:='';
            end;
          end;
          if not OldDS(DS) then begin
            DS.SelectDefs.Clear;
            DS.Orders.Clear;
          end;
          with DS.SelectDefs do begin
            Def1:=AddInvisible(Param.FieldName);
            if Assigned(Def1) then
              Def1.FuncType:=Param.FunctType;
            AddInvisible(XParam.FieldName);
            if Trim(XParam.LabelFieldName)<>'' then
              AddInvisible(XParam.LabelFieldName);
          end;
          DS.Orders.Add(XParam.FieldName,otAsc);
        end;
        Def:=nil;
        case Param.ParamType of
          aptLine: Def:=SeriesDefs.AddLine(S,DS,XParam.FieldName,Param.FieldName,XParam.LabelFieldName);
          aptPoint: Def:=SeriesDefs.AddPoint(S,DS,XParam.FieldName,Param.FieldName,XParam.LabelFieldName);
          aptBar: Def:=SeriesDefs.AddBar(S,DS,XParam.FieldName,Param.FieldName,XParam.LabelFieldName);
          aptArea: Def:=SeriesDefs.AddArea(S,DS,XParam.FieldName,Param.FieldName,XParam.LabelFieldName);
          aptLinePoint: Def:=SeriesDefs.AddLinePoint(S,DS,XParam.FieldName,Param.FieldName,XParam.LabelFieldName);
        end;
        if Assigned(Def) then begin
          Def.ColorType:=ctAuto;
          if Color<>clNone then begin
            Def.ColorType:=ctManual;
            Def.Color:=Color;
          end;
          Def.AxisType:=AxisType;
          Def.XMerging:=XParam.XMerging;
          Def.XOrdered:=false;
          if not Def.XMerging and XMerging then
            Def.XMerging:=XMerging;
          Def.DataSetFilter:=DataSetFilter;
          Def.XLabelFieldName:=LabelFieldName;
        end;
      end;
    end;
  end;  
end;

procedure TSgtsBaseGraphIface.AutoChartTitles;
var
  Param: TSgtsBaseGraphAxisParam;
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

procedure TSgtsBaseGraphIface.BeforeShowForm(AForm: TSgtsForm);
begin
  inherited BeforeShowForm(AForm);
end;

procedure TSgtsBaseGraphIface.CreateAllSeriesByAxisParams;
var
  Param: TSgtsBaseGraphAxisParam;
begin
  if Assigned(RefreshIface) then begin
    ClearOtherDataSets;
    Param:=RefreshIface.BottomAxisParams.GetFirstCheck;
    if Assigned(Param) then begin
      CreateSeriesByAxisParams(RefreshIface.LeftAxisParams,atLeftBottom,Param,false);
      CreateSeriesByAxisParams(RefreshIface.RightAxisParams,atRightBottom,Param,false);
    end;
  end;
end;

procedure TSgtsBaseGraphIface.CreateDataSetFilters;
begin
end;

procedure TSgtsBaseGraphIface.CloseDataSets;
begin
  if Assigned(Form) then begin
    Form.PanelView.Font.Style:=Form.PanelView.Font.Style+[fsBold];
    Form.ScrollBox.Visible:=false;
    Form.UpdateStatusbar;
  end;
  inherited CloseDataSets;
  SeriesDefs.Clear;
  DataSets.ClearSelectDefs;
end;

procedure TSgtsBaseGraphIface.OpenDataSets;
begin
  AutoChartTitles;
  CreateAllSeriesByAxisParams;
  CreateDataSetFilters;
  inherited OpenDataSets;
  if Assigned(Form) then begin
    Form.ScrollBox.Visible:=true;
    Form.PanelView.Font.Style:=Form.PanelView.Font.Style-[fsBold];
  end;
end;

{ TSgtsBaseGraphForm }

constructor TSgtsBaseGraphForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;

destructor TSgtsBaseGraphForm.Destroy;
begin
  inherited Destroy;
end;

procedure TSgtsBaseGraphForm.InitByIface(AIface: TSgtsFormIface);
var
  S: String;
begin
  inherited InitByIface(AIface);
  S:=ChartComponent.GetStr;
  S:=Iface.ReadParam(SConfigParamChartComponent,S,cmBase64);
  ChartComponent.SetStr(S);
  ResetChartState;
end;

procedure TSgtsBaseGraphForm.FormCloseQuery(Sender: TObject;
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
