unit SgtsRbkAlgorithmsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ExtCtrls, ComCtrls, ToolWin,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsCDS,
  SgtsCoreIntf, StdCtrls, DBCtrls, Grids, DBGrids;

type
  TSgtsRbkAlgorithmsForm = class(TSgtsDataGridForm)
    PanelInfo: TPanel;
    GroupBoxInfo: TGroupBox;
    PanelNote: TPanel;
    DBMemoNote: TDBMemo;
    Splitter: TSplitter;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkAlgorithmsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkAlgorithmsForm: TSgtsRbkAlgorithmsForm;

implementation

uses SgtsProviderConsts, SgtsIface, SgtsConsts, SgtsRbkAlgorithmEditFm,
     SgtsSelectDefs, SgtsGetRecordsConfig;

{$R *.dfm}

{ TSgtsRbkAlgorithmsIface }

procedure TSgtsRbkAlgorithmsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkAlgorithmsForm;
  InterfaceName:=SInterfaceAlgorithms;
  InsertClass:=TSgtsRbkAlgorithmInsertIface;
  UpdateClass:=TSgtsRbkAlgorithmUpdateIface;
  DeleteClass:=TSgtsRbkAlgorithmDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectAlgorithms;
    with SelectDefs do begin
      AddKey('ALGORITHM_ID');
      Add('NAME','Наименование',200);
      Add('PROC_NAME','Имя процедуры',150);
      AddInvisible('DESCRIPTION');
    end;
    Orders.Add('NAME',otAsc);
  end;
end;

{ TSgtsRbkAlgorithmsForm }

constructor TSgtsRbkAlgorithmsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
