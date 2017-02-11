unit SgtsDataUpdateFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Menus, ExtCtrls, ComCtrls, ToolWin,
  SgtsDataEditFm, SgtsFm,
  SgtsDataUpdateFmIntf, StdCtrls;

type
  TSgtsDataUpdateForm = class(TSgtsDataEditForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsDataUpdateIface=class(TSgtsDataEditIface,ISgtsDataUpdateForm)
  protected
    function GetFormClass: TSgtsFormClass; override;
    function SaveChanges: Boolean; override;
  public
    procedure Update; virtual;
  end;

  TSgtsDataUpdateIfaceClass=class of TSgtsDataUpdateIface;

var
  SgtsDataUpdateForm: TSgtsDataUpdateForm;

implementation

uses DB,
     SgtsDialogs, SgtsExecuteDefs;

{$R *.dfm}

{ TSgtsDataUpdateIface }

function TSgtsDataUpdateIface.GetFormClass: TSgtsFormClass; 
begin
  Result:=TSgtsDataUpdateForm;
end;

procedure TSgtsDataUpdateIface.Update;
begin
end;

function TSgtsDataUpdateIface.SaveChanges: Boolean;
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
      Update;
      if Assigned(IfaceIntf) then begin
        IfaceIntf.UpdateByDefs(DataSet.ExecuteDefs);
      end;
      Result:=true;
    finally
      Screen.Cursor:=OldCursor;
    end;
  except
    On E: Exception do begin
      ShowError(E.Message);
    end;
  end;
end;

end.
