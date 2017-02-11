unit SgtsRbkRouteEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsExecuteDefs,
  SgtsCoreIntf;

type
  TSgtsRbkRouteEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    LabelDate: TLabel;
    DateTimePicker: TDateTimePicker;
    LabelDescription: TLabel;
    MemoDescription: TMemo;
    CheckBoxIsActive: TCheckBox;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkRouteInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkRouteUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkRouteDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkRouteEditForm: TSgtsRbkRouteEditForm;

implementation

uses DBClient, DB,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, 
     SgtsRbkDivisionsFm;

{$R *.dfm}

{ TSgtsRbkRouteInsertIface }

procedure TSgtsRbkRouteInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkRouteEditForm;
  InterfaceName:=SInterfaceRouteInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertRoute;
    with ExecuteDefs do begin
      AddKey('ROUTE_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddDate('DATE_ROUTE','DateTimePicker','LabelDate',true);
      AddCheck('IS_ACTIVE','CheckBoxIsActive');
      AddInvisible('IS_ACTIVE_EX',ptUnknown);
    end;
  end;
end;

{ TSgtsRbkRouteUpdateIface }

procedure TSgtsRbkRouteUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkRouteEditForm;
  InterfaceName:=SInterfaceRouteUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateRoute;
    with ExecuteDefs do begin
      AddKeyLink('ROUTE_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddDate('DATE_ROUTE','DateTimePicker','LabelDate',true);
      AddCheck('IS_ACTIVE','CheckBoxIsActive');
      AddInvisible('IS_ACTIVE_EX',ptUnknown);
    end;
  end;
end;

{ TSgtsRbkRouteDeleteIface }

procedure TSgtsRbkRouteDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceRouteDelete;
  DeleteQuestion:='Удалить маршрут %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteRoute;
    with ExecuteDefs do begin
      AddKeyLink('ROUTE_ID');
      AddInvisible('NAME',ptUnknown);
    end;
  end;
end;

{ TSgtsRbkRouteEditForm }

constructor TSgtsRbkRouteEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  DateTimePicker.Date:=Date;
end;

end.
