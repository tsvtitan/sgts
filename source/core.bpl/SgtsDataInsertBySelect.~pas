unit SgtsDataInsertBySelect;

interface

uses Contnrs,
     SgtsCDS, SgtsGetRecordsConfig,
     SgtsDataInsertFm, SgtsDataFm, SgtsFm, SgtsCoreIntf, SgtsDataIfaceIntf;

type
  TSgtsDataInsertBySelectIface=class(TSgtsDataInsertIface)
  private
    FSelectClass: TSgtsDataIfaceClass;
    FSelectFields: String;
    FSelectValues: Variant;
    FSelectFilterGroups: TSgtsGetRecordsConfigFilterGroups;
    FSelectMultiselect: Boolean;
    FSelectDataSet: TSgtsCDS;
  protected
    function GetFormClass: TSgtsFormClass; override;
    function SaveChanges: Boolean; override;
  public
    constructor Create(ACoreIntf: ISgtsCore; AIfaceIntf: ISgtsDataIface); override;
    destructor Destroy; override;
    procedure Show; override;
    procedure ShowModal; override;

    property SelectClass: TSgtsDataIfaceClass read FSelectClass write FSelectClass;
    property SelectFields: String read FSelectFields write FSelectFields;
    property SelectValues: Variant read FSelectValues write FSelectValues;
    property SelectFilterGroups: TSgtsGetRecordsConfigFilterGroups read FSelectFilterGroups;
    property SelectMultiselect: Boolean read FSelectMultiselect write FSelectMultiselect; 
    property SelectDataSet: TSgtsCDS read FSelectDataSet;
  end;

implementation

uses Controls, Forms;

{ TSgtsDataInsertBySelectIface }

constructor TSgtsDataInsertBySelectIface.Create(ACoreIntf: ISgtsCore; AIfaceIntf: ISgtsDataIface);
begin
  inherited Create(ACoreIntf,AIfaceIntf);
  FSelectFilterGroups:=TSgtsGetRecordsConfigFilterGroups.Create;
  FSelectDataSet:=TSgtsCDS.Create(nil);
end;

destructor TSgtsDataInsertBySelectIface.Destroy;
begin
  FSelectDataSet.Free;
  FSelectFilterGroups.Free;
  inherited Destroy;
end;

function TSgtsDataInsertBySelectIface.GetFormClass: TSgtsFormClass;
begin
  Result:=nil;
end;

function TSgtsDataInsertBySelectIface.SaveChanges: Boolean;
begin
  Result:=inherited SaveChanges;
end;

procedure TSgtsDataInsertBySelectIface.ShowModal; 
begin
  Show;
end;

procedure TSgtsDataInsertBySelectIface.Show;
var
  AIface: TSgtsDataIface;
  Data: String;
  OldCursor: TCursor;
  Position: Integer;
begin
  if Assigned(FSelectClass) then begin
    AIface:=FSelectClass.Create(CoreIntf);
    try
      if AIface.SelectVisible(FSelectFields,FSelectValues,Data,FSelectFilterGroups,FSelectMultiselect) then begin
        OldCursor:=Screen.Cursor;
        Screen.Cursor:=crHourGlass;
        CoreIntf.MainForm.Progress(0,0,0);
        try
          Position:=1;
          FSelectDataSet.XMLData:=Data;
          if FSelectDataSet.Active and not FSelectDataSet.IsEmpty then begin
            FSelectDataSet.First;
            while not FSelectDataSet.Eof do begin
              DataSet.GetExecuteDefsByDataSet(FSelectDataSet);
              InternalSetDefValues;
              SaveChanges;
              CoreIntf.MainForm.Progress(0,FSelectDataSet.RecordCount,Position);
              FSelectDataSet.Next;
              Inc(Position);
            end;
          end;
        finally
          CoreIntf.MainForm.Progress(0,0,0);
          Screen.Cursor:=OldCursor;
        end;  
      end;
    finally
      AIface.Free;
    end;
  end;
end;

end.
