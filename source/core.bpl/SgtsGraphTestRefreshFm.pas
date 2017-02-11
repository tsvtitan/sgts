unit SgtsGraphTestRefreshFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SgtsGraphRefreshFm, StdCtrls, ExtCtrls;

type
  TSgtsGraphTestRefreshForm = class(TSgtsGraphRefreshForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsGraphTestRefreshIface=class(TSgtsGraphRefreshIface)
  public
    procedure Init; override;
  end;

var
  SgtsGraphTestRefreshForm: TSgtsGraphTestRefreshForm;

implementation

uses SgtsFm;

{$R *.dfm}

{ TSgtsGraphTestRefreshIface }

procedure TSgtsGraphTestRefreshIface.Init; 
begin
  inherited Init;
  FormClass:=TSgtsGraphTestRefreshForm;
end;

end.
