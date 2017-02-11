unit SgtsRbkPersonnelsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsSelectDefs, 
  SgtsCoreIntf, StdCtrls;

type
  TSgtsRbkPersonnelsForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkPersonnelsIface=class(TSgtsDataGridIface)
  private
    function GetPersonnelName(Def: TSgtsSelectDef): Variant;
  public
    procedure Init; override;
  end;

  TSgtsRbkPersonnelOnlyPerformersIface=class(TSgtsRbkPersonnelsIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkPersonnelsForm: TSgtsRbkPersonnelsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsRbkPersonnelEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkPersonnelsIface }

procedure TSgtsRbkPersonnelsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPersonnelsForm;
  InterfaceName:=SInterfacePersonnel;
  InsertClass:=TSgtsRbkPersonnelInsertIface;
  UpdateClass:=TSgtsRbkPersonnelUpdateIface;
  DeleteClass:=TSgtsRbkPersonnelDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectPersonnels;
    with SelectDefs do begin
      AddKey('PERSONNEL_ID');
      Add('FNAME','Фамилия',130);
      Add('NAME','Имя',100);
      Add('SNAME','Отчество',130);
      Add('DIVISION_NAME','Отдел',200);
      AddCalcInvisible('PERSONNEL_NAME',GetPersonnelName,ftString,250);
      AddInvisible('DIVISION_ID');
      AddInvisible('DATE_ACCEPT');
      AddInvisible('DATE_SACK');
    end;
  end;
end;

function TSgtsRbkPersonnelsIface.GetPersonnelName(Def: TSgtsSelectDef): Variant;
begin
  Result:=Null;
  if DataSet.Active then begin
    Result:=Trim(DataSet.FieldByName('FNAME').AsString+' '+
                 DataSet.FieldByName('NAME').AsString+' '+
                 DataSet.FieldByName('SNAME').AsString);

  end;
end;

{ TSgtsRbkPersonnelOnlyPerformersIface }

procedure TSgtsRbkPersonnelOnlyPerformersIface.Init; 
begin
  inherited Init;
  DataSet.ProviderName:=SProviderSelectPersonnelOnlyPerformers;
end;

{ TSgtsRbkPersonnelForm }

constructor TSgtsRbkPersonnelsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
