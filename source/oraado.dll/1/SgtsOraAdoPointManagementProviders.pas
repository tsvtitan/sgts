unit SgtsOraAdoPointManagementProviders;

interface

uses SgtsOraAdoProviders, SgtsProviders, SgtsGetRecordsConfig, SgtsDatabase;

type

  TSgtsOraAdoSelectPointManagementProvider=class(TSgtsOraAdoGetRecordsProvider)
  private
    function GetRecordsPointManagement(Provider: TSgtsGetRecordsProvider; Config: TSgtsGetRecordsConfig): OleVariant;
  public
    constructor Create; override;
  end;

implementation

uses Variants, DB,
     SgtsProviderConsts, SgtsOraAdoConsts, SgtsCDS,
     SgtsOraAdoDatabase;

{ TSgtsOraAdoSelectPointManagementProvider }

constructor TSgtsOraAdoSelectPointManagementProvider.Create;
begin
  inherited Create;
  Name:=SProviderSelectPointManagement;
  Alias:=SProviderAliasSelectPointManagement;
  Proc:=GetRecordsPointManagement;
end;

function TSgtsOraAdoSelectPointManagementProvider.GetRecordsPointManagement(Provider: TSgtsGetRecordsProvider; Config: TSgtsGetRecordsConfig): OleVariant;

  function GetParentId(DataSet: TSgtsCDS; FieldName: String; ParentId: Variant): Variant;
  begin
    Result:=Null;
    DataSet.First;
    if DataSet.Locate(FieldName,ParentId,[loCaseInsensitive]) then begin
      Result:=DataSet.FieldByName('TREE_ID').Value;
    end;
  end;

var
  QueryMeasures: TSgtsADOQuery;
  QueryRoutes: TSgtsADOQuery;
  QueryPoints: TSgtsADOQuery;
  QueryConverters: TSgtsADOQuery;
  DSOut: TSgtsCDS;
  DSFind: TSgtsCDS;
