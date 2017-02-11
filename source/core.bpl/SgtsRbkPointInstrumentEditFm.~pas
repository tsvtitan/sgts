unit SgtsRbkPointInstrumentEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkPointInstrumentEditForm = class(TSgtsDataEditForm)
    LabelInstrument: TLabel;
    EditInstrument: TEdit;
    ButtonInstrument: TButton;
    LabelPoint: TLabel;
    EditPoint: TEdit;
    ButtonPoint: TButton;
    LabelPriority: TLabel;
    EditPriority: TEdit;
    LabelParam: TLabel;
    EditParam: TEdit;
    ButtonParam: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkPointInstrumentInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkPointInstrumentUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkPointInstrumentDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkPointInstrumentRoleEditForm: TSgtsRbkPointInstrumentEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkPointsFm, SgtsRbkInstrumentsFm, SgtsRbkParamsFm;

{$R *.dfm}

{ TSgtsRbkPointInstrumentInsertIface }

procedure TSgtsRbkPointInstrumentInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPointInstrumentEditForm;
  InterfaceName:=SInterfacePointInstrumentInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertPointInstrument;
    with ExecuteDefs do begin
      AddEditLink('POINT_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',true);
      AddEditLink('PARAM_ID','EditParam','LabelParam','ButtonParam',
                  TSgtsRbkParamsIface,'PARAM_NAME','NAME','PARAM_ID',true);
      AddEditLink('INSTRUMENT_ID','EditInstrument','LabelInstrument','ButtonInstrument',
                  TSgtsRbkInstrumentsIface,'INSTRUMENT_NAME','NAME','INSTRUMENT_ID',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkPointInstrumentUpdateIface }

procedure TSgtsRbkPointInstrumentUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPointInstrumentEditForm;
  InterfaceName:=SInterfacePointInstrumentUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdatePointInstrument;
    with ExecuteDefs do begin
      AddEditLink('POINT_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',true,true);
      AddEditLink('PARAM_ID','EditParam','LabelParam','ButtonParam',
                  TSgtsRbkParamsIface,'PARAM_NAME','NAME','PARAM_ID',true,true);
      AddEditLink('INSTRUMENT_ID','EditInstrument','LabelInstrument','ButtonInstrument',
                  TSgtsRbkInstrumentsIface,'INSTRUMENT_NAME','NAME','INSTRUMENT_ID',true,true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkPointInstrumentDeleteIface }

procedure TSgtsRbkPointInstrumentDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfacePointInstrumentDelete;
  DeleteQuestion:='Удалить прибор %INSTRUMENT_NAME у точки %POINT_NAME с параметром %PARAM_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeletePointInstrument;
    with ExecuteDefs do begin
      AddKeyLink('POINT_ID');
      AddKeyLink('PARAM_ID');
      AddKeyLink('INSTRUMENT_ID');
      AddInvisible('POINT_NAME');
      AddInvisible('PARAM_NAME');
      AddInvisible('INSTRUMENT_NAME');
    end;
  end;
end;

end.
