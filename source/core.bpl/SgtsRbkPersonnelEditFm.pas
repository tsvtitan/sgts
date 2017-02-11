unit SgtsRbkPersonnelEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls,
  SgtsCoreIntf;

type
  TSgtsRbkPersonnelEditForm = class(TSgtsDataEditForm)
    LabelFName: TLabel;
    EditFName: TEdit;
    LabelName: TLabel;
    EditName: TEdit;
    LabelSName: TLabel;
    EditSName: TEdit;
    LabelDivision: TLabel;
    EditDivision: TEdit;
    ButtonDivision: TButton;
    LabelDateAccept: TLabel;
    DateTimePickerAccept: TDateTimePicker;
    LabelSack: TLabel;
    DateTimePickerSack: TDateTimePicker;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkPersonnelInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkPersonnelUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkPersonnelDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkPersonnelEditForm: TSgtsRbkPersonnelEditForm;

implementation

uses DBClient, DB,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkDivisionsFm;

{$R *.dfm}

{ TSgtsRbkPersonnelInsertIface }

procedure TSgtsRbkPersonnelInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPersonnelEditForm;
  InterfaceName:=SInterfacePersonnelInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertPersonnel;
    with ExecuteDefs do begin
      AddKey('PERSONNEL_ID');
      AddEdit('FNAME','EditFName','LabelFName',true);
      AddEdit('NAME','EditName','LabelName',true);
      AddEdit('SNAME','EditSName','LabelSName',true);
      AddEditLink('DIVISION_ID','EditDivision','LabelDivision','ButtonDivision',
                  TSgtsRbkDivisionsIface,'DIVISION_NAME','NAME','',false);
      AddDate('DATE_ACCEPT','DateTimePickerAccept','LabelDateAccept',true);
      AddDate('DATE_SACK','DateTimePickerSack','LabelSack',false);
    end;
  end;
end;

{ TSgtsRbkPersonnelUpdateIface }

procedure TSgtsRbkPersonnelUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPersonnelEditForm;
  InterfaceName:=SInterfacePersonnelUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdatePersonnel;
    with ExecuteDefs do begin
      AddKeyLink('PERSONNEL_ID');
      AddEdit('FNAME','EditFName','LabelFName',true);
      AddEdit('NAME','EditName','LabelName',true);
      AddEdit('SNAME','EditSName','LabelSName',true);
      AddEditLink('DIVISION_ID','EditDivision','LabelDivision','ButtonDivision',
                  TSgtsRbkDivisionsIface,'DIVISION_NAME','NAME','',false);
      AddDate('DATE_ACCEPT','DateTimePickerAccept','LabelDateAccept',true);
      AddDate('DATE_SACK','DateTimePickerSack','LabelSack',false);
    end;
  end;
end;

{ TSgtsRbkPersonnelDeleteIface }

procedure TSgtsRbkPersonnelDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfacePersonnelDelete;
  DeleteQuestion:='Удалить персону %FNAME %NAME %SNAME?';
  with DataSet do begin
    ProviderName:=SProviderDeletePersonnel;
    with ExecuteDefs do begin
      AddKeyLink('PERSONNEL_ID');
      AddInvisible('FNAME',ptUnknown);
      AddInvisible('NAME',ptUnknown);
      AddInvisible('SNAME',ptUnknown);
    end;
  end;
end;

{ TSgtsRbkPersonnelEditForm }

constructor TSgtsRbkPersonnelEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  DateTimePickerAccept.Date:=Date;
end;

end.
