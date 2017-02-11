unit SgtsSqlEditFm;

interface

uses
  Windows, Messages, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Gauges, DBCtrls, ExtCtrls, ComCtrls, DB, DbGrids,
  SgtsDbGrid, SgtsCDS, FMTBcd, SqlExpr, Menus,
  SgtsControls, XPMan, SgtsTableEditFrm, SgtsDatabaseIntf, Buttons;

type
  TSgtsSqlEditForm = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    EditDir: TEdit;
    ButtonDir: TButton;
    GroupBox1: TGroupBox;
    PanelScript: TPanel;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Panel2: TPanel;
    ButtonLoad: TButton;
    ButtonSave: TButton;
    OpenDialogScript: TOpenDialog;
    SaveDialogScript: TSaveDialog;
    DataSourceScript: TDataSource;
    ProgressBar: TProgressBar;
    Panel3: TPanel;
    MemoWordsFrom: TMemo;
    MemoWordsDelim: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    Panel4: TPanel;
    Button3: TButton;
    DBNavigator: TDBNavigator;
    ButtonClear: TButton;
    XPManifest: TXPManifest;
    Label5: TLabel;
    EditBegin: TEdit;
    Label6: TLabel;
    EditEnd: TEdit;
    PopupMenuLoad: TPopupMenu;
    Query1: TMenuItem;
    Result1: TMenuItem;
    PageControlValue: TPageControl;
    TabSheetQuery: TTabSheet;
    TabSheetTable: TTabSheet;
    MemoScript: TMemo;
    TabSheetUnknown: TTabSheet;
    btUpColumns: TBitBtn;
    btDownColumns: TBitBtn;
    Sql1: TMenuItem;
    TabSheetFile: TTabSheet;
    MemoFile: TMemo;
    TableEditFrame: TSgtsTableEditFrame;
    procedure ButtonDirClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonLoadClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure Query1Click(Sender: TObject);
    procedure Result1Click(Sender: TObject);
    procedure btUpColumnsClick(Sender: TObject);
    procedure btDownColumnsClick(Sender: TObject);
    procedure Sql1Click(Sender: TObject);
  private
    FGridScript: TSgtsDbGrid;
    FDataScript: TSgtsCDS;
    FIndexType: Integer;
    procedure GetDirFiles(Dir: String; FileDirs: TStringList; OnlyFiles, StopFirst: Boolean);
    procedure DataScriptAfterScroll(DataSet: TDataSet);
    procedure DataScriptBeforeScroll(DataSet: TDataSet);
    procedure DataScriptBeforePost(DataSet: TDataSet);
    procedure DataSetAfterPost(DataSet: TDataSet);
    procedure LoadFromResultFile(const FileName: String);
    procedure LoadFromQueryFile(const FileName: String);
    procedure LoadFromSqlFile(const FileName: String);
    procedure FillByStrings(Str: TStringList; const Description: String);
    function GetDescription(var Text: String; OldDesc: String): String;
    procedure FillTypes(PickList: TStrings);
    procedure FieldTypeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure FieldTypeSetText(Sender: TField; const Text: string);
  public
    procedure Run;
  end;

var
  SgtsSqlEditForm: TSgtsSqlEditForm;

implementation

uses rxFileUtil, SgtsUtils, SysUtils, DBClient, DateUtils, TypInfo,
     SgtsDialogs, SgtsConsts;

{$R *.dfm}


