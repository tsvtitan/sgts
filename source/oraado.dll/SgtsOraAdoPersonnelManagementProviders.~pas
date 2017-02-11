unit SgtsOraAdoPersonnelManagementProviders;

interface

uses SgtsOraAdoProviders, SgtsProviders, SgtsGetRecordsConfig, SgtsDatabase;

type

  TSgtsOraAdoSelectPersonnelManagementProvider=class(TSgtsOraAdoGetRecordsProvider)
  private
    function GetRecordsPersonnelManagement(Provider: TSgtsGetRecordsProvider; Config: TSgtsGetRecordsConfig;
                                           ProgressProc: TSgtsProviderProgressProc=nil): OleVariant;
  public
    constructor Create; override;
  end;

  TSgtsOraAdoInsertPersonnelManagementProvider=class(TSgtsOraAdoGetRecordsProvider)
  public
    constructor Create; override;
  end;
  
implementation

uses Variants, DB,
     SgtsProviderConsts, SgtsOraAdoConsts, SgtsCDS,
     SgtsOraAdoDatabase;

{ TSgtsOraAdoSelectPersonnelManagementProvider }

constructor TSgtsOraAdoSelectPersonnelManagementProvider.Create;
begin
  inherited Create;
  Name:=SProviderSelectPersonnelManagement;
  Alias:=SProviderAliasSelectPersonnelManagement;
  Proc:=GetRecordsPersonnelManagement;
  ProviderType:=rptGetRecords;
end;

function TSgtsOraAdoSelectPersonnelManagementProvider.GetRecordsPersonnelManagement(Provider: TSgtsGetRecordsProvider;
                                                                                    Config: TSgtsGetRecordsConfig;
                                                                                    ProgressProc: TSgtsProviderProgressProc=nil): OleVariant;

  function GetParentId(DataSet: TSgtsCDS; FieldName: String; ParentId: Variant): Variant;
  begin
    Result:=Null;
    DataSet.First;
    if DataSet.Locate(FieldName,ParentId,[loCaseInsensitive]) then begin
      Result:=DataSet.FieldByName('TREE_ID').Value;
    end;
  end;

var
  QueryDivisions: TSgtsADOQuery;
  QueryPersonnels: TSgtsADOQuery;
  QueryAccounts: TSgtsADOQuery;
  DSOut: TSgtsCDS;
  DSFind: TSgtsCDS;
