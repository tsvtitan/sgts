program DBFView;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  TS in 'TS.pas' {frmTS};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'DBF Viewer';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