begin
  Result:=Database.CreateDefaultGetRecordsData;
  if Database.Connection.Connected then begin
    QueryMeasures:=TSgtsADOQuery.Create(nil);
    QueryRoutes:=TSgtsADOQuery.Create(nil);
    QueryPoints:=TSgtsADOQuery.Create(nil);
    QueryConverters:=TSgtsADOQuery.Create(nil);
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
        Add('DESCRIPTION',ftString,250);
        Add('PARENT_NAME',ftString,100);
        Add('PRIORITY',ftInteger);
      end;
      DSOut.CreateDataSet;

      QueryRoutes.Connection:=Database.Connection;
      QueryRoutes.SQL.Text:='SELECT GET_POINT_MANAGEMENT_ID AS TREE_ID,'+
                            'MTR.ROUTE_ID, MTR.MEASURE_TYPE_ID, R.NAME, R.DESCRIPTION,'+
                            'MT.NAME AS PARENT_NAME, MTR.PRIORITY '+
                            'FROM MEASURE_TYPE_ROUTES MTR, ROUTES R, MEASURE_TYPES MT '+
                            'WHERE MTR.ROUTE_ID=R.ROUTE_ID AND MTR.MEASURE_TYPE_ID=MT.MEASURE_TYPE_ID ORDER BY PRIORITY';
      QueryRoutes.Open;

      QueryPoints.Connection:=Database.Connection;
      QueryPoints.SQL.Text:='SELECT GET_POINT_MANAGEMENT_ID AS TREE_ID, RP.POINT_ID, RP.ROUTE_ID,'+
                            'P.NAME, P.DESCRIPTION, R.NAME AS PARENT_NAME, RP.PRIORITY, MTR.MEASURE_TYPE_ID '+
                            'FROM ROUTE_POINTS RP, POINTS P, ROUTES R, MEASURE_TYPE_ROUTES MTR '+
                            'WHERE RP.POINT_ID=P.POINT_ID AND RP.ROUTE_ID=R.ROUTE_ID '+
                            'AND R.ROUTE_ID=MTR.ROUTE_ID ORDER BY PRIORITY';
      QueryPoints.Open;

      QueryConverters.Connection:=Database.Connection;
      QueryConverters.SQL.Text:='SELECT GET_POINT_MANAGEMENT_ID AS TREE_ID, C.CONVERTER_ID, P.POINT_ID,'+
                                'C.NAME, C.DESCRIPTION, P.NAME AS PARENT_NAME, MTR.MEASURE_TYPE_ID, RP.ROUTE_ID '+
                                'FROM CONVERTERS C, POINTS P, ROUTE_POINTS RP, MEASURE_TYPE_ROUTES MTR '+
                                'WHERE C.CONVERTER_ID=P.POINT_ID AND RP.POINT_ID=P.POINT_ID AND RP.ROUTE_ID=MTR.ROUTE_ID';
      QueryConverters.Open;

      QueryMeasures.Connection:=Database.Connection;
      QueryMeasures.Sql.Text:='SELECT GET_POINT_MANAGEMENT_ID AS TREE_ID, MT.* FROM S_MEASURE_TYPES MT';
      QueryMeasures.Open;
      
      if QueryMeasures.Active and not QueryMeasures.IsEmpty and
         QueryRoutes.Active and QueryPoints.Active then begin

        DSFind.CreateDataSetBySource(QueryMeasures,true,true);

        QueryMeasures.First;
        while not QueryMeasures.Eof do begin
          DSOut.Append;
          DSOut.FieldByName('TREE_ID').Value:=QueryMeasures.FieldByName('TREE_ID').Value;
          DSOut.FieldByName('TREE_PARENT_ID').Value:=GetParentId(DSFind,'MEASURE_TYPE_ID',QueryMeasures.FieldByName('PARENT_ID').Value);
          DSOut.FieldByName('UNION_ID').Value:=QueryMeasures.FieldByName('MEASURE_TYPE_ID').Value;
          DSOut.FieldByName('UNION_PARENT_ID').Value:=QueryMeasures.FieldByName('PARENT_ID').Value;
          DSOut.FieldByName('UNION_TYPE').Value:=0;
          DSOut.FieldByName('NAME').Value:=QueryMeasures.FieldByName('NAME').Value;
          DSOut.FieldByName('DESCRIPTION').Value:=QueryMeasures.FieldByName('DESCRIPTION').Value;
          DSOut.FieldByName('PARENT_NAME').Value:=QueryMeasures.FieldByName('PARENT_NAME').Value;
          DSOut.FieldByName('PRIORITY').Value:=QueryMeasures.FieldByName('PRIORITY').Value;
          DSOut.Post;

          QueryRoutes.First;
          while not QueryRoutes.Eof do begin
            if QueryRoutes.FieldByName('MEASURE_TYPE_ID').Value=QueryMeasures.FieldByName('MEASURE_TYPE_ID').Value then begin
              DSOut.Append;
              DSOut.FieldByName('TREE_ID').Value:=QueryRoutes.FieldByName('TREE_ID').Value;
              DSOut.FieldByName('TREE_PARENT_ID').Value:=QueryMeasures.FieldByName('TREE_ID').Value;
              DSOut.FieldByName('UNION_ID').Value:=QueryRoutes.FieldByName('ROUTE_ID').Value;
              DSOut.FieldByName('UNION_PARENT_ID').Value:=QueryRoutes.FieldByName('MEASURE_TYPE_ID').Value;
              DSOut.FieldByName('UNION_TYPE').Value:=1;
              DSOut.FieldByName('NAME').Value:=QueryRoutes.FieldByName('NAME').Value;
              DSOut.FieldByName('DESCRIPTION').Value:=QueryRoutes.FieldByName('DESCRIPTION').Value;
              DSOut.FieldByName('PARENT_NAME').Value:=QueryRoutes.FieldByName('PARENT_NAME').Value;
              DSOut.FieldByName('PRIORITY').Value:=QueryRoutes.FieldByName('PRIORITY').Value;
              DSOut.Post;

              QueryPoints.First;
              while not QueryPoints.Eof do begin
                if (QueryPoints.FieldByName('ROUTE_ID').Value=QueryRoutes.FieldByName('ROUTE_ID').Value) and
                   (QueryPoints.FieldByName('MEASURE_TYPE_ID').Value=QueryMeasures.FieldByName('MEASURE_TYPE_ID').Value) then begin
                  DSOut.Append;
                  DSOut.FieldByName('TREE_ID').Value:=QueryPoints.FieldByName('TREE_ID').Value;
                  DSOut.FieldByName('TREE_PARENT_ID').Value:=QueryRoutes.FieldByName('TREE_ID').Value;
                  DSOut.FieldByName('UNION_ID').Value:=QueryPoints.FieldByName('POINT_ID').Value;
                  DSOut.FieldByName('UNION_PARENT_ID').Value:=QueryPoints.FieldByName('ROUTE_ID').Value;
                  DSOut.FieldByName('UNION_TYPE').Value:=2;
                  DSOut.FieldByName('NAME').Value:=QueryPoints.FieldByName('NAME').Value;
                  DSOut.FieldByName('DESCRIPTION').Value:=QueryPoints.FieldByName('DESCRIPTION').Value;
                  DSOut.FieldByName('PARENT_NAME').Value:=QueryPoints.FieldByName('PARENT_NAME').Value;
                  DSOut.FieldByName('PRIORITY').Value:=QueryPoints.FieldByName('PRIORITY').Value;
                  DSOut.Post;

                  QueryConverters.First;
                  while not QueryConverters.Eof do begin
                    if (QueryConverters.FieldByName('POINT_ID').Value=QueryPoints.FieldByName('POINT_ID').Value) and
                       (QueryConverters.FieldByName('ROUTE_ID').Value=QueryRoutes.FieldByName('ROUTE_ID').Value) and
                       (QueryConverters.FieldByName('MEASURE_TYPE_ID').Value=QueryMeasures.FieldByName('MEASURE_TYPE_ID').Value) then begin
                      DSOut.Append;
                      DSOut.FieldByName('TREE_ID').Value:=QueryConverters.FieldByName('TREE_ID').Value;
                      DSOut.FieldByName('TREE_PARENT_ID').Value:=QueryPoints.FieldByName('TREE_ID').Value;
                      DSOut.FieldByName('UNION_ID').Value:=QueryConverters.FieldByName('CONVERTER_ID').Value;
                      DSOut.FieldByName('UNION_PARENT_ID').Value:=QueryConverters.FieldByName('POINT_ID').Value;
                      DSOut.FieldByName('UNION_TYPE').Value:=3;
                      DSOut.FieldByName('NAME').Value:=QueryConverters.FieldByName('NAME').Value;
                      DSOut.FieldByName('DESCRIPTION').Value:=QueryConverters.FieldByName('DESCRIPTION').Value;
                      DSOut.FieldByName('PARENT_NAME').Value:=QueryConverters.FieldByName('PARENT_NAME').Value;
                      DSOut.FieldByName('PRIORITY').Value:=1;
                      DSOut.Post;

                    end;
                    QueryConverters.Next;
                  end;
                end;
                QueryPoints.Next;
              end;
            end;
            QueryRoutes.Next;
          end;

          QueryMeasures.Next;
        end;
      end;
      DSOut.MergeChangeLog;
      DSOut.First;
      Result:=DSOut.Data;
    finally
      DSFind.Free;
      DSOut.Free;
      QueryConverters.Free;
      QueryPoints.Free;
      QueryRoutes.Free;
      QueryMeasures.Free;
    end;
  end;
end;


end.
