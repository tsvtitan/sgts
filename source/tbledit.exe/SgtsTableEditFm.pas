unit SgtsTableEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, XPMan, DBCtrls, DBGrids, DBClient,
  SgtsTableEditFrm, AppEvnts, Menus;

type
  TSgtsTableEditForm = class(TForm)
    XPManifest: TXPManifest;
    SgtsTableEditFrame1: TSgtsTableEditFrame;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure N1Click(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure SgtsTableEditFrame1ButtonGenClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  SgtsTableEditForm: TSgtsTableEditForm;

implementation

uses Strutils,
     SgtsMemoFm;

{$R *.dfm}

procedure TSgtsTableEditForm.N1Click(Sender: TObject);
begin
  SgtsTableEditFrame1.ButtonGenClick(Sender);
end;

procedure TSgtsTableEditForm.PopupMenuPopup(Sender: TObject);
begin
  N1.Enabled:=SgtsTableEditFrame1.DataSet.Active;
  N2.Enabled:=SgtsTableEditFrame1.DataSet.Active and
              Assigned(SgtsTableEditFrame1.DataSet.FindField('VALUE')) and
              Assigned(SgtsTableEditFrame1.DataSet.FindField('DESCRIPTION')) and
              Assigned(SgtsTableEditFrame1.DataSet.FindField('TYPE')) and
              Assigned(SgtsTableEditFrame1.DataSet.FindField('FLAG'));
end;

procedure TSgtsTableEditForm.SgtsTableEditFrame1ButtonGenClick(Sender: TObject);
var
  pt: TPoint;
begin
  with SgtsTableEditFrame1 do begin
    pt.x:=ButtonGen.Left;
    pt.y:=ButtonGen.Top+ButtonGen.Height;
    pt:=PanelValueButton.ClientToScreen(pt);
    Self.PopupMenu.Popup(pt.x,pt.y);
  end;
end;

procedure TSgtsTableEditForm.N2Click(Sender: TObject);
var
  Form: TSgtsMemoForm;
  S: String;
  S1: String;
  I: Integer;
  C: Char;
  PosFirst: Integer;
  FlagParam: Boolean;
  Params: TStringList;
  Values: TStringList;
  Param1: Integer;
  Param2: Integer;
  dParam: Integer;
  TempParam: Integer;
  Maximum: Integer;
  Position: Integer;
const
  EndParamChars=[' ',#13];
begin
  if SgtsTableEditFrame1.DataSet.Active and
     Assigned(SgtsTableEditFrame1.DataSet.FindField('VALUE')) and
     Assigned(SgtsTableEditFrame1.DataSet.FindField('DESCRIPTION')) and
     Assigned(SgtsTableEditFrame1.DataSet.FindField('TYPE')) and
     Assigned(SgtsTableEditFrame1.DataSet.FindField('FLAG')) then begin
     
    Form:=TSgtsMemoForm.Create(nil);
    Params:=TStringList.Create;
    Values:=TStringList.Create;
    try
      if Form.ShowModal=mrOk then begin
        S:=Form.Memo.Lines.Text;

        PosFirst:=0;
        FlagParam:=false;
        for i:=1 to Length(S) do begin
          C:=S[i];
          if C=':' then begin
            PosFirst:=i;
            FlagParam:=true;
          end;
          if FlagParam and ((C in EndParamChars) or (i=Length(S))) then begin
            if i<>Length(S) then
              S1:=Copy(S,PosFirst,i-PosFirst)
            else S1:=Copy(S,PosFirst,Length(S));
            Params.Add(S1);
            FlagParam:=false;
          end;
        end;

        if Params.Count=2 then begin

          for i:=0 to Params.Count-1 do begin
            Values.Add(InputBox(Params.Strings[i],'',''));
          end;

          Values.Add(InputBox('Максимум','',''));
          Values.Add(InputBox('Описание','',''));

          if TryStrToInt(Values.Strings[0],Param1) then
            if TryStrToInt(Values.Strings[1],Param2) then
              if TryStrToInt(Values.Strings[2],Maximum) then begin
                dParam:=Param2-Param1;
                TempParam:=Param1;
                Position:=0;
                while TempParam<Maximum do begin

                  S1:=ReplaceText(S,Params.Strings[0],IntToStr(TempParam));
                  S1:=ReplaceText(S1,Params.Strings[1],IntToStr(TempParam+dParam));

                  TempParam:=TempParam+dParam+1;

                  Inc(Position);

                  SgtsTableEditFrame1.DataSet.Append;
                  SgtsTableEditFrame1.DataSet.FieldByName('VALUE').AsString:=S1;
                  SgtsTableEditFrame1.DataSet.FieldByName('DESCRIPTION').AsString:=Format('%s %d',[Values.Strings[3],Position]);
                  SgtsTableEditFrame1.DataSet.FieldByName('TYPE').AsString:='4';
                  SgtsTableEditFrame1.DataSet.FieldByName('FLAG').AsString:='1';
                  SgtsTableEditFrame1.DataSet.Post;
                end;
              end;

        end;

      end;
    finally
      Values.Free;
      Params.Free;
      Form.Free;
    end;
  end;
end;


end.
