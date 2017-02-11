unit SgtsRbkObjectDrawingEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkObjectDrawingEditForm = class(TSgtsDataEditForm)
    LabelObject: TLabel;
    EditObject: TEdit;
    ButtonObject: TButton;
    LabelDrawing: TLabel;
    EditDrawing: TEdit;
    ButtonDrawing: TButton;
    LabelPriority: TLabel;
    EditPriority: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkObjectDrawingInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkObjectDrawingUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkObjectDrawingDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkObjectDrawingRoleEditForm: TSgtsRbkObjectDrawingEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkDrawingsFm, SgtsRbkObjectsFm;

{$R *.dfm}

{ TSgtsRbkObjectDrawingInsertIface }

procedure TSgtsRbkObjectDrawingInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkObjectDrawingEditForm;
  InterfaceName:=SInterfaceObjectDrawingInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertObjectDrawing;
    with ExecuteDefs do begin
      AddEditLink('OBJECT_ID','EditObject','LabelObject','ButtonObject',
                  TSgtsRbkObjectsIface,'OBJECT_NAME','NAME','OBJECT_ID',true);
      AddEditLink('DRAWING_ID','EditDrawing','LabelDrawing','ButtonDrawing',
                  TSgtsRbkDrawingsIface,'DRAWING_NAME','NAME','DRAWING_ID',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkObjectDrawingUpdateIface }

procedure TSgtsRbkObjectDrawingUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkObjectDrawingEditForm;
  InterfaceName:=SInterfaceObjectDrawingUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateObjectDrawing;
    with ExecuteDefs do begin
      AddEditLink('OBJECT_ID','EditObject','LabelObject','ButtonObject',
                  TSgtsRbkObjectsIface,'OBJECT_NAME','NAME','OBJECT_ID',true,true);
      AddEditLink('DRAWING_ID','EditDrawing','LabelDrawing','ButtonDrawing',
                  TSgtsRbkDrawingsIface,'DRAWING_NAME','NAME','DRAWING_ID',true,true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkObjectDrawingDeleteIface }

procedure TSgtsRbkObjectDrawingDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceObjectDrawingDelete;
  DeleteQuestion:='Удалить чертеж: %DRAWING_NAME у объекта: %OBJECT_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteObjectDrawing;
    with ExecuteDefs do begin
      AddKeyLink('OBJECT_ID');
      AddKeyLink('DRAWING_ID');
      AddInvisible('OBJECT_NAME');
      AddInvisible('DRAWING_NAME');
    end;
  end;
end;

end.
