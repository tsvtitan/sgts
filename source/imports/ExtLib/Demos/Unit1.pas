unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ELDgrm, StdCtrls;

type
  TForm1 = class(TForm)
    ELDBDiagram1: TELDBDiagram;
    ELDiagram1: TELDiagram;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

end.
