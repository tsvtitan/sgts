
{******************************************}
{                                          }
{             FastReport v4.0              }
{               Chart RTTI                 }
{                                          }
{         Copyright (c) 1998-2007          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxChartRTTI;

interface

{$I frx.inc}

implementation

uses
  Windows, Classes, SysUtils, Forms, fs_iinterpreter, frxChart, fs_ichartrtti
{$IFDEF Delphi6}
, Variants
{$ENDIF};
  

type
  TFunctions = class(TfsRTTIModule)
  private
    function CallMethod(Instance: TObject; ClassType: TClass;
      const MethodName: String; Caller: TfsMethodHelper): Variant;
    function GetProp(Instance: TObject; ClassType: TClass;
      const PropName: String): Variant;
  public
    constructor Create(AScript: TfsScript); override;
  end;


{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do
  begin
    AddEnum('TfrxSeriesDataType', 'dtDBData, dtBandData, dtFixedData');
    AddClass(TfrxSeriesItem, 'TPersistent');
    with AddClass(TfrxSeriesData, 'TPersistent') do
    begin
      AddMethod('function Add: TfrxSeriesItem', CallMethod);
      AddDefaultProperty('Items', 'Integer', 'TfrxSeriesItem', CallMethod, True);
      // by TSV
      AddMethod('procedure Clear', CallMethod);
    end;
    with AddClass(TfrxChartView, 'TfrxView') do
    begin
      AddProperty('Chart', 'TChart', GetProp, nil);
      AddIndexProperty('Series', 'Integer', 'TChartSeries', CallMethod, True);
      AddProperty('SeriesData', 'TfrxSeriesData', GetProp, nil);
      // by TVS
      AddMethod('procedure ClearSeries',CallMethod);
      AddType('TfrxChartSeries',fvtInt);
      AddConst('csLine','TfrxChartSeries',csLine);
      AddConst('csPoint','TfrxChartSeries',csPoint);


{, csArea, csPoint, csBar, csHorizBar,
    csPie, csGantt, csFastLine, csArrow, csBubble, csChartShape, csHorizArea,
    csHorizLine, csPolar, csRadar, csPolarBar, csGauge, csSmith, csPyramid,
    csDonut, csBezier, csCandle, csVolume, csPointFigure, csHistogram,
    csHorizHistogram, csErrorBar, csError, csHighLow, csFunnel, csBox,
    csHorizBox, csSurface, csContour, csWaterFall, csColorGrid, csVector3D,
    csTower, csTriSurface, csPoint3D, csBubble3D, csMyPoint, csBarJoin, csBar3D}
    
      AddMethod('procedure AddSeries(Series: TfrxChartSeries)',CallMethod);

      AddType('TfrxSeriesSortOrder',fvtInt);
      AddConst('soNone','TfrxSeriesSortOrder',soNone);
      AddConst('soAscending','TfrxSeriesSortOrder',soAscending);
      AddConst('soDescending','TfrxSeriesSortOrder',soDescending);

      AddType('TfrxSeriesXType',fvtInt);
      AddConst('xtText','TfrxSeriesXType',xtText);
      AddConst('xtNumber','TfrxSeriesXType',xtNumber);
      AddConst('xtDate','TfrxSeriesXType',xtDate);

    end;
  end;
end;

function TFunctions.CallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; Caller: TfsMethodHelper): Variant;
var
  Series: TfrxChartSeries;
begin
  Result := 0;

  if ClassType = TfrxSeriesData then
  begin
    if MethodName = 'ADD' then  begin
      Result := Integer(TfrxSeriesData(Instance).Add);
    end else if MethodName = 'ITEMS.GET' then
      Result := Integer(TfrxSeriesData(Instance).Items[Caller.Params[0]])
    // by TSV
    else If MethodName='CLEAR' then begin
      TfrxSeriesData(Instance).Clear;
    end;
  end
  else if ClassType = TfrxChartView then
  begin
    if MethodName = 'SERIES.GET' then
      Result := Integer(TfrxChartView(Instance).Chart.Series[Caller.Params[0]])
    // by TSV
    else if MethodName = 'CLEARSERIES' then
      TfrxChartView(Instance).ClearSeries
    else if MethodName = 'ADDSERIES' then begin
      Series:=TfrxChartSeries(Integer(Caller.Params[0]));
      TfrxChartView(Instance).AddSeries(Series);
    end;  
  end;
end;

function TFunctions.GetProp(Instance: TObject; ClassType: TClass;
  const PropName: String): Variant;
begin
  Result := 0;

  if ClassType = TfrxChartView then
  begin
    if PropName = 'CHART' then
      Result := Integer(TfrxChartView(Instance).Chart)
    else if PropName = 'SERIESDATA' then
      Result := Integer(TfrxChartView(Instance).SeriesData)
  end
end;


initialization
  fsRTTIModules.Add(TFunctions);

finalization
  if fsRTTIModules <> nil then
    fsRTTIModules.Remove(TFunctions);

end.


//c6320e911414fd32c7660fd434e23c87