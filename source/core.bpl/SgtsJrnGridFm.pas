unit SgtsJrnGridFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, Grids, DBGrids, ExtCtrls, StdCtrls,
  ComCtrls, ToolWin, SgtsDataGridFm, SgtsFm, SgtsControls;

type
  TSgtsJrnGridForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;


  TSgtsJrnGridIface=class(TSgtsDataGridIface)
  private
    function GetForm: TSgtsJrnGridForm;
  protected
    function GetFormClass: TSgtsFormClass; override;
  public

    property Form: TSgtsJrnGridForm read GetForm;
  end;

var
  SgtsJrnGridForm: TSgtsJrnGridForm;

implementation

{$R *.dfm}

{ TSgtsJrnGridIface }

function TSgtsJrnGridIface.GetForm: TSgtsJrnGridForm;
begin
  Result:=TSgtsJrnGridForm(inherited Form);
end;

function TSgtsJrnGridIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsJrnGridForm;
end;

end.
