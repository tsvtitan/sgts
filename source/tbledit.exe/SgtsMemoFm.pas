unit SgtsMemoFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TSgtsMemoForm = class(TForm)
    ButtonOk: TButton;
    ButtonCancel: TButton;
    Memo: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SgtsMemoForm: TSgtsMemoForm;

implementation

{$R *.dfm}

end.
