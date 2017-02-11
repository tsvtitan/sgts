unit SgtsRbkGroupObjectEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkGroupObjectEditForm = class(TSgtsDataEditForm)
    LabelObject: TLabel;
    EditObject: TEdit;
    ButtonObject: TButton;
    LabelGroup: TLabel;
    EditGroup: TEdit;
    ButtonGroup: TButton;
    LabelPriority: TLabel;
    EditPriority: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkGroupObjectInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkGroupObjectUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkGroupObjectDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkGroupObjectRoleEditForm: TSgtsRbkGroupObjectEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkGroupsFm, SgtsRbkObjectsFm;

{$R *.dfm}

{ TSgtsRbkGroupObjectInsertIface }

procedure TSgtsRbkGroupObjectInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkGroupObjectEditForm;
  InterfaceName:=SInterfaceGroupObjectInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertGroupObject;
    with ExecuteDefs do begin
      AddEditLink('GROUP_ID','EditGroup','LabelGroup','ButtonGroup',
                  TSgtsRbkGroupsIface,'GROUP_NAME','NAME','GROUP_ID',true);
      AddEditLink('OBJECT_ID','EditObject','LabelObject','ButtonObject',
                  TSgtsRbkObjectsIface,'OBJECT_NAME','NAME','OBJECT_ID',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkGroupObjectUpdateIface }

procedure TSgtsRbkGroupObjectUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkGroupObjectEditForm;
  InterfaceName:=SInterfaceGroupObjectUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateGroupObject;
    with ExecuteDefs do begin
      AddEditLink('GROUP_ID','EditGroup','LabelGroup','ButtonGroup',
                  TSgtsRbkGroupsIface,'GROUP_NAME','NAME','GROUP_ID',true,true);
      AddEditLink('OBJECT_ID','EditObject','LabelObject','ButtonObject',
                  TSgtsRbkObjectsIface,'OBJECT_NAME','NAME','OBJECT_ID',true,true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkGroupObjectDeleteIface }

procedure TSgtsRbkGroupObjectDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceGroupObjectDelete;
  DeleteQuestion:='Удалить объект: %OBJECT_NAME у группы: %GROUP_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteGroupObject;
    with ExecuteDefs do begin
      AddKeyLink('GROUP_ID');
      AddKeyLink('OBJECT_ID');
      AddInvisible('GROUP_NAME');
      AddInvisible('OBJECT_NAME');
    end;
  end;
end;

end.
