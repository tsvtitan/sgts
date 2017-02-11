unit SgtsRbkRoutesFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  StdCtrls, DBCtrls,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsSelectDefs,
  SgtsCoreIntf;

type
  TSgtsRbkRoutesForm = class(TSgtsDataGridForm)
    PanelInfo: TPanel;
    GroupBoxInfo: TGroupBox;
    PanelNote: TPanel;
    DBMemoDescription: TDBMemo;
    Splitter: TSplitter;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkRoutesIface=class(TSgtsDataGridIface)
  private
    function GetIsActiveEx(Def: TSgtsSelectDef): Variant;
  public
    procedure Init; override;
  end;

var
  SgtsRbkRoutesForm: TSgtsRbkRoutesForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsRbkRouteEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkRoutesIface }

procedure TSgtsRbkRoutesIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkRoutesForm;
  InterfaceName:=SInterfaceRoutes;
  InsertClass:=TSgtsRbkRouteInsertIface;
  UpdateClass:=TSgtsRbkRouteUpdateIface;
  DeleteClass:=TSgtsRbkRouteDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectRoutes;
    with SelectDefs do begin
      AddKey('ROUTE_ID');
      Add('NAME','Наименование',200);
      Add('DATE_ROUTE','Дата маршрута',60);
      AddCalc('IS_ACTIVE_EX','Активность','IS_ACTIVE',GetIsActiveEx,ftString,3,50).Alignment:=daCenter;
      AddInvisible('DESCRIPTION');
    end;
  end;
end;

function TSgtsRbkRoutesIface.GetIsActiveEx(Def: TSgtsSelectDef): Variant;
begin
  Result:=Null;
  case DataSet.FieldByName(Def.CalcName).AsInteger of
    0: Result:='нет';
    1: Result:='да'
  end;
end;

{ TSgtsRbkRoutesForm }

constructor TSgtsRbkRoutesForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
