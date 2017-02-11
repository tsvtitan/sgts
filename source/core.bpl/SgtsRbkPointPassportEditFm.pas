unit SgtsRbkPointPassportEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsExecuteDefs, SgtsCoreIntf;

type
  TSgtsRbkPointPassportEditForm = class(TSgtsDataEditForm)
    LabelDescription: TLabel;
    MemoDescription: TMemo;
    LabelPoint: TLabel;
    EditPoint: TEdit;
    ButtonPoint: TButton;
    LabelDateCheckup: TLabel;
    DateTimePickerCheckup: TDateTimePicker;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkPointPassportInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkPointPassportUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkPointPassportDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkPointPassportEditForm: TSgtsRbkPointPassportEditForm;

implementation

uses DBClient, DateUtils,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs,
     SgtsRbkPointsFm;

{$R *.dfm}

{ TSgtsRbkPointPassportInsertIface }

procedure TSgtsRbkPointPassportInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPointPassportEditForm;
  InterfaceName:=SInterfacePointPassportInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertPointPassport;
    with ExecuteDefs do begin
      AddKey('POINT_PASSPORT_ID');
      AddEditLink('POINT_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',true);
      AddDate('DATE_CHECKUP','DateTimePickerCheckup','LabelDateCheckup',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
    end;
  end;
end;

{ TSgtsRbkPointPassportUpdateIface }

procedure TSgtsRbkPointPassportUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPointPassportEditForm;
  InterfaceName:=SInterfacePointPassportUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdatePointPassport;
    with ExecuteDefs do begin
      AddKeyLink('POINT_PASSPORT_ID');
      AddEditLink('POINT_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',true);
      AddDate('DATE_CHECKUP','DateTimePickerCheckup','LabelDateCheckup',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
    end;
  end;
end;

{ TSgtsRbkPointPassportDeleteIface }

procedure TSgtsRbkPointPassportDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfacePointPassportDelete;
  DeleteQuestion:='Удалить текущую запись в паспорте?';
  with DataSet do begin
    ProviderName:=SProviderDeletePointPassport;
    with ExecuteDefs do begin
      AddKeyLink('POINT_PASSPORT_ID');
    end;
  end;
end;

{ TSgtsRbkPointPassportEditForm }

constructor TSgtsRbkPointPassportEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  DateTimePickerCheckup.Date:=DateOf(Date);
end;

end.
