unit SgtsDialogs;

interface

uses Windows, Classes, Variants, Dialogs, SgtsTimedMsgFm;

function ShowError(Mess: String; UseTimer: Boolean=true): Integer;
function ShowWarning(Mess: String; UseTimer: Boolean=true): Integer;
function ShowInfo(Mess: String; UseTimer: Boolean=true): Integer;
function ShowQuestion(Mess: String; DefaultButton: TMsgDlgBtn=mbYes; UseTimer: Boolean=true): Integer;
function ShowQuestionCancel(Mess: String; DefaultButton: TMsgDlgBtn=mbYes; UseTimer: Boolean=true): Integer;
function ShowErrorQuestion(Mess: String; UseTimer: Boolean=true): Integer;
function ShowWarningQuestion(Mess: String; DefaultButton: TMsgDlgBtn=mbYes; UseTimer: Boolean=true): Integer;

implementation

uses SgtsConsts;

const
  DefaultTimeBox=10;

function ShowError(Mess: String; UseTimer: Boolean=true): Integer;
var
  Seconds: Integer;
begin
  Seconds:=DefaultTimeBox;
  MessageBeep(MB_ICONERROR);
  Result:=TimedMessageBox(Mess,'',mtError,[mbOk],mbOk,Seconds,0,UseTimer);
end;

function ShowWarning(Mess: String; UseTimer: Boolean=true): Integer;
var
  Seconds: Integer;
begin
  Seconds:=DefaultTimeBox;
  MessageBeep(MB_ICONWARNING);
  Result:=TimedMessageBox(Mess,'',mtWarning,[mbOk],mbOk,Seconds,0,UseTimer);
end;

function ShowInfo(Mess: String; UseTimer: Boolean=true): Integer;
var
  Seconds: Integer;
begin
  Seconds:=DefaultTimeBox;
  MessageBeep(MB_ICONINFORMATION);
  Result:=TimedMessageBox(Mess,'',mtInformation,[mbOk],mbOk,Seconds,0,UseTimer);
end;

function ShowQuestion(Mess: String; DefaultButton: TMsgDlgBtn=mbYes; UseTimer: Boolean=true): Integer;
var
  Seconds: Integer;
begin
  Seconds:=DefaultTimeBox;
  MessageBeep(MB_ICONQUESTION);
  Result:=TimedMessageBox(Mess,STitleCaptionConfirmation,mtConfirmation,[mbYes,mbNo],DefaultButton,Seconds,0,UseTimer);
end;

function ShowQuestionCancel(Mess: String; DefaultButton: TMsgDlgBtn=mbYes; UseTimer: Boolean=true): Integer;
var
  Seconds: Integer;
begin
  Seconds:=DefaultTimeBox;
  MessageBeep(MB_ICONQUESTION);
  Result:=TimedMessageBox(Mess,STitleCaptionConfirmation,mtConfirmation,[mbYes,mbNo,mbCancel],DefaultButton,Seconds,0,UseTimer);
end;

function ShowErrorQuestion(Mess: String; UseTimer: Boolean=true): Integer;
var
  Seconds: Integer;
begin
  Seconds:=DefaultTimeBox;
  MessageBeep(MB_ICONQUESTION);
  Result:=TimedMessageBox(Mess,STitleCaptionConfirmation,mtError,[mbYes,mbNo],mbYes,Seconds,0,UseTimer);
end;

function ShowWarningQuestion(Mess: String; DefaultButton: TMsgDlgBtn=mbYes; UseTimer: Boolean=true): Integer;
var
  Seconds: Integer;
begin
  Seconds:=DefaultTimeBox;
  MessageBeep(MB_ICONQUESTION);
  Result:=TimedMessageBox(Mess,STitleCaptionConfirmation,mtWarning,[mbYes,mbNo],DefaultButton,Seconds,0,UseTimer);
end;

end.
