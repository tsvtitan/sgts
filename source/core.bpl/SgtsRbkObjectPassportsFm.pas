unit SgtsRbkObjectPassportsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  StdCtrls, Mask, DBCtrls,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsSelectDefs,
  SgtsCoreIntf;

type
  TSgtsRbkObjectPassportsForm = class(TSgtsDataGridForm)
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

  TSgtsRbkObjectPassportsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

  
var
  SgtsRbkObjectPassportsForm: TSgtsRbkObjectPassportsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsRbkObjectPassportEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkObjectPassportsIface }

procedure TSgtsRbkObjectPassportsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkObjectPassportsForm;
  InterfaceName:=SInterfaceObjectPassports;
  InsertClass:=TSgtsRbkObjectPassportInsertIface;
  UpdateClass:=TSgtsRbkObjectPassportUpdateIface;
  DeleteClass:=TSgtsRbkObjectPassportDeleteIface;  
  with DataSet do begin
    ProviderName:=SProviderSelectObjectPassports;
    with SelectDefs do begin
      AddKey('OBJECT_PASSPORT_ID');
      Add('OBJECT_NAME','Объект',150);
      Add('DATE_PASSPORT','Дата',80);
      Add('PARAM_NAME','Параметр',100);
      Add('VALUE','Значение',50);
      AddInvisible('OBJECT_ID');
      AddInvisible('DESCRIPTION');
    end;
  end;
end;

{ TSgtsRbkObjectPassportsForm }

constructor TSgtsRbkObjectPassportsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
