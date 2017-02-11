unit SgtsRbkComponentEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsExecuteDefs;

type
  TSgtsRbkComponentEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    LabelDescription: TLabel;
    MemoDescription: TMemo;
    LabelConverter: TLabel;
    EditConverter: TEdit;
    ButtonConverter: TButton;
    LabelParam: TLabel;
    EditParam: TEdit;
    ButtonParam: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkComponentInsertIface=class(TSgtsDataInsertIface)
  private
    procedure ParamSelect(Def: TSgtsExecuteDefEditLink);
  public
    procedure Init; override;
  end;

  TSgtsRbkComponentUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkComponentDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkComponentEditForm: TSgtsRbkComponentEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs,
     SgtsRbkParamsFm, SgtsRbkConvertersFm;

{$R *.dfm}

{ TSgtsRbkComponentInsertIface }

procedure TSgtsRbkComponentInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkComponentEditForm;
  InterfaceName:=SInterfaceComponentInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertComponent;
    with ExecuteDefs do begin
      AddKey('COMPONENT_ID');
      AddEditLink('CONVERTER_ID','EditConverter','LabelConverter','ButtonConverter',
                  TSgtsRbkConvertersIface,'CONVERTER_NAME','NAME','CONVERTER_ID',true);
      AddEditLink('PARAM_ID','EditParam','LabelParam','ButtonParam',
                  TSgtsRbkParamsIface,'PARAM_NAME','NAME','PARAM_ID',true).OnSelect:=ParamSelect;
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
    end;
  end;
end;

procedure TSgtsRbkComponentInsertIface.ParamSelect(Def: TSgtsExecuteDefEditLink);
var
  S1, S2: String;
begin
  with DataSet.ExecuteDefs do begin
    S1:=VarToStrDef(Def.Link.Value,'');
    S2:=VarToStrDef(TSgtsExecuteDefEditLink(Find('CONVERTER_ID')).Link.Value,'');
    Find('NAME').Value:=Format('%s. %s',[S1,S2]);
  end;  
end;

{ TSgtsRbkComponentUpdateIface }

procedure TSgtsRbkComponentUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkComponentEditForm;
  InterfaceName:=SInterfaceComponentUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateComponent;
    with ExecuteDefs do begin
      AddKeyLink('COMPONENT_ID');
      AddEditLink('CONVERTER_ID','EditConverter','LabelConverter','ButtonConverter',
                  TSgtsRbkConvertersIface,'CONVERTER_NAME','NAME','CONVERTER_ID',true);
      AddEditLink('PARAM_ID','EditParam','LabelParam','ButtonParam',
                  TSgtsRbkParamsIface,'PARAM_NAME','NAME','PARAM_ID',true);
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
    end;
  end;
end;

{ TSgtsRbkComponentDeleteIface }

procedure TSgtsRbkComponentDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceComponentDelete;
  DeleteQuestion:='Удалить компонент %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteComponent;
    with ExecuteDefs do begin
      AddKeyLink('COMPONENT_ID');
      AddInvisible('NAME');
    end;
  end;
end;

{ TSgtsRbkInsertComponentForm }

end.
