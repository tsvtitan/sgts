unit SgtsRbkDivisionsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ExtCtrls, ComCtrls, ToolWin, StdCtrls, DBCtrls,
  SgtsDataTreeFm, SgtsGetRecordsConfig;

type
  TSgtsRbkDivisionsForm = class(TSgtsDataTreeForm)
    PanelInfo: TPanel;
    GroupBoxInfo: TGroupBox;
    PanelNote: TPanel;
    DBMemoDescription: TDBMemo;
    Splitter: TSplitter;
  private                                                                    
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkDivisionsIface=class(TSgtsDataTreeIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkDivisionsForm: TSgtsRbkDivisionsForm;

implementation

uses DBClient, VirtualTrees,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsConsts, SgtsRbkDivisionEditFm, SgtsDataFm;

{$R *.dfm}

{ TSgtsRbkDivisionsIface }

procedure TSgtsRbkDivisionsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkDivisionsForm;
  InterfaceName:=SInterfaceDivisions;
  with InsertClasses do begin
    Add(TSgtsRbkDivisionInsertIface);
    Add(TSgtsRbkDivisionInsertChildIface);
  end;
  UpdateClass:=TSgtsRbkDivisionUpdateIface;
  DeleteClass:=TSgtsRbkDivisionDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectDivisions;
    with SelectDefs do begin
      AddKey('DIVISION_ID');
      Add('NAME','Наименование');
      AddInvisible('DESCRIPTION');
      AddInvisible('PARENT_ID');
      AddInvisible('PRIORITY');
      AddInvisible('PARENT_NAME');
    end;
    KeyFieldName:='DIVISION_ID';
    ViewFieldName:='NAME';
    ParentFieldName:='PARENT_ID';
  end;
end;


{ TSgtsRbkDivisionsForm }


end.
