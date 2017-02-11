unit TS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TfrmTS = class(TForm)
    sb: TStatusBar;
    Panel2: TPanel;
    lv: TListView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTS: TfrmTS;

implementation

{$R *.DFM}

end.