begin
  Result:=Database.CreateDefaultGetRecordsData;
  if Database.Connection.Connected then begin
    QueryDivisions:=TSgtsADOQuery.Create(nil);
    QueryPersonnels:=TSgtsADOQuery.Create(nil);
    QueryAccounts:=TSgtsADOQuery.Create(nil);
    DSOut:=TSgtsCDS.Create(nil);
    DSFind:=TSgtsCDS.Create(nil);
    try
      with DSOut.FieldDefs do begin
        Add('TREE_ID',ftInteger);
        Add('TREE_PARENT_ID',ftInteger);
        Add('UNION_ID',ftInteger);
        Add('UNION_PARENT_ID',ftInteger);
        Add('UNION_TYPE',ftInteger);
        Add('NAME',ftString,100);
        Add('FNAME',ftString,100);
        Add('SNAME',ftString,100);
        Add('PASS',ftString,50);
        Add('DESCRIPTION',ftString,250);
        Add('PARENT_NAME',ftString,100);
        Add('PRIORITY',ftInteger);
        Add('DATE_ACCEPT',ftDate);
        Add('DATE_SACK',ftDate);
      end;
      DSOut.CreateDataSet;

      QueryPersonnels.Connection:=Database.Connection;
      QueryPersonnels.SQL.Text:='SELECT GET_PERSONNEL_MANAGEMENT_ID AS TREE_ID,P.PERSONNEL_ID,'+
                                'D.DIVISION_ID,P.NAME,P.FNAME,P.SNAME,NULL AS DESCRIPTION,D.NAME AS PARENT_NAME,'+
                                '1 AS PRIORITY,P.DATE_ACCEPT,P.DATE_SACK FROM PERSONNELS P, DIVISIONS D WHERE P.DIVISION_ID=D.DIVISION_ID';
      QueryPersonnels.Open;

      QueryAccounts.Connection:=Database.Connection;
      QueryAccounts.SQL.Text:='SELECT GET_PERSONNEL_MANAGEMENT_ID AS TREE_ID,A.ACCOUNT_ID,'+
                              'P.PERSONNEL_ID,A.NAME,A.DESCRIPTION,P.FNAME||'' ''||P.NAME||'' ''||P.SNAME AS PARENT_NAME,'+
                              '1 AS PRIORITY, A.PASS FROM ACCOUNTS A, PERSONNELS P WHERE A.PERSONNEL_ID=P.PERSONNEL_ID';
      QueryAccounts.Open;

      QueryDivisions.Connection:=Database.Connection;
      QueryDivisions.Sql.Text:='SELECT GET_POINT_MANAGEMENT_ID AS TREE_ID, D.* FROM S_DIVISIONS D';
      QueryDivisions.Open;

      if QueryDivisions.Active and not QueryDivisions.IsEmpty and
         QueryPersonnels.Active and QueryAccounts.Active then begin

        DSFind.CreateDataSetBySource(QueryDivisions,true,true);

        QueryDivisions.First;
        while not QueryDivisions.Eof do begin
          DSOut.Append;
          DSOut.FieldByName('TREE_ID').Value:=QueryDivisions.FieldByName('TREE_ID').Value;
          DSOut.FieldByName('TREE_PARENT_ID').Value:=GetParentId(DSFind,'DIVISION_ID',QueryDivisions.FieldByName('PARENT_ID').Value);
          DSOut.FieldByName('UNION_ID').Value:=QueryDivisions.FieldByName('DIVISION_ID').Value;
          DSOut.FieldByName('UNION_PARENT_ID').Value:=QueryDivisions.FieldByName('PARENT_ID').Value;
          DSOut.FieldByName('UNION_TYPE').Value:=0;
          DSOut.FieldByName('NAME').Value:=QueryDivisions.FieldByName('NAME').Value;
          DSOut.FieldByName('DESCRIPTION').Value:=QueryDivisions.FieldByName('DESCRIPTION').Value;
          DSOut.FieldByName('PARENT_NAME').Value:=QueryDivisions.FieldByName('PARENT_NAME').Value;
          DSOut.FieldByName('PRIORITY').Value:=QueryDivisions.FieldByName('PRIORITY').Value;
          DSOut.Post;

          QueryPersonnels.First;
          while not QueryPersonnels.Eof do begin
            if QueryPersonnels.FieldByName('DIVISION_ID').Value=QueryDivisions.FieldByName('DIVISION_ID').Value then begin
              DSOut.Append;
              DSOut.FieldByName('TREE_ID').Value:=QueryPersonnels.FieldByName('TREE_ID').Value;
              DSOut.FieldByName('TREE_PARENT_ID').Value:=QueryDivisions.FieldByName('TREE_ID').Value;
              DSOut.FieldByName('UNION_ID').Value:=QueryPersonnels.FieldByName('PERSONNEL_ID').Value;
              DSOut.FieldByName('UNION_PARENT_ID').Value:=QueryPersonnels.FieldByName('DIVISION_ID').Value;
              DSOut.FieldByName('UNION_TYPE').Value:=1;
              DSOut.FieldByName('NAME').Value:=QueryPersonnels.FieldByName('NAME').Value;
              DSOut.FieldByName('FNAME').Value:=QueryPersonnels.FieldByName('FNAME').Value;
              DSOut.FieldByName('SNAME').Value:=QueryPersonnels.FieldByName('SNAME').Value;
              DSOut.FieldByName('DESCRIPTION').Value:=QueryPersonnels.FieldByName('DESCRIPTION').Value;
              DSOut.FieldByName('PARENT_NAME').Value:=QueryPersonnels.FieldByName('PARENT_NAME').Value;
              DSOut.FieldByName('PRIORITY').Value:=QueryPersonnels.FieldByName('PRIORITY').Value;
              DSOut.FieldByName('DATE_ACCEPT').Value:=QueryPersonnels.FieldByName('DATE_ACCEPT').Value;
              DSOut.FieldByName('DATE_SACK').Value:=QueryPersonnels.FieldByName('DATE_SACK').Value;
              DSOut.Post;

              QueryAccounts.First;
              while not QueryAccounts.Eof do begin
                if (QueryAccounts.FieldByName('PERSONNEL_ID').Value=QueryPersonnels.FieldByName('PERSONNEL_ID').Value) then begin
                  DSOut.Append;
                  DSOut.FieldByName('TREE_ID').Value:=QueryAccounts.FieldByName('TREE_ID').Value;
                  DSOut.FieldByName('TREE_PARENT_ID').Value:=QueryPersonnels.FieldByName('TREE_ID').Value;
                  DSOut.FieldByName('UNION_ID').Value:=QueryAccounts.FieldByName('ACCOUNT_ID').Value;
                  DSOut.FieldByName('UNION_PARENT_ID').Value:=QueryAccounts.FieldByName('PERSONNEL_ID').Value;
                  DSOut.FieldByName('UNION_TYPE').Value:=2;
                  DSOut.FieldByName('NAME').Value:=QueryAccounts.FieldByName('NAME').Value;
                  DSOut.FieldByName('PASS').Value:=QueryAccounts.FieldByName('PASS').Value;
                  DSOut.FieldByName('DESCRIPTION').Value:=QueryAccounts.FieldByName('DESCRIPTION').Value;
                  DSOut.FieldByName('PARENT_NAME').Value:=QueryAccounts.FieldByName('PARENT_NAME').Value;
                  DSOut.FieldByName('PRIORITY').Value:=QueryAccounts.FieldByName('PRIORITY').Value;
                  DSOut.Post;

                end;
                QueryAccounts.Next;
              end;
            end;
            QueryPersonnels.Next;
          end;
          QueryDivisions.Next;
        end;
      end;
      DSOut.MergeChangeLog;
      DSOut.First;

      Config.AllCount:=DSOut.RecordCount;
      Config.RecsOut:=Config.AllCount;
      
      Result:=DSOut.Data;
    finally
      DSFind.Free;
      DSOut.Free;
      QueryAccounts.Free;
      QueryPersonnels.Free;
      QueryDivisions.Free;
    end;
  end;
end;


{ TSgtsOraAdoInsertPersonnelManagementProvider }

constructor TSgtsOraAdoInsertPersonnelManagementProvider.Create;
begin
  inherited Create;
  Name:=SProviderInsertPersonnelManagement;
  Alias:=SProviderAliasSelectPersonnelManagement;
  ProviderType:=rptExecute;
end;

end.
