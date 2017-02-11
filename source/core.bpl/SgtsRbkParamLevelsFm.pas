unit SgtsRbkParamLevelsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, 
  SgtsCoreIntf, StdCtrls;

type
  TSgtsRbkParamLevelsForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkParamLevelsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkParamLevelsForm: TSgtsRbkParamLevelsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkParamLevelEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkParamLevelsIface }

procedure TSgtsRbkParamLevelsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkParamLevelsForm;
  InterfaceName:=SInterfaceParamLevels;
  InsertClass:=TSgtsRbkParamLevelInsertIface;
  UpdateClass:=TSgtsRbkParamLevelUpdateIface;
  DeleteClass:=TSgtsRbkParamLevelDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectParamLevels;
    with SelectDefs do begin
      AddInvisible('PARAM_ID');
      AddInvisible('LEVEL_ID');
      Add('PARAM_NAME','Параметр',120);
      Add('LEVEL_NAME','Уровень',100);
      Add('LEVEL_MIN','Минимум',80);
      Add('LEVEL_MAX','Максимум',80);
    end;
  end;
end;

{ TSgtsRbkParamLevelsForm }

constructor TSgtsRbkParamLevelsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
