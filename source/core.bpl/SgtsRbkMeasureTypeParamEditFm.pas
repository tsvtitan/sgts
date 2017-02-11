unit SgtsRbkMeasureTypeParamEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkMeasureTypeParamEditForm = class(TSgtsDataEditForm)
    LabelMeasureType: TLabel;
    EditMeasureType: TEdit;
    ButtonMeasureType: TButton;
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

  TSgtsRbkMeasureTypeParamInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkMeasureTypeParamUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkMeasureTypeParamDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkMeasureTypeParamRoleEditForm: TSgtsRbkMeasureTypeParamEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkParamsFm, SgtsRbkMeasureTypesFm;

{$R *.dfm}

{ TSgtsRbkMeasureTypeParamInsertIface }

procedure TSgtsRbkMeasureTypeParamInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkMeasureTypeParamEditForm;
  InterfaceName:=SInterfaceMeasureTypeParamInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertMeasureTypeParam;
    with ExecuteDefs do begin
      AddEditLink('MEASURE_TYPE_ID','EditMeasureType','LabelMeasureType','ButtonMeasureType',
                  TSgtsRbkMeasureTypesIface,'MEASURE_TYPE_NAME','NAME','MEASURE_TYPE_ID',true);
      AddEditLink('PARAM_ID','EditParam','LabelParam','ButtonParam',
                  TSgtsRbkParamsIface,'PARAM_NAME','NAME','PARAM_ID',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkMeasureTypeParamUpdateIface }

procedure TSgtsRbkMeasureTypeParamUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkMeasureTypeParamEditForm;
  InterfaceName:=SInterfaceMeasureTypeParamUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateMeasureTypeParam;
    with ExecuteDefs do begin
      AddEditLink('MEASURE_TYPE_ID','EditMeasureType','LabelMeasureType','ButtonMeasureType',
                  TSgtsRbkMeasureTypesIface,'MEASURE_TYPE_NAME','NAME','MEASURE_TYPE_ID',true,true);
      AddEditLink('PARAM_ID','EditParam','LabelParam','ButtonParam',
                  TSgtsRbkParamsIface,'PARAM_NAME','NAME','PARAM_ID',true,true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkMeasureTypeParamDeleteIface }

procedure TSgtsRbkMeasureTypeParamDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceMeasureTypeParamDelete;
  DeleteQuestion:='Удалить параметр: %PARAM_NAME у вида измерения %MEASURE_TYPE_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteMeasureTypeParam;
    with ExecuteDefs do begin
      AddKeyLink('MEASURE_TYPE_ID');
      AddKeyLink('PARAM_ID');
      AddInvisible('MEASURE_TYPE_NAME');
      AddInvisible('PARAM_NAME');
    end;
  end;
end;

end.