procedure TSgtsSqlEditForm.FormCreate(Sender: TObject);
begin
  FDataScript:=TSgtsCDS.Create(nil);
  with FDataScript do begin
    AfterScroll:=DataScriptAfterScroll;
    BeforeScroll:=DataScriptBeforeScroll;
    BeforePost:=DataScriptBeforePost;
    CreateQueDataSet;
  end;

  DataSourceScript.DataSet:=FDataScript;

  FGridScript:=TSgtsDbGrid.Create(nil);
  with FGridScript do begin
    Align:=alClient;
    Parent:=PanelScript;
    ColumnSortEnabled:=false;
    VisibleRowNumber:=true;
    DataSource:=DataSourceScript;
    Options:=Options+[dgEditing];
    ReadOnly:=false;
    with Columns.Add do begin
      FieldName:=SDb_Type;
      Title.Caption:='Тип';
      Width:=45;
      FIndexType:=0;
    end;
    with Columns.Add do begin
      FieldName:=SDb_Description;
      Title.Caption:='Описание';
      Width:=240;
    end;
  end;

  TableEditFrame.DataSet.AfterPost:=DataSetAfterPost;

  FillTypes(FGridScript.Columns.Items[FIndexType].PickList);

  with FDataScript do begin
    FieldByName(SDb_Type).OnGetText:=FieldTypeGetText;
    FieldByName(SDb_Type).OnSetText:=FieldTypeSetText;
    FieldByName(SDb_Type).Alignment:=taLeftJustify;
  end;
  
  PageControl.ActivePageIndex:=0;
  PageControlValue.ActivePageIndex:=0;
end;

procedure TSgtsSqlEditForm.FormDestroy(Sender: TObject);
begin
  FGridScript.Free;
  FDataScript.Free;
end;

procedure TSgtsSqlEditForm.ButtonDirClick(Sender: TObject);
var
  Dir: String;
begin
  Dir:=EditDir.Text;
  if BrowseDirectory(Dir,'',0) then
    EditDir.Text:=Dir;
end;

procedure TSgtsSqlEditForm.Button3Click(Sender: TObject);
begin
  if (MemoWordsFrom.Lines.Count>0) and
     (MemoWordsDelim.Lines.Count>0) then begin
    Run;
    PageControl.ActivePageIndex:=1;
  end;  
end;

procedure TSgtsSqlEditForm.GetDirFiles(Dir: String; FileDirs: TStringList; OnlyFiles, StopFirst: Boolean);
var
  AttrWord: Word;
  FMask: String;
  MaskPtr: PChar;
  Ptr: Pchar;
  FileInfo: TSearchRec;
  S: string;
begin
  if StopFirst then begin
    if FileDirs.Count>0 then
      exit;
  end;
  if not DirectoryExists(Dir) then exit;
  AttrWord :=faAnyFile+faReadOnly+faHidden+faSysFile+faVolumeID+faDirectory+faArchive;
  if SetCurrentDirectory(Pchar(Dir)) then begin
    FMask:='*.*';
    MaskPtr := PChar(FMask);
    while MaskPtr <> nil do begin
      Ptr := StrScan (MaskPtr, ';');
      if Ptr <> nil then
        Ptr^ := #0;
      if FindFirst(MaskPtr, AttrWord, FileInfo) = 0 then begin
        repeat
          S:=Dir+'\'+FileInfo.Name;
          if (FileInfo.Attr and faDirectory <> 0) then begin
            if (FileInfo.Name<>'.') and (FileInfo.Name<>'..') and not OnlyFiles then begin
              with FileInfo.FindData do begin
                GetDirFiles(S,FileDirs,OnlyFiles,StopFirst);
                if not OnlyFiles then begin
                  FileDirs.Add(S);
                  if StopFirst then break;
                end;  
              end;
            end;
          end else begin
            with FileInfo.FindData do begin
              FileDirs.Add(S);
              if StopFirst then break;
            end;
          end;
        until FindNext(FileInfo) <> 0;
        FindClose(FileInfo);
      end;
      if Ptr <> nil then begin
        Ptr^ := ';';
        Inc (Ptr);
      end;
      MaskPtr := Ptr;
    end;
  end;
end;

function TSgtsSqlEditForm.GetDescription(var Text: String; OldDesc: String): String;
var
  Str: TStringList;
  Apos1,Apos2: Integer;
  S: String;
