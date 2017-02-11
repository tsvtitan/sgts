unit SgtsRbkParamInstrumentEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkParamInstrumentEditForm = class(TSgtsDataEditForm)
    LabelInstrument: TLabel;
    EditInstrument: TEdit;
    ButtonInstrument: TButton;
    LabelParam: TLabel;
    EditParam: TEdit;
    ButtonParam: TButton;
    LabelPriority: TLabel;
    EditPriority: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkParamInstrumentInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkParamInstrumentUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkParamInstrumentDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkParamInstrumentRoleEditForm: TSgtsRbkParamInstrumentEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkParamsFm, SgtsRbkInstrumentsFm;

{$R *.dfm}

{ TSgtsRbkParamInstrumentInsertIface }

procedure TSgtsRbkParamInstrumentInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkParamInstrumentEditForm;
  InterfaceName:=SInterfaceParamInstrumentInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertParamInstrument;
    with ExecuteDefs do begin
      AddEditLink('PARAM_ID','EditParam','LabelParam','ButtonParam',
                  TSgtsRbkParamsIface,'PARAM_NAME','NAME','PARAM_ID',true);
      AddEditLink('INSTRUMENT_ID','EditInstrument','LabelInstrument','ButtonInstrument',
                  TSgtsRbkInstrumentsIface,'INSTRUMENT_NAME','NAME','INSTRUMENT_ID',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkParamInstrumentUpdateIface }

procedure TSgtsRbkParamInstrumentUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkParamInstrumentEditForm;
  InterfaceName:=SInterfaceParamInstrumentUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateParamInstrument;
    with ExecuteDefs do begin
      AddEditLink('PARAM_ID','EditParam','LabelParam','ButtonParam',
                  TSgtsRbkParamsIface,'PARAM_NAME','NAME','PARAM_ID',true,true);
      AddEditLink('INSTRUMENT_ID','EditInstrument','LabelInstrument','ButtonInstrument',
                  TSgtsRbkInstrumentsIface,'INSTRUMENT_NAME','NAME','INSTRUMENT_ID',true,true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkParamInstrumentDeleteIface }

procedure TSgtsRbkParamInstrumentDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceParamInstrumentDelete;
  DeleteQuestion:='Удалить прибор: %INSTRUMENT_NAME у параметра %PARAM_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteParamInstrument;
    with ExecuteDefs do begin
      AddKeyLink('PARAM_ID');
      AddKeyLink('INSTRUMENT_ID');
      AddInvisible('PARAM_NAME');
      AddInvisible('INSTRUMENT_NAME');
    end;
  end;
end;

end.
