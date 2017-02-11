unit SgtsRbkParamLevelEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkParamLevelEditForm = class(TSgtsDataEditForm)
    LabelParam: TLabel;
    EditParam: TEdit;
    ButtonParam: TButton;
    LabelLevel: TLabel;
    EditLevel: TEdit;
    ButtonLevel: TButton;
    LabelMin: TLabel;
    EditMin: TEdit;
    LabelMax: TLabel;
    EditMax: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkParamLevelInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkParamLevelUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkParamLevelDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkParamLevelRoleEditForm: TSgtsRbkParamLevelEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkLevelsFm, SgtsRbkParamsFm;

{$R *.dfm}

{ TSgtsRbkParamLevelInsertIface }

procedure TSgtsRbkParamLevelInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkParamLevelEditForm;
  InterfaceName:=SInterfaceParamLevelInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertParamLevel;
    with ExecuteDefs do begin
      AddEditLink('PARAM_ID','EditParam','LabelParam','ButtonParam',
                  TSgtsRbkParamsIface,'PARAM_NAME','NAME','PARAM_ID',true);
      AddEditLink('LEVEL_ID','EditLevel','LabelLevel','ButtonLevel',
                  TSgtsRbkLevelsIface,'LEVEL_NAME','NAME','LEVEL_ID',true);
      AddEditFloat('LEVEL_MIN','EditMin','LabelMin',true);                  
      AddEditFloat('LEVEL_MAX','EditMax','LabelMax',true);                  
    end;
  end;
end;

{ TSgtsRbkParamLevelUpdateIface }

procedure TSgtsRbkParamLevelUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkParamLevelEditForm;
  InterfaceName:=SInterfaceParamLevelUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateParamLevel;
    with ExecuteDefs do begin
      AddEditLink('PARAM_ID','EditParam','LabelParam','ButtonParam',
                  TSgtsRbkParamsIface,'PARAM_NAME','NAME','PARAM_ID',true,true);
      AddEditLink('LEVEL_ID','EditLevel','LabelLevel','ButtonLevel',
                  TSgtsRbkLevelsIface,'LEVEL_NAME','NAME','LEVEL_ID',true,true);
      AddEditFloat('LEVEL_MIN','EditMin','LabelMin',true);                  
      AddEditFloat('LEVEL_MAX','EditMax','LabelMax',true);                  
    end;
  end;
end;

{ TSgtsRbkParamLevelDeleteIface }

procedure TSgtsRbkParamLevelDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceParamLevelDelete;
  DeleteQuestion:='Удалить уровень: %LEVEL_NAME у параметра %PARAM_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteParamLevel;
    with ExecuteDefs do begin
      AddKeyLink('PARAM_ID');
      AddKeyLink('LEVEL_ID');
      AddInvisible('PARAM_NAME');
      AddInvisible('LEVEL_NAME');
    end;
  end;
end;

end.
