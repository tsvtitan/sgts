unit SgtsGraphRefreshFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  SgtsDialogFm, SgtsFm, SgtsCoreIntf, SgtsGraphIfaceIntf, SgtsIface;

type
  TSgtsGraphRefreshForm = class(TSgtsDialogForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsGraphRefreshIface=class(TSgtsDialogIface)
  private
    FParentIface: TSgtsIface;
  protected
    function GetFormClass: TSgtsFormClass; override;
  public
    constructor Create(ACoreIntf: ISgtsCore; AParentIface: TSgtsIface); reintroduce; virtual;

    property ParentIface: TSgtsIface read FParentIface;
  end;

  TSgtsGraphRefreshIfaceClass=class of TSgtsGraphRefreshIface;

var
  SgtsGraphRefreshForm: TSgtsGraphRefreshForm;

implementation

{$R *.dfm}

{ TSgtsGraphRefreshIface }

constructor TSgtsGraphRefreshIface.Create(ACoreIntf: ISgtsCore; AParentIface: TSgtsIface);
begin
  inherited Create(ACoreIntf);
  FParentIface:=AParentIface;
end;

function TSgtsGraphRefreshIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsGraphRefreshForm;
end;

end.
