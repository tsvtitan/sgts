unit SgtsRbkParamsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  StdCtrls, Mask, DBCtrls,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsSelectDefs,
  SgtsCoreIntf;

type
  TSgtsRbkParamsForm = class(TSgtsDataGridForm)
    PanelInfo: TPanel;
    GroupBoxInfo: TGroupBox;
    PanelNote: TPanel;
    DBMemoNote: TDBMemo;
    Splitter: TSplitter;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkParamsIface=class(TSgtsDataGridIface)
  private
    function GetParamType(Def: TSgtsSelectDef): Variant;
  public
    procedure Init; override;
  end;

var
  SgtsRbkParamsForm: TSgtsRbkParamsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsRbkParamEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkParamsIface }

procedure TSgtsRbkParamsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkParamsForm;
  InterfaceName:=SInterfaceParams;
  InsertClass:=TSgtsRbkParamInsertIface;
  UpdateClass:=TSgtsRbkParamUpdateIface;
  DeleteClass:=TSgtsRbkParamDeleteIface;  
  with DataSet do begin
    ProviderName:=SProviderSelectParams;
    with SelectDefs do begin
      AddKey('PARAM_ID');
      Add('NAME','Наименование',150);
      AddCalc('PARAM_TYPE_EX','Тип параметра','PARAM_TYPE',GetParamType,ftString,22,70);
      Add('ALGORITHM_NAME','Алгоритм',120);
      AddInvisible('ALGORITHM_ID');
      AddInvisible('DESCRIPTION');
      AddInvisible('FORMAT');
      AddInvisible('DETERMINATION');
      AddInvisible('IS_NOT_CONFIRM');
    end;
  end;
end;

function TSgtsRbkParamsIface.GetParamType(Def: TSgtsSelectDef): Variant;
begin
  Result:=Null;
  case TSgtsRbkParamType(DataSet.FieldByName(Def.CalcName).AsInteger) of
    ptIntroduced: Result:='Вводимый';
    ptIntegral: Result:='Интегральный';
    ptDerived: Result:='Производный';
    ptIntegralInvisible: Result:='Интегральный невидимый';
  end;
end;

{ TSgtsRbkParamsForm }

constructor TSgtsRbkParamsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
