unit SgtsRbkGroupObjectsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm,
  SgtsCoreIntf, StdCtrls;

type
  TSgtsRbkGroupObjectsForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkGroupObjectsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkGroupObjectsForm: TSgtsRbkGroupObjectsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkGroupObjectEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkGroupObjectsIface }

procedure TSgtsRbkGroupObjectsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkGroupObjectsForm;
  InterfaceName:=SInterfaceGroupObjects;
  InsertClass:=TSgtsRbkGroupObjectInsertIface;
  UpdateClass:=TSgtsRbkGroupObjectUpdateIface;
  DeleteClass:=TSgtsRbkGroupObjectDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectGroupObjects;
    with SelectDefs do begin
      AddInvisible('GROUP_ID');
      AddInvisible('OBJECT_ID');
      Add('GROUP_NAME','Группа',150);
      Add('OBJECT_NAME','Объект',150);
      Add('PRIORITY','Порядок',30);
    end;
  end;
end;

{ TSgtsRbkGroupObjectsForm }

constructor TSgtsRbkGroupObjectsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
