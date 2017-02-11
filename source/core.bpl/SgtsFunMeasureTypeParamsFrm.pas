unit SgtsFunMeasureTypeParamsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, ImgList, Grids, DBGrids,
  ExtCtrls, ComCtrls, ToolWin,
  SgtsDataGridMoveFrm;

type
  TSgtsFunMeasureTypeParamsFrame = class(TSgtsDataGridMoveFrame)
  private
    procedure Reorder;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MoveUp; override;
    procedure MoveDown; override;
  end;

var
  SgtsFunMeasureTypeParamsFrame: TSgtsFunMeasureTypeParamsFrame;

implementation

uses SgtsDialogs, SgtsConsts, SgtsUtils, SgtsProviderConsts,
     SgtsGetRecordsConfig, SgtsFunMeasureTypeParamIfaces, SgtsDataGridFrm,
     SgtsCoreIntf, SgtsDatabaseCDS, SgtsExecuteDefs;

{$R *.dfm}

{ TSgtsFunMeasureTypeParamsFrame }

constructor TSgtsFunMeasureTypeParamsFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InsertClass:=TSgtsFunMeasureTypeParamInsertIface;
  UpdateClass:=TSgtsFunMeasureTypeParamUpdateIface;
  DeleteClass:=TSgtsFunMeasureTypeParamDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectMeasureTypeParams;
    with SelectDefs do begin
      Add('PARAM_NAME','Параметр',180);
      AddInvisible('PARAM_ID');
      AddInvisible('PARAM_TYPE');
      AddInvisible('PARAM_DESCRIPTION');
      AddInvisible('ALGORITHM_ID');
      AddInvisible('ALGORITHM_NAME');
      AddInvisible('MEASURE_TYPE_ID');
      AddInvisible('MEASURE_TYPE_NAME');
      AddInvisible('PARAM_FORMAT');
      AddInvisible('PRIORITY');
    end;
    Orders.Add('PRIORITY',otAsc);
  end;
end;

destructor TSgtsFunMeasureTypeParamsFrame.Destroy;
begin
  inherited Destroy;
end;

procedure TSgtsFunMeasureTypeParamsFrame.MoveUp;
begin
  inherited MoveUp;
  if CanMoveUp then begin
    Reorder;
  end;
end;

procedure TSgtsFunMeasureTypeParamsFrame.MoveDown;
begin
  inherited MoveDown;
  if CanMoveDown then begin
    Reorder;
  end;
end;

procedure TSgtsFunMeasureTypeParamsFrame.Reorder;
var
  DS: TSgtsDatabaseCDS;
  NewPriority: Integer;
  OldCursor: TCursor;
begin
  OldCursor:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  DS:=TSgtsDatabaseCDS.Create(CoreIntf);
  DataSet.BeginUpdate(true);
  CoreIntf.MainForm.Progress(0,0,0);
  try
    DS.ProviderName:=SProviderUpdateMeasureTypeParam;
    DS.StopException:=true;
    with DS.ExecuteDefs do begin
      AddKeyLink('MEASURE_TYPE_ID');
      AddKeyLink('PARAM_ID');
      AddInvisible('PRIORITY');
    end;

    NewPriority:=1;
    DataSet.First;
    while not DataSet.Eof do begin
      with DS.ExecuteDefs do begin
        FirstState;
        Find('MEASURE_TYPE_ID').Value:=DataSet.FieldByName('MEASURE_TYPE_ID').Value;
        Find('PARAM_ID').Value:=DataSet.FieldByName('PARAM_ID').Value;
        Find('PRIORITY').Value:=NewPriority;
      end;
      DS.Execute;
      if DS.ExecuteSuccess then begin
        DataSet.Edit;
        DataSet.FieldByName('PRIORITY').Value:=NewPriority;
        DataSet.Post;
      end;
      CoreIntf.MainForm.Progress(0,DataSet.RecordCount,NewPriority);
      DataSet.Next;
      Inc(NewPriority);
    end;
    
  finally
    CoreIntf.MainForm.Progress(0,0,0);
    DataSet.EndUpdate(true);
    DS.Free;
    Screen.Cursor:=OldCursor;
  end;
end;

end.