begin
  Result:=OldDesc;
  Str:=TStringList.Create;
  try
    Str.Text:=Text;
    if Str.Count>0 then begin
      Result:=iff(Trim(OldDesc)<>'',OldDesc,Str.Strings[0]);
      Str.Clear;
      Apos1:=-1;
      while Apos1<>0 do begin
        Apos1:=AnsiPos(EditBegin.Text,Text);
        if Apos1>0 then begin
          Text:=Copy(Text,Apos1+Length(EditBegin.Text),Length(Text));
          Apos2:=AnsiPos(EditEnd.Text,Text);
          if Apos2>0 then begin
            S:=Copy(Text,1,Apos2-1);
            Text:=Copy(Text,Apos2+Length(EditEnd.Text),Length(Text));
            if Trim(S)<>'' then begin
              Result:=Trim(S);
              exit;
            end;
          end;
        end;
      end;
    end;  
  finally
    Str.Free;
  end;
end;

procedure TSgtsSqlEditForm.FillByStrings(Str: TStringList; const Description: String);
var
  Text: string;
  j: Integer;
  AWord,ADesc: string;
  PosBegin, PosEnd, PosAppend: Integer;
  TempString,NewText: string;
  ChBack,ChNext: Char;
  IsAppend: Boolean;
  LastPos: Integer;
