
{******************************************}
{                                          }
{             FastScript v1.9              }
{                  Chart                   }
{                                          }
{  (c) 2003-2007 by Alexander Tzyganenko,  }
{             Fast Reports Inc             }
{                                          }
{******************************************}

unit fs_ichartrtti;

interface

{$i fs.inc}

uses
  SysUtils, Classes, fs_iinterpreter, fs_itools, fs_iformsrtti, Chart,
  Series, TeEngine, TeeProcs, TeCanvas;


type
  TfsChartRTTI = class(TComponent); // fake component


implementation

uses Graphics;

type
  TFunctions = class(TfsRTTIModule)
  private
    function CallMethod(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TLineSeries_GetLinePen(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    function TChartPen_GetWidth(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TChartPen_SetWidth(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);

  public
    constructor Create(AScript: TfsScript); override;
  end;


{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do
  begin
    AddType('TChartValue', fvtFloat);
    AddEnum('TLegendStyle', 'lsAuto, lsSeries, lsValues, lsLastValues');
    AddEnum('TLegendAlignment', 'laLeft, laRight, laTop, laBottom');
    AddEnum('TLegendTextStyle', 'ltsPlain, ltsLeftValue, ltsRightValue, ltsLeftPercent,' +
      'ltsRightPercent, ltsXValue');
    AddEnum('TChartListOrder', 'loNone, loAscending, loDescending');
    AddEnum('TGradientDirection', 'gdTopBottom, gdBottomTop, gdLeftRight, gdRightLeft');
    AddEnum('TSeriesMarksStyle', 'smsValue, smsPercent, smsLabel, smsLabelPercent, ' +
      'smsLabelValue, smsLegend, smsPercentTotal, smsLabelPercentTotal, smsXValue');
    AddEnum('TAxisLabelStyle', 'talAuto, talNone, talValue, talMark, talText');
    AddEnum('THorizAxis', 'aTopAxis, aBottomAxis');
    AddEnum('TVertAxis', 'aLeftAxis, aRightAxis');
    AddEnum('TTeeBackImageMode', 'pbmStretch, pbmTile, pbmCenter');
    AddEnum('TPanningMode', 'pmNone, pmHorizontal, pmVertical, pmBoth');
    AddEnum('TSeriesPointerStyle', 'psRectangle, psCircle, psTriangle, ' +
      'psDownTriangle, psCross, psDiagCross, psStar, psDiamond, psSmallDot');
    AddEnum('TMultiArea', 'maNone, maStacked, maStacked100');
    AddEnum('TMultiBar', 'mbNone, mbSide, mbStacked, mbStacked100');
    AddEnum('TBarStyle', 'bsRectangle, bsPyramid, bsInvPyramid, bsCilinder, ' +
      'bsEllipse, bsArrow, bsRectGradient');

    AddClass(TChartValueList, 'TPersistent');
    AddClass(TChartAxisTitle, 'TPersistent');
    AddClass(TChartAxis, 'TPersistent');
    AddClass(TCustomChartLegend, 'TPersistent');
    AddClass(TChartLegend, 'TCustomChartLegend');
    AddClass(TSeriesMarks, 'TPersistent');
    AddClass(TChartGradient, 'TPersistent');
    AddClass(TChartWall, 'TPersistent');
    AddClass(TChartBrush, 'TBrush');
    AddClass(TChartTitle, 'TPersistent');
    AddClass(TView3DOptions, 'TPersistent');
    with AddClass(TChartSeries, 'TComponent') do   begin
      AddMethod('procedure Clear', CallMethod);
      AddMethod('procedure Add(const AValue: Double; const ALabel: String; AColor: TColor)', CallMethod);
    end;
    AddClass(TSeriesPointer, 'TPersistent');
    AddClass(TCustomSeries, 'TChartSeries');
    with AddClass(TChartPen,'TChartPen') do begin
      AddProperty('Width','Integer',TChartPen_GetWidth,TChartPen_SetWidth);
    end;
    with AddClass(TLineSeries, 'TCustomSeries') do begin
      // by TSV
      AddProperty('LinePen','TChartPen',TLineSeries_GetLinePen,nil);
    end;
    AddClass(TPointSeries, 'TCustomSeries');
    AddClass(TAreaSeries, 'TCustomSeries');
    AddClass(TCustomBarSeries, 'TChartSeries');
    AddClass(TBarSeries, 'TCustomBarSeries');
    AddClass(THorizBarSeries, 'TCustomBarSeries');
    AddClass(TCircledSeries, 'TChartSeries');
    AddClass(TPieSeries, 'TCircledSeries');
    AddClass(TFastLineSeries, 'TChartSeries');
    AddClass(TCustomChart, 'TWinControl');
    AddClass(TChart, 'TCustomChart');
  end;
end;

function TFunctions.CallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result := 0;

  if ClassType = TChartSeries then
  begin
    if MethodName = 'CLEAR' then
      TChartSeries(Instance).Clear
    else if MethodName = 'ADD' then
      TChartSeries(Instance).Add(Caller.Params[0], Caller.Params[1], Caller.Params[2])
  end
end;

function TFunctions.TLineSeries_GetLinePen(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result:=0;
  if AnsiSameText(PropName,'LinePen') then begin
    Result:=Integer(TLineSeries(Instance).LinePen);
  end;
end;

function TFunctions.TChartPen_GetWidth(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := '';
  if AnsiSameText(PropName,'Width') then begin
    Result:=TChartPen(Instance).Width;
  end;
end;

procedure TFunctions.TChartPen_SetWidth(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'Width') then begin
    TChartPen(Instance).Width:=Value;
  end;
end;

initialization
  fsRTTIModules.Add(TFunctions);

finalization
  if fsRTTIModules <> nil then
    fsRTTIModules.Remove(TFunctions);

end.