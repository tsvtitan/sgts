unit Main;

interface

uses
  Classes, Forms, SysUtils, Db, MDBFTable, Dialogs, Menus, ComCtrls, Grids, DBGrids,
  StdCtrls, Buttons, DBCtrls, Controls, ExtCtrls;

type
  TfrmMain = class(TForm)
    ButtonPanel: TPanel;
    Navigator: TPanel;
    MainBar: TPanel;
    sbOpen: TSpeedButton;
    sbTS: TSpeedButton;
    sbExit: TSpeedButton;
    MainMenu: TMainMenu;
    mmFile: TMenuItem;
    N1: TMenuItem;
    mmExit: TMenuItem;
    sd: TSaveDialog;
    od: TOpenDialog;
    mmOpen: TMenuItem;
    N3: TMenuItem;
    mmTS: TMenuItem;
    Panel: TPanel;
    Panel3: TPanel;
    sbFind: TSpeedButton;
    e: TEdit;
    mmHelp: TMenuItem;
    mmAbout: TMenuItem;
    MDBFTable: TMDBFTable;
    ds: TDataSource;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    sb: TStatusBar;
    Bevel1: TBevel;
    cbxDeleted: TCheckBox;
    sbSave: TSpeedButton;
    mmSave: TMenuItem;
    procedure cmClose(Sender: TObject);
    procedure cmOpen(Sender: TObject);
    procedure cmTS(Sender: TObject);
    procedure cmAbout(Sender: TObject);
    procedure dsDataChange(Sender: TObject; Field: TField);
    procedure MDBFTableAfterOpen(DataSet: TDataSet);
    procedure eChange(Sender: TObject);
    procedure sbFindClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmSave(Sender: TObject);
  end;

var
  frmMain: TfrmMain;

implementation

uses TS, ShellAPI;

{$R *.DFM}

procedure TfrmMain.cmClose(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.cmOpen(Sender: TObject);
begin
  if od.execute then begin
    if MDBFTable.Modified and (messagedlg('Save changes?',mtconfirmation,[mbyes,mbno],0)=mryes) then
      mdbftable.save;
    mdbftable.close;
    mdbftable.ShowDeleted:=cbxdeleted.Checked;
    mdbftable.filename:=od.filename;
    mdbftable.open;
  end;
end;

procedure TfrmMain.cmTS(Sender: TObject);
var
  n :tlistitem;
  i :integer;
  s :string;
begin
  with tfrmts.create(self) do begin
    for i:=0 to mdbftable.fieldcount-1 do begin
      n:=lv.items.add;
      n.caption:=mdbftable.originalfields[i].fieldname;
      case mdbftable.originalfields[i].FieldType of
        ftstring: s:='Character';
        ftinteger: s:='Numeric';
        ftfloat: s:='Float';
        ftdatetime: s:='Date';
        ftboolean: s:='Logical';
        ftmemo: s:='Memo';
        ftblob: s:='BLOB';
        ftdbaseole: s:='OLE';
        ftunknown: s:='?';
      end;
      n.subitems.add(s);
      n.subitems.add(inttostr(mdbftable.originalfields[i].Size));
      n.subitems.add(inttostr(mdbftable.originalfields[i].Decimals));
    end;
    sb.panels[1].text:=inttostr(mdbftable.fieldcount);
    showmodal;
    free;
  end;
end;


procedure TfrmMain.cmAbout(Sender: TObject);
begin
  shellabout(Application.MainForm.Handle,'',pchar(mdbftable.about),application.icon.handle);
end;

procedure TfrmMain.dsDataChange(Sender: TObject; Field: TField);
begin
  sb.panels[1].text:=inttostr(mdbftable.recno)+' / '+inttostr(mdbftable.recordcount);
  if mdbftable.deleted then
    sb.panels[2].Text:='Deleted'
  else
    sb.panels[2].Text:='';
  if MDBFTable.Modified then
    sb.panels[3].Text:='Modified'
  else
    sb.panels[3].Text:='';
  mmsave.Enabled:=MDBFTable.Modified;
  sbsave.Enabled:=mmsave.Enabled;
end;

procedure TfrmMain.MDBFTableAfterOpen(DataSet: TDataSet);
begin
  mmts.enabled:=true;
  sbts.enabled:=true;
  e.enabled:=true;
end;

procedure TfrmMain.eChange(Sender: TObject);
begin
  sbfind.enabled:=e.text<>'';
end;

procedure TfrmMain.sbFindClick(Sender: TObject);
begin
  if not mdbftable.findkey([e.text]) then
    messagedlg('Not found',mtinformation,[mbok],0);
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  par :string;
  i :integer;
begin
  par:='';
  for i:=1 to paramcount do
    par:=par+paramstr(i)+' ';
  if paramcount>0 then begin
    mdbftable.close;
    mdbftable.filename:=(trim(par));
    mdbftable.open;
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MDBFTable.Modified and (messagedlg('Save changes?',mtconfirmation,[mbyes,mbno],0)=mryes) then
    mdbftable.save;
end;

procedure TfrmMain.cmSave(Sender: TObject);
begin
  mdbftable.save;
  dsdatachange(nil,nil);
end;

end.
