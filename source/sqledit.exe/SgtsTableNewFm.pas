unit SgtsTableNewFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, DBGrids, Grids,
  SgtsCDS, SgtsDBGrid;

type
  TSgtsTableNewForm = class(TForm)
    PanelButton: TPanel;
    PanelGrid: TPanel;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    DataSource: TDataSource;
    ButtonSave: TButton;
    ButtonLoad: TButton;
    DBGrid: TDBGrid;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ButtonClear: TButton;
    procedure ButtonLoadClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
  private
    FGrid: TSgtsDBGrid;
    FIndexDataType: Integer;
    FDefaultDataSet: TSgtsCDS;
    FOriginalDataSet: TSgtsCDS;
    procedure CreateDataSetByOriginal;
    procedure FillDataTypes(PickList: TStrings);
    procedure FieldDataTypeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure FieldDataTypeSetText(Sender: TField; const Text: string);
  public
    constructor Create(ADataSet: TSgtsCDS); reintroduce;
    destructor Destroy; override;
  end;

var
  SgtsTableNewForm: TSgtsTableNewForm;

implementation

uses TypInfo, Consts, 
     SgtsUtils, DBClient;

{$R *.dfm}

resourcestring
  SFieldNameName='NAME';
  SFieldNameWidth='WIDTH';
  SFieldNameDataType='DATA_TYPE';
  SFieldNameSize='SIZE';
  SFieldNamePrecision='PRECISION';
  SFieldNameDescription='DESCRIPTION';


{ TSgtsTableNewForm }

constructor TSgtsTableNewForm.Create(ADataSet: TSgtsCDS);
begin
  inherited Create(nil);
  FOriginalDataSet:=ADataSet;
  FDefaultDataSet:=TSgtsCDS.Create(nil);
  with FDefaultDataSet do begin
    FieldDefs.Add(SFieldNameName,ftString,100);
    FieldDefs.Add(SFieldNameWidth,ftInteger);
    FieldDefs.Add(SFieldNameDataType,ftInteger);
    FieldDefs.Add(SFieldNameSize,ftInteger);
    FieldDefs.Add(SFieldNamePrecision,ftInteger);
    FieldDefs.Add(SFieldNameDescription,ftString,250);
    CreateDataSet;
    with FDefaultDataSet do begin
      FieldByName(SFieldNameDataType).OnGetText:=FieldDataTypeGetText;
      FieldByName(SFieldNameDataType).OnSetText:=FieldDataTypeSetText;
      FieldByName(SFieldNameDataType).Alignment:=taLeftJustify;
    end;
  end;
  DataSource.DataSet:=FDefaultDataSet;
  FIndexDataType:=2;

  FGrid:=TSgtsDbGrid.Create(Self);
  with FGrid do begin
    Align:=alClient;
    Parent:=PanelGrid;
    ColumnSortEnabled:=false;
    VisibleRowNumber:=true;
    DataSource:=Self.DataSource;
    Options:=Options+[dgEditing];
    ReadOnly:=false;
  end;
  FGrid.Columns.Assign(DBGrid.Columns);
  DBGrid.Free;
  DBGrid:=nil;

  FillDataTypes(FGrid.Columns.Items[FIndexDataType].PickList);
  CreateDataSetByOriginal;
end;

destructor TSgtsTableNewForm.Destroy;
begin
  FDefaultDataSet.Free;
  inherited Destroy;
end;

procedure TSgtsTableNewForm.FillDataTypes(PickList: TStrings);
var
  i: Integer;
  PInfo: PTypeInfo;
  PData: PTypeData;
begin
  PickList.BeginUpdate;
  try
    PickList.Clear;
    PData:=nil;
    PInfo:=TypeInfo(TFieldType);
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

procedure TSgtsTableNewForm.FieldDataTypeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsInteger in [0..FGrid.Columns.Items[FIndexDataType].PickList.Count-1] then
    Text:=FGrid.Columns.Items[FIndexDataType].PickList[Sender.AsInteger];
end;

procedure TSgtsTableNewForm.FieldDataTypeSetText(Sender: TField; const Text: string);
var
  Index: Integer;
begin
  Index:=FGrid.Columns.Items[FIndexDataType].PickList.IndexOf(Text);
  if Index in [0..FGrid.Columns.Items[FIndexDataType].PickList.Count-1] then
    Sender.AsInteger:=Index;
end;

procedure TSgtsTableNewForm.CreateDataSetByOriginal;
var
  B: TBookmark;
  I: Integer;
  Field: TField;
