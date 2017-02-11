unit SgtsBaseFieldNamesFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DBCtrls, DB,
  SgtsGetRecordsConfig, SgtsDbGrid, SgtsCDS, SgtsSelectDefs;

type
  TSgtsBaseFieldNamesForm = class(TForm)
    PanelButton: TPanel;
    ButtonCancel: TButton;
    ButtonOk: TButton;
    PanelGrid: TPanel;
    GridPattern: TDBGrid;
    DBNavigator: TDBNavigator;
    Bevel: TBevel;
    DataSource: TDataSource;
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FGrid: TSgtsDbGrid;
    FDataSet: TSgtsCDS;
    FSelectDefs: TSgtsSelectDefs;
    FFieldNames: TSgtsGetRecordsConfigFieldNames;
    procedure FillTypes(PickList: TStrings);
    procedure FieldTypeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure FieldTypeSetText(Sender: TField; const Text: string);
    procedure GetFieldNames;
    procedure FillFieldNames;
    procedure SetFieldNames(Value: TSgtsGetRecordsConfigFieldNames);
  public
    property FieldNames: TSgtsGetRecordsConfigFieldNames read FFieldNames write SetFieldNames;
  end;

var
  SgtsBaseFieldNamesForm: TSgtsBaseFieldNamesForm;

implementation

uses TypInfo, Consts, DBClient,
     SgtsUtils;

{$R *.dfm}

{ TSgtsBaseFieldNamesForm }

procedure TSgtsBaseFieldNamesForm.FormCreate(Sender: TObject);
begin
  FGrid:=TSgtsDbGrid.Create(Self);
  with FGrid do begin
    Parent:=GridPattern.Parent;
    Align:=GridPattern.Align;
    Font.Assign(GridPattern.Font);
    LocateEnabled:=false;
    ColumnSortEnabled:=false;
    Options:=Options-[dgTabs]+[dgEditing];
    ColMoving:=false;
    AutoFit:=false;
    VisibleRowNumber:=true;
    ReadOnly:=false;
    DataSource:=GridPattern.DataSource;
  end;

  GridPattern.Free;
  GridPattern:=nil;

  FDataSet:=TSgtsCDS.Create(nil);
  with FDataSet.FieldDefs do begin
    Add('NAME',ftString,100);
    Add('TYPE',ftInteger);
  end;
  FDataSet.CreateDataSet;
  with FDataSet.Fields[1] do begin
    OnGetText:=FieldTypeGetText;
    OnSetText:=FieldTypeSetText;
    Alignment:=taLeftJustify;
  end;

  DataSource.DataSet:=FDataSet;

  FSelectDefs:=TSgtsSelectDefs.Create;
  FSelectDefs.Add('NAME','Имя поля',220);
  FSelectDefs.Add('TYPE','Тип функции',60);

  CreateGridColumnsBySelectDefs(FGrid,FSelectDefs);

  FillTypes(FGrid.Columns.Items[1].PickList);
end;

procedure TSgtsBaseFieldNamesForm.FormDestroy(Sender: TObject);
begin
  FSelectDefs.Free;
  FDataSet.Free;
end;

procedure TSgtsBaseFieldNamesForm.FillTypes(PickList: TStrings);
var
  i: Integer;
  PInfo: PTypeInfo;
  PData: PTypeData;
begin
  PickList.BeginUpdate;
  try
    PickList.Clear;
    PData:=nil;
    PInfo:=TypeInfo(TSgtsGetRecordsConfigFieldNameFuncType);
    if Assigned(PInfo) then
      PData:=GetTypeData(PInfo);
    if Assigned(PData) then
      for i:=PData.MinValue to PData.MaxValue do begin
        PickList.Add(GetEnumName(PInfo,i));
      end;
  finally
    PickList.EndUpdate;
  end;
end;

procedure TSgtsBaseFieldNamesForm.FieldTypeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsInteger in [0..FGrid.Columns.Items[1].PickList.Count-1] then
    Text:=FGrid.Columns.Items[1].PickList[Sender.AsInteger];
end;

procedure TSgtsBaseFieldNamesForm.FieldTypeSetText(Sender: TField; const Text: string);
var
  Index: Integer;
begin
  Index:=FGrid.Columns.Items[1].PickList.IndexOf(Text);
  if Index in [0..FGrid.Columns.Items[1].PickList.Count-1] then
    Sender.AsInteger:=Index;
end;


procedure TSgtsBaseFieldNamesForm.SetFieldNames(Value: TSgtsGetRecordsConfigFieldNames);
begin
  FFieldNames:=Value;
  FillFieldNames;
end;

procedure TSgtsBaseFieldNamesForm.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TSgtsBaseFieldNamesForm.ButtonOkClick(Sender: TObject);
begin
  GetFieldNames;
  ModalResult:=mrOk;
end;

procedure TSgtsBaseFieldNamesForm.GetFieldNames;
begin
  if Assigned(FFieldNames) then begin
    FFieldNames.Clear;
    FDataSet.BeginUpdate;
    try
      FDataSet.First;
      while not FDataSet.Eof do begin
        FFieldNames.Add(FDataSet.FieldByName('NAME').AsString,
                        TSgtsGetRecordsConfigFieldNameFuncType(FDataSet.FieldByName('TYPE').AsInteger));
        FDataSet.Next;
      end;
    finally
      FDataSet.EndUpdate;
    end;
  end;
end;

procedure TSgtsBaseFieldNamesForm.FillFieldNames;
var
  i: Integer;
  Item: TSgtsGetRecordsConfigFieldName;
begin
  if Assigned(FFieldNames) then begin
    FDataSet.BeginUpdate;
    try
      FDataSet.EmptyDataSet;
      for i:=0 to FFieldNames.Count-1 do begin
        Item:=FFieldNames.Items[i];
        FDataSet.Append;
        FDataSet.FieldByName('NAME').AsString:=Item.Name;
        FDataSet.FieldByName('TYPE').AsInteger:=Integer(Item.FuncType);
        FDataSet.Post;
      end;
      FDataSet.First;
    finally
      FDataSet.EndUpdate;
    end;
  end;
end;

end.
