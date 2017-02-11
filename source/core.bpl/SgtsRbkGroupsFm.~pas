unit SgtsRbkGroupsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ExtCtrls, ComCtrls, ToolWin,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsCDS,
  SgtsCoreIntf, StdCtrls, DBCtrls, Grids, DBGrids;

type
  TSgtsRbkGroupsForm = class(TSgtsDataGridForm)
    PanelInfo: TPanel;
    GroupBoxInfo: TGroupBox;
    PanelNote: TPanel;
    DBMemoDescription: TDBMemo;
    Splitter: TSplitter;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkGroupsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkGroupsForm: TSgtsRbkGroupsForm;

implementation

uses SgtsProviderConsts, SgtsIface, SgtsConsts, SgtsRbkGroupEditFm,
     SgtsSelectDefs, SgtsDatabaseCDS;

{$R *.dfm}

{ TSgtsRbkGroupsIface }

procedure TSgtsRbkGroupsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkGroupsForm;
  InterfaceName:=SInterfaceGroups;
  InsertClass:=TSgtsRbkGroupInsertIface;
  UpdateClass:=TSgtsRbkGroupUpdateIface;
  DeleteClass:=TSgtsRbkGroupDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectGroups;
    with SelectDefs do begin
      AddKey('GROUP_ID');
      Add('NAME','Наименование');
      AddInvisible('DESCRIPTION');
    end;
  end;
end;

{ TSgtsRbkGroupsForm }

constructor TSgtsRbkGroupsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
