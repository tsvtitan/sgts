unit SgtsDataInsertFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, Contnrs,
  SgtsDataEditFm, SgtsFm, SgtsDataIfaceIntf,
  SgtsDataInsertFmIntf, SgtsCoreIntf, SgtsDataFmIntf, StdCtrls;

type
  TSgtsDataInsertForm = class(TSgtsDataEditForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsDataInsertIface=class(TSgtsDataEditIface,ISgtsDataInsertForm)
  private
    FInsertInfo: String;
  protected
    function GetFormClass: TSgtsFormClass; override;
    function SaveChanges: Boolean; override;
  public
    constructor Create(ACoreIntf: ISgtsCore; AIfaceIntf: ISgtsDataIface); override;
    procedure Insert; virtual;

    property InsertInfo: String read FInsertInfo write FInsertInfo;
  end;

  TSgtsDataInsertIfaceClass=class of TSgtsDataInsertIface;

  TSgtsDataInsertIfaceClasses=class(TClassList)
  private
    function GetItems(Index: Integer): TSgtsDataInsertIfaceClass;
    procedure SetItems(Index: Integer; Value: TSgtsDataInsertIfaceClass);
  public
    property Items[Index: Integer]: TSgtsDataInsertIfaceClass read GetItems write SetItems;
  end;

var
  SgtsDataInsertForm: TSgtsDataInsertForm;

implementation

uses SgtsDialogs, SgtsConsts, SgtsCoreObj;

{$R *.dfm}

{ TSgtsDataInsertIfaceClasses }

function TSgtsDataInsertIfaceClasses.GetItems(Index: Integer): TSgtsDataInsertIfaceClass;
begin
  Result:=TSgtsDataInsertIfaceClass(inherited Items[Index]);
end;

procedure TSgtsDataInsertIfaceClasses.SetItems(Index: Integer; Value: TSgtsDataInsertIfaceClass);
begin
  inherited Items[Index]:=Value;
end;

{ TSgtsDataInsertIface }

constructor TSgtsDataInsertIface.Create(ACoreIntf: ISgtsCore; AIfaceIntf: ISgtsDataIface);
begin
  inherited Create(ACoreIntf,AIfaceIntf);
  FInsertInfo:=SInsertRecordSuccess;
end;

function TSgtsDataInsertIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsDataInsertForm;
end;

procedure TSgtsDataInsertIface.Insert;
begin
end;

function TSgtsDataInsertIface.SaveChanges: Boolean;
var
  OldCursor: TCursor;
begin
  Result:=false;
  try
    OldCursor:=Screen.Cursor;
    Screen.Cursor:=crHourGlass;
    try
      if Assigned(IfaceIntf) then
        IfaceIntf.Repaint;
      DataSet.Execute;
      Insert;
      if Assigned(IfaceIntf) then begin
        IfaceIntf.InsertByDefs(DataSet.ExecuteDefs);
      end;
      Result:=true;
    finally
      Screen.Cursor:=OldCursor;
    end;
    if Result and not Assigned(IfaceIntf) then
      ShowInfo(FInsertInfo);
  except
    On E: Exception do begin
      ShowError(E.Message);
    end;
  end;  
end;

end.