const
  GoodChars=[' ',#13,#10,#0];
begin
  ADesc:=Description;
  Text:=Trim(Str.Text);
  while true do begin
    ADesc:=GetDescription(Text,ADesc);
    LastPos:=Length(Text);
    for j:=0 to MemoWordsFrom.Lines.Count-1 do begin
      AWord:=MemoWordsFrom.Lines.Strings[j];
      PosBegin:=AnsiPos(AnsiUpperCase(AWord),AnsiUpperCase(Text));
      if PosBegin>0 then begin
        if LastPos>=PosBegin then
          LastPos:=PosBegin;
      end;
    end;
    PosBegin:=LastPos;
    if PosBegin>0 then begin
      Text:=Trim(Copy(Text,PosBegin,Length(Text)));
      PosAppend:=0;
      IsAppend:=false;
      NewText:=Text;
      while not IsAppend do begin
        for j:=0 to MemoWordsDelim.Lines.Count-1 do begin
          AWord:=MemoWordsDelim.Lines.Strings[j];
          PosEnd:=AnsiPos(AWord,NewText);
          if PosEnd>0 then begin
            ChBack:=NewText[PosEnd-1];
            ChNext:=NewText[PosEnd+Length(AWord)];
            if (ChBack in GoodChars) and (ChNext in GoodChars) then begin
              PosAppend:=PosAppend+PosEnd;
              IsAppend:=true;
              break;
            end else begin
              PosAppend:=PosAppend+PosEnd+Length(AWord)-1;
              NewText:=Copy(NewText,PosEnd+Length(AWord),Length(NewText));
            end;

          end;
        end;

        if not IsAppend then begin
          IsAppend:=true;
          PosAppend:=Length(NewText)+1;
        end;
      end;
      if IsAppend then begin
        TempString:=Trim(Copy(Text,1,PosAppend-1));
        Text:=Trim(Copy(Text,PosAppend+Length(AWord),Length(Text)));
        if Trim(TempString)<>'' then begin
          FDataScript.Append;
          FDataScript.FieldByName(SDb_Type).AsInteger:=Integer(itScript);
          FDataScript.FieldByName(SDb_Value).AsString:=TempString;
          FDataScript.FieldByName(SDb_Description).AsString:=ADesc;
          FDataScript.Post;
        end;
      end else begin
        if PosAppend>0 then begin
        end else break;
      end;
    end else break;
  end;
end;

procedure TSgtsSqlEditForm.LoadFromSqlFile(const FileName: String);
var
  Str: TStringList;
begin
  Str:=TStringList.Create;
  try
    Str.LoadFromFile(FileName);
    FillByStrings(Str,'');
  finally
    Str.Free;
  end;
end;

procedure TSgtsSqlEditForm.Run;
var
  FilesIn: TStringList;
  i: Integer;
  FileName: string;
begin
  FilesIn:=TStringList.Create;

  FDataScript.DisableControls;
  FDataScript.AfterScroll:=nil;
  FDataScript.BeforeScroll:=nil;
  FDataScript.BeforePost:=nil;
  try
    ProgressBar.Position:=0;
    MemoWordsFrom.Lines.Text:=Trim(MemoWordsFrom.Lines.Text);
    MemoWordsDelim.Lines.Text:=Trim(MemoWordsDelim.Lines.Text);
    GetDirFiles(EditDir.Text,FilesIn,false,false);
    FilesIn.Sort;
    ProgressBar.Max:=FilesIn.Count;
    FDataScript.EmptyDataSet;

    for i:=0 to FilesIn.Count-1 do begin
      FileName:=FilesIn.Strings[i];
      if FileExists(FileName) then begin
        LoadFromSqlFile(FileName);
      end;
      ProgressBar.Position:=i+1;
      Application.ProcessMessages;
    end;
  finally
    FDataScript.First;
    DataScriptAfterScroll(FDataScript);
    FDataScript.AfterScroll:=DataScriptAfterScroll;
    FDataScript.BeforeScroll:=DataScriptBeforeScroll;
    FDataScript.BeforePost:=DataScriptBeforePost;
    FDataScript.EnableControls;
    ProgressBar.Position:=0;
    FilesIn.Free;
  end;
end;

procedure TSgtsSqlEditForm.ButtonLoadClick(Sender: TObject);
var
  pt: TPoint;
begin
  pt:=Point(ButtonLoad.Left,ButtonLoad.Top+ButtonLoad.height);
  pt:=Panel2.ClientToScreen(pt);
  PopupMenuLoad.Popup(pt.X,pt.Y);
end;

procedure TSgtsSqlEditForm.ButtonSaveClick(Sender: TObject);
begin
  SaveDialogScript.FilterIndex:=1;
  if SaveDialogScript.Execute then begin
    DataScriptBeforeScroll(nil);
    FDataScript.MergeChangeLog;
    FDataScript.SaveToFile(SaveDialogScript.FileName,dfXMLUTF8);
  end;
end;

procedure TSgtsSqlEditForm.ButtonClearClick(Sender: TObject);
begin
  FDataScript.EmptyDataSet;
  MemoScript.Clear;
  TableEditFrame.DataSet.Close;
  PageControlValue.ActivePageIndex:=0;
end;

procedure TSgtsSqlEditForm.Query1Click(Sender: TObject);
begin
  OpenDialogScript.FilterIndex:=1;
  if OpenDialogScript.Execute then begin
    FDataScript.AfterScroll:=nil;
    FDataScript.BeforeScroll:=nil;
    FDataScript.BeforePost:=nil;
    try
      LoadFromQueryFile(OpenDialogScript.FileName);
      DataScriptAfterScroll(FDataScript);
    finally
      FDataScript.AfterScroll:=DataScriptAfterScroll;
      FDataScript.BeforeScroll:=DataScriptBeforeScroll;
      FDataScript.BeforePost:=DataScriptBeforePost;
    end;
  end;
end;

procedure TSgtsSqlEditForm.Result1Click(Sender: TObject);
begin
  OpenDialogScript.FilterIndex:=2;
  if OpenDialogScript.Execute then begin
    FDataScript.AfterScroll:=nil;
    FDataScript.BeforeScroll:=nil;
    FDataScript.BeforePost:=nil;
    try
      LoadFromResultFile(OpenDialogScript.FileName);
      DataScriptAfterScroll(FDataScript);
    finally
      FDataScript.AfterScroll:=DataScriptAfterScroll;
      FDataScript.BeforeScroll:=DataScriptBeforeScroll;
      FDataScript.BeforePost:=DataScriptBeforePost;
    end;
  end;
end;

procedure TSgtsSqlEditForm.LoadFromQueryFile(const FileName: String);
var
  DS: TSgtsCDS;
begin
  DS:=TSgtsCDS.Create(nil);
  FDataScript.Last;
  FDataScript.BeginUpdate(true);
  try
    DS.LoadFromFile(FileName);
    if DS.Active then begin
      DS.First;
      while not DS.Eof do begin
        FDataScript.FieldValuesBySource(DS);
        DS.Next;
      end;
    end;
  finally
    FDataScript.EndUpdate(false);
    FDataScript.Next;
    DS.Free;
  end;
end;

procedure TSgtsSqlEditForm.LoadFromResultFile(const FileName: String);
var
  DS: TSgtsCDS;
  AResult: String;
  ADesc: String;
  Str: TStringList;
  ExportType: TSgtsDatabaseExportType;
  Position: Integer;
  Files: TStringList;
  i: Integer;
begin
  DS:=TSgtsCDS.Create(nil);
  FDataScript.Last;
  FDataScript.BeginUpdate(true);
  Str:=TStringList.Create;
  ProgressBar.Position:=0;
  try
    DS.LoadFromFile(FileName);
    if DS.Active then begin
      Position:=1;
      ProgressBar.Max:=DS.RecordCount;
      DS.First;
      while not DS.Eof do begin
        AResult:=DS.FieldByName(SDb_Result).Value;
        ADesc:=DS.FieldByName(SDb_Description).Value;
        ExportType:=TSgtsDatabaseExportType(DS.FieldByName(SDb_Type).AsInteger);
        Str.Clear;
        case ExportType of
          etScript,etTableAsScript: begin
            Str.Add(AResult);
            FillByStrings(Str,ADesc);
          end;
          etTable: begin
            FDataScript.Append;
            FDataScript.FieldByName(SDb_Type).AsInteger:=Integer(itTable);
            FDataScript.FieldByName(SDb_Value).AsString:=AResult;
            FDataScript.FieldByName(SDb_Description).AsString:=ADesc;
            FDataScript.Post;
          end;
          etTableAsFiles: begin
            Files:=TStringList.Create;
            try
              Files.Text:=AResult;
              for i:=0 to Files.Count-2 do begin
                FDataScript.Append;
                FDataScript.FieldByName(SDb_Type).AsInteger:=Integer(itFile);
                FDataScript.FieldByName(SDb_Value).AsString:=Files.Strings[i];
                FDataScript.FieldByName(SDb_Description).AsString:=ADesc;
                FDataScript.Post;
              end;
            finally
              Files.Free;
            end;
          end;
        end;
        ProgressBar.Position:=Position+1;
        Application.ProcessMessages;
        DS.Next;
        Inc(Position);
      end;
    end;
  finally
    ProgressBar.Position:=0;
    Str.Free;
    FDataScript.EndUpdate(false);
    FDataScript.Next;
    DS.Free;
  end;
end;

procedure TSgtsSqlEditForm.FillTypes(PickList: TStrings);
var
  i: Integer;
  PInfo: PTypeInfo;
  PData: PTypeData;
begin
  PickList.BeginUpdate;
  try
    PickList.Clear;
    PData:=nil;
    PInfo:=TypeInfo(TSgtsDatabaseInstallType);
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

procedure TSgtsSqlEditForm.FieldTypeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsInteger in [0..FGridScript.Columns.Items[FIndexType].PickList.Count-1] then
    Text:=FGridScript.Columns.Items[FIndexType].PickList[Sender.AsInteger];
end;

procedure TSgtsSqlEditForm.FieldTypeSetText(Sender: TField; const Text: string);
var
  Index: Integer;
begin
  Index:=FGridScript.Columns.Items[FIndexType].PickList.IndexOf(Text);
  if Index in [0..FGridScript.Columns.Items[FIndexType].PickList.Count-1] then begin
    Sender.AsInteger:=Index;
    DataScriptAfterScroll(nil);
  end;
end;

procedure TSgtsSqlEditForm.DataScriptAfterScroll(DataSet: TDataSet);
var
  Index: Integer;
  Stream: TMemoryStream;
  OldCursor: TCursor;
begin
  if FDataScript.Active and not FDataScript.IsEmpty then begin
    OldCursor:=Screen.Cursor;
    try
      Screen.Cursor:=crHourGlass;
      Index:=FDataScript.FieldByName(SDb_Type).AsInteger;
      case TSgtsDatabaseInstallType(Index) of
        itScript: MemoScript.Lines.Text:=FDataScript.FieldByName(SDb_Value).Value;
        itTable: begin
          try
            Stream:=TMemoryStream.Create;
            try
              TBlobField(FDataScript.FieldByName(SDb_Value)).SaveToStream(Stream);
              Stream.Position:=0;
              TableEditFrame.DBMemoValue.DataField:='';
              TableEditFrame.DataSet.Close;
              if Stream.Size>0 then begin
                TableEditFrame.DataSet.LoadFromStream(Stream);
                TableEditFrame.EditTableName.Text:=TableEditFrame.DataSet.TableName;
                if TableEditFrame.DataSet.FieldCount>0 then
                  TableEditFrame.DBMemoValue.DataField:=TableEditFrame.DataSet.Fields[0].FieldName;
              end;
            finally
              Stream.Free;
            end;
          except
          end;
        end;
        itFile: MemoFile.Lines.Text:=FDataScript.FieldByName(SDb_Value).Value;
      end;
      PageControlValue.ActivePageIndex:=Index;
    finally
      Screen.Cursor:=OldCursor;
    end;  
  end else
    PageControlValue.ActivePageIndex:=0;
end;

procedure TSgtsSqlEditForm.DataScriptBeforeScroll(DataSet: TDataSet);
begin
  FDataScript.BeforeScroll:=nil;
  try
    if FDataScript.Active and not FDataScript.IsEmpty then begin
      if not (FDataScript.State in [dsEdit,dsInsert]) then begin
        FDataScript.Edit;
      end;
//      DataScriptBeforePost(nil);
      if (FDataScript.State in [dsEdit,dsInsert]) then
        FDataScript.Post;
    end;
  finally
    FDataScript.BeforeScroll:=DataScriptBeforeScroll;
  end;
end;

procedure TSgtsSqlEditForm.DataScriptBeforePost(DataSet: TDataSet);
var
  Index: TSgtsDatabaseInstallType;
  Stream: TMemoryStream;
  OldCursor: TCursor;
begin
  if FDataScript.Active then begin
    OldCursor:=Screen.Cursor;
    try
      Screen.Cursor:=crHourGlass;
      Index:=TSgtsDatabaseInstallType(FDataScript.FieldByName(SDb_Type).AsInteger);
      case Index of
        itUnknown: FDataScript.FieldByName(SDb_Value).Value:=Null;
        itScript: FDataScript.FieldByName(SDb_Value).Value:=MemoScript.Lines.Text;
        itTable: begin
          Stream:=TMemoryStream.Create;
          try
            if TableEditFrame.DataSet.Active then begin
              TableEditFrame.DataSet.TableName:=TableEditFrame.EditTableName.Text;
              TableEditFrame.DataSet.SaveToStream(Stream,dfXMLUTF8);
              Stream.Position:=0;
              TBlobField(FDataScript.FieldByName(SDb_Value)).LoadFromStream(Stream);
            end;
          finally
            Stream.Free;
          end;
        end;
        itFile: FDataScript.FieldByName(SDb_Value).Value:=MemoFile.Lines.Text;
      end;
    finally
      Screen.Cursor:=OldCursor;
    end;  
  end;
end;

procedure TSgtsSqlEditForm.DataSetAfterPost(DataSet: TDataSet);
begin
end;

procedure TSgtsSqlEditForm.btUpColumnsClick(Sender: TObject);
begin
  FDataScript.MoveData(true);
end;

procedure TSgtsSqlEditForm.btDownColumnsClick(Sender: TObject);
begin
  FDataScript.MoveData(false);
end;

procedure TSgtsSqlEditForm.Sql1Click(Sender: TObject);
begin
  OpenDialogScript.FilterIndex:=3;
  if OpenDialogScript.Execute then begin
    FDataScript.AfterScroll:=nil;
    FDataScript.BeforeScroll:=nil;
    FDataScript.BeforePost:=nil;
    try
      LoadFromSqlFile(OpenDialogScript.FileName);
      DataScriptAfterScroll(FDataScript);
    finally
      FDataScript.AfterScroll:=DataScriptAfterScroll;
      FDataScript.BeforeScroll:=DataScriptBeforeScroll;
      FDataScript.BeforePost:=DataScriptBeforePost;
    end;
  end;
end;

end.
