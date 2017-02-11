unit SgtsFunMeasureTypeAlgorithmsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, ImgList, Grids, DBGrids,
  ExtCtrls, ComCtrls, ToolWin,
  SgtsDataGridMoveFrm;

type
  TSgtsFunMeasureTypeAlgorithmsFrame = class(TSgtsDataGridMoveFrame)
  private
    procedure Reorder;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MoveUp; override;
    procedure MoveDown; override;
  end;

var
  SgtsFunMeasureTypeAlgorithmsFrame: TSgtsFunMeasureTypeAlgorithmsFrame;

implementation

uses SgtsDialogs, SgtsConsts, SgtsUtils, SgtsProviderConsts,
     SgtsGetRecordsConfig, SgtsFunMeasureTypeAlgorithmIfaces, SgtsDataGridFrm,
     SgtsCoreIntf, SgtsDatabaseCDS, SgtsExecuteDefs;

{$R *.dfm}

{ TSgtsFunMeasureTypeAlgorithmsFrame }

constructor TSgtsFunMeasureTypeAlgorithmsFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InsertClass:=TSgtsFunMeasureTypeAlgorithmInsertIface;
  UpdateClass:=TSgtsFunMeasureTypeAlgorithmUpdateIface;
  DeleteClass:=TSgtsFunMeasureTypeAlgorithmDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectMeasureTypeAlgorithms;
    with SelectDefs do begin
      Add('ALGORITHM_NAME','Алгоритм',180);
      Add('DATE_BEGIN','Дата начала',70);
      Add('DATE_END','Дата окончания',70);
      AddInvisible('ALGORITHM_ID');
      AddInvisible('MEASURE_TYPE_ID');
      AddInvisible('MEASURE_TYPE_NAME');
      AddInvisible('DATE_BEGIN');
      AddInvisible('DATE_END');
      AddInvisible('PRIORITY');
    end;
    Orders.Add('PRIORITY',otAsc);
  end;
end;

destructor TSgtsFunMeasureTypeAlgorithmsFrame.Destroy;
begin
  inherited Destroy;
end;

procedure TSgtsFunMeasureTypeAlgorithmsFrame.MoveUp;
begin
  inherited MoveUp;
  if CanMoveUp then begin
    Reorder;
  end;
end;

procedure TSgtsFunMeasureTypeAlgorithmsFrame.MoveDown;
begin
  inherited MoveDown;
  if CanMoveDown then begin
    Reorder;
  end;
end;

procedure TSgtsFunMeasureTypeAlgorithmsFrame.Reorder;
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
    DS.ProviderName:=SProviderUpdateMeasureTypeAlgorithm;
    DS.StopException:=true;
    with DS.ExecuteDefs do begin
      AddKeyLink('MEASURE_TYPE_ID');
      AddKeyLink('ALGORITHM_ID');
      AddInvisible('DATE_BEGIN');
      AddInvisible('DATE_END');
      AddInvisible('PRIORITY');
    end;

    NewPriority:=1;
    DataSet.First;
    while not DataSet.Eof do begin
      with DS.ExecuteDefs do begin
        FirstState;
        Find('MEASURE_TYPE_ID').Value:=DataSet.FieldByName('MEASURE_TYPE_ID').Value;
        Find('ALGORITHM_ID').Value:=DataSet.FieldByName('ALGORITHM_ID').Value;
        Find('DATE_BEGIN').Value:=DataSet.FieldByName('DATE_BEGIN').Value;
        Find('DATE_END').Value:=DataSet.FieldByName('DATE_END').Value;
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
