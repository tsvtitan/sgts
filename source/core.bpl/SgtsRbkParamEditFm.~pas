unit SgtsRbkParamEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsExecuteDefs;

type
  TSgtsRbkParamType=(ptIntroduced,ptIntegral,ptDerived,ptIntegralInvisible);

  TSgtsRbkParamEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    LabelDescription: TLabel;
    MemoDescription: TMemo;
    LabelParamType: TLabel;
    ComboBoxParamType: TComboBox;
    LabelAlgorithm: TLabel;
    EditAlgorithm: TEdit;
    ButtonAlgorithm: TButton;
    LabelFormat: TLabel;
    EditFormat: TEdit;
    GroupBoxDetermination: TGroupBox;
    PanelDetermination: TPanel;
    LabelDetermination: TLabel;
    MemoDetermination: TMemo;
    CheckBoxIsNotConfirm: TCheckBox;
    procedure ComboBoxParamTypeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkParamInsertIface=class(TSgtsDataInsertIface)
  private
    FAlgorithmDef: TSgtsExecuteDefEditLink;
  public
    procedure Init; override;
    property AlgorithmDef: TSgtsExecuteDefEditLink read FAlgorithmDef;
  end;

  TSgtsRbkParamUpdateIface=class(TSgtsDataUpdateIface)
  private
    FAlgorithmDef: TSgtsExecuteDefEditLink;
  public
    procedure Init; override;
    property AlgorithmDef: TSgtsExecuteDefEditLink read FAlgorithmDef;
  end;

  TSgtsRbkParamDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkParamEditForm: TSgtsRbkParamEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs,
     SgtsRbkInstrumentsFm, SgtsRbkMeasureUnitsFm, SgtsRbkAlgorithmsFm;

{$R *.dfm}

{ TSgtsRbkParamInsertIface }

procedure TSgtsRbkParamInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkParamEditForm;
  InterfaceName:=SInterfaceParamInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertParam;
    with ExecuteDefs do begin
      AddKey('PARAM_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddEdit('FORMAT','EditFormat','LabelFormat',false);
      AddComboInteger('PARAM_TYPE','ComboBoxParamType','LabelParamType',true);
      FAlgorithmDef:=AddEditLink('ALGORITHM_ID','EditAlgorithm','LabelAlgorithm','ButtonAlgorithm',
                                 TSgtsRbkAlgorithmsIface,'ALGORITHM_NAME','NAME','ALGORITHM_ID');
      AddMemo('DETERMINATION','MemoDetermination','LabelDetermination',false);
      AddCheck('IS_NOT_CONFIRM','CheckBoxIsNotConfirm');                                 
    end;
  end;
end;

{ TSgtsRbkParamUpdateIface }

procedure TSgtsRbkParamUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkParamEditForm;
  InterfaceName:=SInterfaceParamUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateParam;
    with ExecuteDefs do begin
      AddKeyLink('PARAM_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddEdit('FORMAT','EditFormat','LabelFormat',false);
      AddComboInteger('PARAM_TYPE','ComboBoxParamType','LabelParamType',true);
      FAlgorithmDef:=AddEditLink('ALGORITHM_ID','EditAlgorithm','LabelAlgorithm','ButtonAlgorithm',
                                 TSgtsRbkAlgorithmsIface,'ALGORITHM_NAME','NAME','ALGORITHM_ID');
      AddMemo('DETERMINATION','MemoDetermination','LabelDetermination',false);                                 
      AddCheck('IS_NOT_CONFIRM','CheckBoxIsNotConfirm');                                 
    end;
  end;
end;

{ TSgtsRbkParamDeleteIface }

procedure TSgtsRbkParamDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceParamDelete;
  DeleteQuestion:='Удалить параметр %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteParam;
    with ExecuteDefs do begin
      AddKeyLink('PARAM_ID');
      AddInvisible('NAME');
    end;
  end;
end;

{ TSgtsRbkInsertParamForm }

procedure TSgtsRbkParamEditForm.ComboBoxParamTypeChange(Sender: TObject);
{var
  AlgorithmDef: TSgtsExecuteDefEditLink;}
begin
{  AlgorithmDef:=nil;
  if Iface is TSgtsRbkParamInsertIface then
    AlgorithmDef:=TSgtsRbkParamInsertIface(Iface).AlgorithmDef;
  if Iface is TSgtsRbkParamUpdateIface then
    AlgorithmDef:=TSgtsRbkParamUpdateIface(Iface).AlgorithmDef;

  case TSgtsRbkParamType(ComboBoxParamType.ItemIndex) of
    ptIntegral,ptDerived: begin
      LabelAlgorithm.Enabled:=true;
      EditAlgorithm.Enabled:=true;
      ButtonAlgorithm.Enabled:=true;
      if Assigned(AlgorithmDef) then
        AlgorithmDef.Link.Required:=true;
    end;
    else begin
      LabelAlgorithm.Enabled:=false;
      EditAlgorithm.Enabled:=false;
      ButtonAlgorithm.Enabled:=false;
      if Assigned(AlgorithmDef) then
        AlgorithmDef.Link.Required:=false;
    end;
  end;}
end;

end.
