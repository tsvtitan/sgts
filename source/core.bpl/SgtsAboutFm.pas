unit SgtsAboutFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg,
  SgtsDialogFm, SgtsFm,
  SgtsAboutFmIntf, SgtsCoreIntf;

type
  TSgtsAboutForm = class(TSgtsDialogForm)
    Image: TImage;
    BevelBottom: TBevel;
    LabelCorporation: TLabel;
    LabelPermissions: TLabel;
    LabelTitle: TLabel;
    BevelTop: TBevel;
    LabelVersion: TLabel;
    procedure ImageClick(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsAboutIface=class(TSgtsDialogIface,ISgtsAboutForm)
  protected
    function GetFormClass: TSgtsFormClass; override;
  end;

var
  SgtsAboutForm: TSgtsAboutForm;

implementation

{$R *.dfm}

{ TSgtsAboutIface }

function TSgtsAboutIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsAboutForm;
end;

{ TSgtsAboutForm }

constructor TSgtsAboutForm.Create(ACoreIntf: ISgtsCore); 
begin
  inherited Create(ACoreIntf);
  LabelTitle.Caption:=ACoreIntf.Title;
  LabelVersion.Caption:='версия '+ACoreIntf.Version;
end;

procedure TSgtsAboutForm.ImageClick(Sender: TObject);
begin
  CoreIntf.SplashForm.Show;
  CoreIntf.SplashForm.HideByTimer(2000);

end;

end.
