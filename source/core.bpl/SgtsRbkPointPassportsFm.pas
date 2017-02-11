unit SgtsRbkPointPassportsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  StdCtrls, Mask, DBCtrls,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsSelectDefs,
  SgtsCoreIntf;

type
  TSgtsRbkPointPassportsForm = class(TSgtsDataGridForm)
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

  TSgtsRbkPointPassportsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkPointPassportsForm: TSgtsRbkPointPassportsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsRbkPointPassportEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkPointPassportsIface }

procedure TSgtsRbkPointPassportsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPointPassportsForm;
  InterfaceName:=SInterfacePointPassports;
  InsertClass:=TSgtsRbkPointPassportInsertIface;
  UpdateClass:=TSgtsRbkPointPassportUpdateIface;
  DeleteClass:=TSgtsRbkPointPassportDeleteIface;  
  with DataSet do begin
    ProviderName:=SProviderSelectPointPassports;
    with SelectDefs do begin
      AddKey('POINT_PASSPORT_ID');
      Add('POINT_NAME','Компонент',150);
      Add('DATE_CHECKUP','Дата осмотра',80);
      AddInvisible('POINT_ID');
      AddInvisible('DESCRIPTION');
    end;
  end;
end;

{ TSgtsRbkPointPassportsForm }

constructor TSgtsRbkPointPassportsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
