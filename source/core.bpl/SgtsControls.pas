unit SgtsControls;

interface

uses Windows, Messages, Classes, Controls, Graphics, StdCtrls, ComCtrls,
     DBCtrls;

type

  TEdit=class(StdCtrls.TEdit)
  private
    FOldColor: TColor;
    FOldLabelColor: TColor;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  end;

  TMemo=class(StdCtrls.TMemo)
  private
    FOldColor: TColor;
    FOldLabelColor: TColor;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  end;

  TListBox=class(StdCtrls.TListBox)
  private
    FOldColor: TColor;
    FOldLabelColor: TColor;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  end;


  TComboBox=class(StdCtrls.TComboBox)
  private
    FOldColor: TColor;
    FOldLabelColor: TColor;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  end;

  TDateTimePicker=class(ComCtrls.TDateTimePicker)
  private
    FOldColor: TColor;
    FOldLabelColor: TColor;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  end;

  TDBEdit=class(DBCtrls.TDBEdit)
  private
    FOldColor: TColor;
    FOldLabelColor: TColor;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  end;

  TDBMemo=class(DBCtrls.TDBMemo)
  private
    FOldColor: TColor;
    FOldLabelColor: TColor;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  end;

const
  ElementFocusColor=clInfoBk;
  ElementLabelFocusColor=clBlue;

function GetLabelByWinControl(WinControl: TWinControl): TLabel;

implementation

uses Forms,
     SgtsUtils, SgtsDialogs;


function GetLabelByWinControl(WinControl: TWinControl): TLabel;
var
  i: Integer;
begin
  Result:=nil;
  if WinControl=nil then exit;
  if WinControl.Owner=nil then exit;
  if not (WinControl.Owner is TScrollingWinControl) then exit;
  for i:=0 to TScrollingWinControl(WinControl.Owner).ComponentCount-1 do begin
    if TScrollingWinControl(WinControl.Owner).Components[i] is TLabel then
      if TLabel(TScrollingWinControl(WinControl.Owner).Components[i]).FocusControl=WinControl then begin
        Result:=TLabel(TScrollingWinControl(WinControl.Owner).Components[i]);
        break;
      end;
  end;
end;

{ TEdit }

procedure TEdit.CMEnter(var Message: TCMEnter);
var
  lb: TLabel;
begin
  FOldColor:=Color;
  Color:=iff(Color<>clBtnFace,ElementFocusColor,Color);
  lb:=GetLabelByWinControl(Self);
  if lb<>nil then begin
    FOldLabelColor:=lb.Font.Color;
    lb.Font.Color:=ElementLabelFocusColor;
  end;
  inherited;
end;

procedure TEdit.CMExit(var Message: TCMExit);
var
  lb: TLabel;
begin
  inherited;
  lb:=GetLabelByWinControl(Self);
  if lb<>nil then begin
    lb.Font.Color:=FOldLabelColor;
  end;
  Color:=FOldColor;
end;

{ TMemo }

procedure TMemo.CMEnter(var Message: TCMEnter);
var
  lb: TLabel;
begin
  FOldColor:=Color;
  Color:=iff(Color<>clBtnFace,ElementFocusColor,Color);
  lb:=GetLabelByWinControl(Self);
  if lb<>nil then begin
    FOldLabelColor:=lb.Font.Color;
    lb.Font.Color:=ElementLabelFocusColor;
  end;
  inherited;
end;

procedure TMemo.CMExit(var Message: TCMExit);
var
  lb: TLabel;
begin
  inherited;
  lb:=GetLabelByWinControl(Self);
  if lb<>nil then begin
    lb.Font.Color:=FOldLabelColor;
  end;
  Color:=FOldColor;
end;

{ TListBox }

procedure TListBox.CMEnter(var Message: TCMEnter);
var
  lb: TLabel;
begin
  FOldColor:=Color;
  Color:=iff(Color<>clBtnFace,ElementFocusColor,Color);
  lb:=GetLabelByWinControl(Self);
  if lb<>nil then begin
    FOldLabelColor:=lb.Font.Color;
    lb.Font.Color:=ElementLabelFocusColor;
  end;
  inherited;
end;

procedure TListBox.CMExit(var Message: TCMExit);
var
  lb: TLabel;
begin
  inherited;
  lb:=GetLabelByWinControl(Self);
  if lb<>nil then begin
    lb.Font.Color:=FOldLabelColor;
  end;
  Color:=FOldColor;
end;

{ TComboBox }

procedure TComboBox.CMEnter(var Message: TCMEnter);
var
  lb: TLabel;
begin
  FOldColor:=Color;
  Color:=iff(Color<>clBtnFace,ElementFocusColor,Color);
  lb:=GetLabelByWinControl(Self);
  if lb<>nil then begin
    FOldLabelColor:=lb.Font.Color;
    lb.Font.Color:=ElementLabelFocusColor;
  end;
  inherited;
end;

procedure TComboBox.CMExit(var Message: TCMExit);
var
  lb: TLabel;
begin
  inherited;
  lb:=GetLabelByWinControl(Self);
  if lb<>nil then begin
    lb.Font.Color:=FOldLabelColor;
  end;
  Color:=FOldColor;
end;

{ TDateTimePicker }

procedure TDateTimePicker.CMEnter(var Message: TCMEnter);
var
  lb: TLabel;
begin
  FOldColor:=Color;
  Color:=iff(Color<>clBtnFace,ElementFocusColor,Color);
  lb:=GetLabelByWinControl(Self);
  if lb<>nil then begin
    FOldLabelColor:=lb.Font.Color;
    lb.Font.Color:=ElementLabelFocusColor;
  end;
  inherited;
end;

procedure TDateTimePicker.CMExit(var Message: TCMExit);
var
  lb: TLabel;
begin
  inherited;
  lb:=GetLabelByWinControl(Self);
  if lb<>nil then begin
    lb.Font.Color:=FOldLabelColor;
  end;
  Color:=FOldColor;
end;

{ TDBEdit }

procedure TDBEdit.CMEnter(var Message: TCMEnter);
var
  lb: TLabel;
begin
  FOldColor:=Color;
  Color:=iff(Color<>clBtnFace,ElementFocusColor,Color);
  lb:=GetLabelByWinControl(Self);
  if lb<>nil then begin
    FOldLabelColor:=lb.Font.Color;
    lb.Font.Color:=ElementLabelFocusColor;
  end;
  inherited;
end;

procedure TDBEdit.CMExit(var Message: TCMExit);
var
  lb: TLabel;
begin
  inherited;
  lb:=GetLabelByWinControl(Self);
  if lb<>nil then begin
    lb.Font.Color:=FOldLabelColor;
  end;
  Color:=FOldColor;
end;

{ TDBMemo }

procedure TDBMemo.CMEnter(var Message: TCMEnter);
var
  lb: TLabel;
begin
  FOldColor:=Color;
  Color:=iff(Color<>clBtnFace,ElementFocusColor,Color);
  lb:=GetLabelByWinControl(Self);
  if lb<>nil then begin
    FOldLabelColor:=lb.Font.Color;
    lb.Font.Color:=ElementLabelFocusColor;
  end;
  inherited;
end;

procedure TDBMemo.CMExit(var Message: TCMExit);
var
  lb: TLabel;
begin
  inherited;
  lb:=GetLabelByWinControl(Self);
  if lb<>nil then begin
    lb.Font.Color:=FOldLabelColor;
  end;
  Color:=FOldColor;
end;

end.