begin
  if Assigned(FOriginalDataSet) and FOriginalDataSet.Active then begin
    FOriginalDataSet.DisableControls;
    B:=FOriginalDataSet.GetBookmark;
    try
      FDefaultDataSet.EmptyDataSet;
      for i:=0 to FOriginalDataSet.FieldCount-1 do begin
        Field:=FOriginalDataSet.Fields[i];
        with FDefaultDataSet do begin
          Append;
          FieldByName(SFieldNameName).Value:=Field.FieldName;
          FieldByName(SFieldNameDataType).Value:=Field.DataType;
          FieldByName(SFieldNameSize).Value:=iff(Field.Size>0,Field.Size,NULL);
          FieldByName(SFieldNamePrecision).Value:=iff(FOriginalDataSet.FieldDefs.Items[i].Precision>0,
                                                      FOriginalDataSet.FieldDefs.Items[i].Precision,
                                                      NULL);
          FieldByName(SFieldNameDescription).Value:=Field.DisplayLabel;
          FieldByName(SFieldNameWidth).Value:=Field.DisplayWidth;
          Post;
          First;
        end;
      end;
    finally
      if Assigned(B) and FOriginalDataSet.BookmarkValid(B) then
        FOriginalDataSet.GotoBookmark(B);
      FOriginalDataSet.EnableControls;
    end;
  end;
end;

procedure TSgtsTableNewForm.ButtonLoadClick(Sender: TObject);
begin
  if OpenDialog.Execute then begin
    FDefaultDataSet.LoadFromFile(OpenDialog.FileName);
    with FDefaultDataSet do begin
      FieldByName(SFieldNameDataType).OnGetText:=FieldDataTypeGetText;
      FieldByName(SFieldNameDataType).OnSetText:=FieldDataTypeSetText;
      FieldByName(SFieldNameDataType).Alignment:=taLeftJustify;
    end;  
  end;
end;

procedure TSgtsTableNewForm.ButtonSaveClick(Sender: TObject);
begin
  if SaveDialog.Execute then begin
    if FDefaultDataSet.State in [dsEdit, dsInsert] then
      FDefaultDataSet.Post;
    FDefaultDataSet.MergeChangeLog;  
    FDefaultDataSet.SaveToFile(SaveDialog.FileName,dfXMLUTF8);
  end;
end;

procedure TSgtsTableNewForm.ButtonClearClick(Sender: TObject);
begin
  FDefaultDataSet.EmptyDataSet;
end;

procedure TSgtsTableNewForm.ButtonOkClick(Sender: TObject);
var
  B: TBookmark;
  DataType: TFieldType;
  Field: TField;
  FieldDef: TFieldDef;
  OldDataSet: TSgtsCDS;
begin
  if Assigned(FOriginalDataSet) and FDefaultDataSet.Active then begin
    OldDataSet:=TSgtsCDS.Create(nil);
    if FOriginalDataSet.Active then begin
      OldDataSet.Data:=FOriginalDataSet.Data;
    end;  
    FOriginalDataSet.Close;
    FOriginalDataSet.FieldDefs.Clear;
    FDefaultDataSet.DisableControls;
    B:=FDefaultDataSet.GetBookmark;
    try
      FDefaultDataSet.First;
      while not FDefaultDataSet.Eof do begin
        DataType:=TFieldType(FDefaultDataSet.FieldByName(SFieldNameDataType).AsInteger);
        if DataType in [ftUnknown..ftFMTBcd] then begin
          with FOriginalDataSet do begin
            FieldDef:=FieldDefs.AddFieldDef;
            FieldDef.Name:=FDefaultDataSet.FieldByName(SFieldNameName).AsString;
            FieldDef.DataType:=DataType;
            FieldDef.Size:=FDefaultDataSet.FieldByName(SFieldNameSize).AsInteger;
            FieldDef.Precision:=FDefaultDataSet.FieldByName(SFieldNamePrecision).AsInteger;
          end;
        end;
        FDefaultDataSet.Next;
      end;
      FOriginalDataSet.CreateDataSet;
      FDefaultDataSet.First;
      while not FDefaultDataSet.Eof do begin
        Field:=FOriginalDataSet.FindField(FDefaultDataSet.FieldByName(SFieldNameName).AsString);
        if Assigned(Field) then begin
          Field.DisplayLabel:=FDefaultDataSet.FieldByName(SFieldNameDescription).AsString;
          Field.DisplayWidth:=FDefaultDataSet.FieldByName(SFieldNameWidth).AsInteger;
        end;
        FDefaultDataSet.Next;
      end;
      if OldDataSet.Active then begin
      //  FOriginalDataSet.CloneCursor(OldDataSet,false,true);
      end;
      FOriginalDataSet.Open;
      ModalResult:=mrOk;
    finally
      if Assigned(B) and FDefaultDataSet.BookmarkValid(B) then
        FDefaultDataSet.GotoBookmark(B);
      FDefaultDataSet.EnableControls;
      OldDataSet.Free;
    end;
  end;
end;

end.
