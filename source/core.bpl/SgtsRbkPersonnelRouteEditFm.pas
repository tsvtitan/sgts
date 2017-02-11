unit SgtsRbkPersonnelRouteEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsCoreIntf;

type
  TSgtsRbkPersonnelRouteEditForm = class(TSgtsDataEditForm)
    LabelRoute: TLabel;
    EditRoute: TEdit;
    ButtonRoute: TButton;
    LabelPersonnel: TLabel;
    EditPersonnel: TEdit;
    ButtonPersonnel: TButton;
    LabelDeputy: TLabel;
    EditDeputy: TEdit;
    ButtonDeputy: TButton;
    LabelDatePurpose: TLabel;
    DateTimePickerPurpose: TDateTimePicker;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkPersonnelRouteInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkPersonnelRouteUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkPersonnelRouteDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkPersonnelRouteRoleEditForm: TSgtsRbkPersonnelRouteEditForm;

implementation

uses DBClient,
     SgtsGetRecordsConfig,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkPersonnelsFm, SgtsRbkRoutesFm;

{$R *.dfm}

{ TSgtsRbkPersonnelRouteInsertIface }

procedure TSgtsRbkPersonnelRouteInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPersonnelRouteEditForm;
  InterfaceName:=SInterfacePersonnelRouteInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertPersonnelRoute;
    with ExecuteDefs do begin
      AddEditLink('ROUTE_ID','EditRoute','LabelRoute','ButtonRoute',
                  TSgtsRbkRoutesIface,'ROUTE_NAME','NAME','ROUTE_ID',true);
      AddEditLink('PERSONNEL_ID','EditPersonnel','LabelPersonnel','ButtonPersonnel',
                  TSgtsRbkPersonnelOnlyPerformersIface,'PERSONNEL_NAME','','',true);
      AddEditLink('DEPUTY_ID','EditDeputy','LabelDeputy','ButtonDeputy',
                  TSgtsRbkPersonnelOnlyPerformersIface,'DEPUTY_NAME','PERSONNEL_NAME','PERSONNEL_ID');
      AddDate('DATE_PURPOSE','DateTimePickerPurpose','LabelDatePurpose',true);
    end;
  end;
end;

{ TSgtsRbkPersonnelRouteUpdateIface }

procedure TSgtsRbkPersonnelRouteUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPersonnelRouteEditForm;
  InterfaceName:=SInterfacePersonnelRouteUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdatePersonnelRoute;
    with ExecuteDefs do begin
      AddEditLink('ROUTE_ID','EditRoute','LabelRoute','ButtonRoute',
                  TSgtsRbkRoutesIface,'ROUTE_NAME','NAME','ROUTE_ID',true,true);
      AddEditLink('PERSONNEL_ID','EditPersonnel','LabelPersonnel','ButtonPersonnel',
                  TSgtsRbkPersonnelOnlyPerformersIface,'PERSONNEL_NAME','','',true,true);
      AddEditLink('DEPUTY_ID','EditDeputy','LabelDeputy','ButtonDeputy',
                  TSgtsRbkPersonnelOnlyPerformersIface,'DEPUTY_NAME','PERSONNEL_NAME','PERSONNEL_ID');
      AddDate('DATE_PURPOSE','DateTimePickerPurpose','LabelDatePurpose',true);
    end;
  end;
end;

{ TSgtsRbkPersonnelRouteDeleteIface }

procedure TSgtsRbkPersonnelRouteDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfacePersonnelRouteDelete;
  DeleteQuestion:='Удалить маршрут: %ROUTE_NAME у персоны %PERSONNEL_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeletePersonnelRoute;
    with ExecuteDefs do begin
      AddKeyLink('ROUTE_ID');
      AddKeyLink('PERSONNEL_ID');
      AddInvisible('ROUTE_NAME');
      AddInvisible('PERSONNEL_NAME');
    end;
  end;
end;

{ TSgtsRbkPersonnelRouteEditForm }

constructor TSgtsRbkPersonnelRouteEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  DateTimePickerPurpose.Date:=Date;
end;

end.
