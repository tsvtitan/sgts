unit Preview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, Buttons;

type
  TPagePreview = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PaintBox: TPaintBox;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PagePreview: TPagePreview;

implementation

{$R *.DFM}


end.
