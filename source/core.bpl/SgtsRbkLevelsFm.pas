unit SgtsRbkLevelsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ExtCtrls, ComCtrls, ToolWin,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsCDS,
  SgtsCoreIntf, StdCtrls, DBCtrls, Grids, DBGrids;

type
  TSgtsRbkLevelsForm = class(TSgtsDataGridForm)
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

  TSgtsRbkLevelsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkLevelsForm: TSgtsRbkLevelsForm;

implementation

uses SgtsProviderConsts, SgtsIface, SgtsConsts, SgtsRbkLevelEditFm,
     SgtsSelectDefs;

{$R *.dfm}

{ TSgtsRbkLevelsIface }

procedure TSgtsRbkLevelsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkLevelsForm;
  InterfaceName:=SInterfaceLevels;
  InsertClass:=TSgtsRbkLevelInsertIface;
  UpdateClass:=TSgtsRbkLevelUpdateIface;
  DeleteClass:=TSgtsRbkLevelDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectLevels;
    with SelectDefs do begin
      AddKey('LEVEL_ID');
      Add('NAME','Наименование');
      AddInvisible('DESCRIPTION');
    end;
  end;
end;

{ TSgtsRbkLevelsForm }

constructor TSgtsRbkLevelsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
