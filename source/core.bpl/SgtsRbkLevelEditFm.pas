unit SgtsRbkLevelEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls, DB,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkLevelEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    MemoNote: TMemo;
    LabelNote: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkLevelInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkLevelUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkLevelDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkLevelEditForm: TSgtsRbkLevelEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs;

{$R *.dfm}

{ TSgtsRbkLevelInsertIface }

procedure TSgtsRbkLevelInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkLevelEditForm;
  InterfaceName:=SInterfaceLevelInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertLevel;
    with ExecuteDefs do begin
      AddKey('LEVEL_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
    end;
  end;
end;

{ TSgtsRbkLevelUpdateIface }

procedure TSgtsRbkLevelUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkLevelEditForm;
  InterfaceName:=SInterfaceLevelUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateLevel;
    with ExecuteDefs do begin
      AddKeyLink('LEVEL_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
    end;
  end;
end;

{ TSgtsRbkLevelDeleteIface }

procedure TSgtsRbkLevelDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceLevelDelete;
  DeleteQuestion:='Удалить уровень %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteLevel;
    with ExecuteDefs do begin
      AddKeyLink('LEVEL_ID');
      AddInvisible('NAME').ParamType:=ptUnknown;
    end;
  end;
end;

end.
