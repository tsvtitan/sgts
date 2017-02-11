unit SgtsRbkObjectDrawingsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm,
  SgtsCoreIntf, StdCtrls;

type
  TSgtsRbkObjectDrawingsForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkObjectDrawingsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkObjectDrawingsForm: TSgtsRbkObjectDrawingsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkObjectDrawingEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkObjectDrawingsIface }

procedure TSgtsRbkObjectDrawingsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkObjectDrawingsForm;
  InterfaceName:=SInterfaceObjectDrawings;
  InsertClass:=TSgtsRbkObjectDrawingInsertIface;
  UpdateClass:=TSgtsRbkObjectDrawingUpdateIface;
  DeleteClass:=TSgtsRbkObjectDrawingDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectObjectDrawings;
    with SelectDefs do begin
      AddInvisible('OBJECT_ID');
      AddInvisible('DRAWING_ID');
      Add('OBJECT_NAME','Объект',150);
      Add('DRAWING_NAME','Чертеж',150);
      Add('PRIORITY','Порядок',30);
    end;
  end;
end;

{ TSgtsRbkObjectDrawingsForm }

constructor TSgtsRbkObjectDrawingsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
