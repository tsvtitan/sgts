unit SgtsRbkPointsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  StdCtrls, Mask, DBCtrls,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsCoreIntf, SgtsControls;

type
  TSgtsRbkPointsForm = class(TSgtsDataGridForm)
    PanelInfo: TPanel;
    GroupBoxInfo: TGroupBox;
    PanelNote: TPanel;
    DBMemoDescription: TDBMemo;
    Splitter: TSplitter;
    LabelX: TLabel;
    DBEditX: TDBEdit;
    LabelY: TLabel;
    DBEditY: TDBEdit;
    LabelZ: TLabel;
    DBEditZ: TDBEdit;
    LabelDescription: TLabel;
    LabelObjectPaths: TLabel;
    DBMemoObjectPaths: TDBMemo;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkPointsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkPointsForm: TSgtsRbkPointsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkPointEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkPointsIface }

procedure TSgtsRbkPointsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPointsForm;
  InterfaceName:=SInterfacePoints;
  InsertClass:=TSgtsRbkPointInsertIface;
  UpdateClass:=TSgtsRbkPointUpdateIface;
  DeleteClass:=TSgtsRbkPointDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectPoints;
    with SelectDefs do begin
      AddKey('POINT_ID');
      Add('NAME','Номер',100);
      Add('POINT_TYPE_NAME','Тип точки',100);
      Add('OBJECT_NAME','Объект',150);
      Add('DATE_ENTER','Дата ввода',70);
      AddInvisible('OBJECT_ID');
      AddInvisible('POINT_TYPE_ID');
      AddInvisible('DESCRIPTION');
      AddInvisible('COORDINATE_X');
      AddInvisible('COORDINATE_Y');
      AddInvisible('COORDINATE_Z');
      AddInvisible('OBJECT_PATHS');
    end;
  end;
end;

{ TSgtsRbkPointsForm }

constructor TSgtsRbkPointsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
