unit SgtsRbkCutEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsCoreIntf;

type
  TSgtsRbkCutEditForm = class(TSgtsDataEditForm)
    LabelMeasureType: TLabel;
    EditMeasureType: TEdit;
    ButtonMeasureType: TButton;
    LabelViewName: TLabel;
    LabelDescription: TLabel;
    EditViewName: TEdit;
    MemoDescription: TMemo;
    GroupBoxDetermination: TGroupBox;
    PanelDetermination: TPanel;
    MemoDetermination: TMemo;
    LabelName: TLabel;
    EditName: TEdit;
    LabelDetermination: TLabel;
    LabelCondition: TLabel;
    EditCondition: TEdit;
    LabelProcName: TLabel;
    EditProcName: TEdit;
    LabelPriority: TLabel;
    EditPriority: TEdit;
    LabelObject: TLabel;
    MemoObject: TMemo;
    ButtonObject: TButton;
    LabelCutType: TLabel;
    ComboBoxCutType: TComboBox;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkCutInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkCutUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
    procedure Update; override;
  end;

  TSgtsRbkCutDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkCutRoleEditForm: TSgtsRbkCutEditForm;

implementation

uses DBClient, DateUtils,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkMeasureTypesFm, SgtsRbkObjectsFm, SgtsCoreObj;

{$R *.dfm}

{ TSgtsRbkCutInsertIface }

procedure TSgtsRbkCutInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkCutEditForm;
  InterfaceName:=SInterfaceCutInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertCut;
    with ExecuteDefs do begin
      AddKey('CUT_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddComboInteger('CUT_TYPE','ComboBoxCutType','LabelCutType',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddEditLink('MEASURE_TYPE_ID','EditMeasureType','LabelMeasureType','ButtonMeasureType',
                  TSgtsRbkMeasureTypesIface,'MEASURE_TYPE_NAME','NAME','MEASURE_TYPE_ID',false,false);
      AddMemoLink('OBJECT_ID','MemoObject','LabelObject','ButtonObject',
                  TSgtsRbkObjectsIface,'OBJECT_NAME','NAME','OBJECT_ID',false,false);
      AddEdit('VIEW_NAME','EditViewName','LabelViewName',true);
      AddEdit('PROC_NAME','EditProcName','LabelProcName',false);
      AddMemo('DETERMINATION','MemoDetermination','LabelDetermination',true);
      AddEdit('CONDITION','EditCondition','LabelCondition',false);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkCutUpdateIface }

procedure TSgtsRbkCutUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkCutEditForm;
  InterfaceName:=SInterfaceCutUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateCut;
    with ExecuteDefs do begin
      AddKeyLink('CUT_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddComboInteger('CUT_TYPE','ComboBoxCutType','LabelCutType',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddEditLink('MEASURE_TYPE_ID','EditMeasureType','LabelMeasureType','ButtonMeasureType',
                  TSgtsRbkMeasureTypesIface,'MEASURE_TYPE_NAME','NAME','MEASURE_TYPE_ID',false,false);
      AddMemoLink('OBJECT_ID','MemoObject','LabelObject','ButtonObject',
                  TSgtsRbkObjectsIface,'OBJECT_NAME','NAME','OBJECT_ID',false,false);
      AddEdit('VIEW_NAME','EditViewName','LabelViewName',true);
      AddEdit('PROC_NAME','EditProcName','LabelProcName',false);
      AddMemo('DETERMINATION','MemoDetermination','LabelDetermination',true);
      AddEdit('CONDITION','EditCondition','LabelCondition',false);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

procedure TSgtsRbkCutUpdateIface.Update; 
begin
  inherited Update;
  CoreIntf.RefreshGraphs;
end;

{ TSgtsRbkCutDeleteIface }

procedure TSgtsRbkCutDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceCutDelete;
  DeleteQuestion:='Удалить текущий срез?';
  with DataSet do begin
    ProviderName:=SProviderDeleteCut;
    with ExecuteDefs do begin
      AddKeyLink('CUT_ID');
    end;
  end;      
end;

{ TSgtsRbkCutEditForm }

constructor TSgtsRbkCutEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;

end.
