unit SgtsRbkGraphEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsCoreIntf;

type
  TSgtsRbkGraphEditForm = class(TSgtsDataEditForm)
    LabelCut: TLabel;
    EditCut: TEdit;
    ButtonCut: TButton;
    LabelDescription: TLabel;
    MemoDescription: TMemo;
    GroupBoxDetermination: TGroupBox;
    PanelDetermination: TPanel;
    MemoDetermination: TMemo;
    LabelName: TLabel;
    EditName: TEdit;
    LabelDetermination: TLabel;
    ComboBoxGraphType: TComboBox;
    LabelGraphType: TLabel;
    LabelMenu: TLabel;
    EditMenu: TEdit;
    LabelPriority: TLabel;
    EditPriority: TEdit;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkGraphInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
    procedure Insert; override;
  end;

  TSgtsRbkGraphUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
    procedure Update; override;
  end;

  TSgtsRbkGraphDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
    procedure Delete; override;
  end;

var
  SgtsRbkGraphEditForm: TSgtsRbkGraphEditForm;

implementation

uses DBClient, DateUtils,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkCutsFm, SgtsCoreObj;

{$R *.dfm}

{ TSgtsRbkGraphInsertIface }

procedure TSgtsRbkGraphInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkGraphEditForm;
  InterfaceName:=SInterfaceGraphInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertGraph;
    with ExecuteDefs do begin
      AddKey('GRAPH_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddComboInteger('GRAPH_TYPE','ComboBoxGraphType','LabelGraphType',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddEditLink('CUT_ID','EditCut','LabelCut','ButtonCut',
                  TSgtsRbkCutsIface,'CUT_NAME','NAME','CUT_ID',true,false);
      AddMemo('DETERMINATION','MemoDetermination','LabelDetermination',false);
      AddEdit('MENU','EditMenu','LabelMenu',false);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

procedure TSgtsRbkGraphInsertIface.Insert; 
begin
  inherited Insert;
  CoreIntf.RefreshGraphs;
end;

{ TSgtsRbkGraphUpdateIface }

procedure TSgtsRbkGraphUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkGraphEditForm;
  InterfaceName:=SInterfaceGraphUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateGraph;
    with ExecuteDefs do begin
      AddKeyLink('GRAPH_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddComboInteger('GRAPH_TYPE','ComboBoxGraphType','LabelGraphType',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddEditLink('CUT_ID','EditCut','LabelCut','ButtonCut',
                  TSgtsRbkCutsIface,'CUT_NAME','NAME','CUT_ID',true,false);
      AddMemo('DETERMINATION','MemoDetermination','LabelDetermination',false);
      AddEdit('MENU','EditMenu','LabelMenu',false);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

procedure TSgtsRbkGraphUpdateIface.Update; 
begin
  inherited Update;
  CoreIntf.RefreshGraphs;
end;

{ TSgtsRbkGraphDeleteIface }

procedure TSgtsRbkGraphDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceGraphDelete;
  DeleteQuestion:='Удалить текущий график?';
  with DataSet do begin
    ProviderName:=SProviderDeleteGraph;
    with ExecuteDefs do begin
      AddKeyLink('GRAPH_ID');
    end;
  end;
end;

procedure TSgtsRbkGraphDeleteIface.Delete;
begin
  inherited Delete;
  CoreIntf.RefreshGraphs;
end;

{ TSgtsRbkGraphEditForm }

constructor TSgtsRbkGraphEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;

end.
