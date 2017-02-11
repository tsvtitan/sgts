unit SgtsDataDelete;

interface

uses Forms,
     SgtsDataEditFm, SgtsFm,
     SgtsDataDeleteIntf, SgtsCoreIntf, SgtsDataFmIntf, SgtsDataIfaceIntf;

type
  TSgtsDataDeleteIface=class(TSgtsDataEditIface,ISgtsDataDeleteForm)
  private
    FDeleteQuestion: String;
    function GetNewDeleteQuestion(const S: String): String;
  protected
    function GetFormClass: TSgtsFormClass; override;
    function SaveChanges: Boolean; override;
  public
    constructor Create(ACoreIntf: ISgtsCore; AIfaceIntf: ISgtsDataIface); override;
    procedure Show; override;
    procedure Delete; virtual;

    property DeleteQuestion: String read FDeleteQuestion write FDeleteQuestion;
  end;

  TSgtsDataDeleteIfaceClass=class of TSgtsDataDeleteIface;

implementation

uses SysUtils, Controls, Dialogs, Variants,
     SgtsDialogs, SgtsConsts, SgtsExecuteDefs;

{ TSgtsDataDeleteIface }

constructor TSgtsDataDeleteIface.Create(ACoreIntf: ISgtsCore; AIfaceIntf: ISgtsDataIface);
begin
  inherited Create(ACoreIntf,AIfaceIntf);
  FDeleteQuestion:=SDeleteCurrentRecord;
  DisableSet:=false;
end;

function TSgtsDataDeleteIface.GetFormClass: TSgtsFormClass;
begin
  Result:=nil;
end;

procedure TSgtsDataDeleteIface.Delete; 
begin

end;

function TSgtsDataDeleteIface.SaveChanges: Boolean;
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
      Delete;
      if Assigned(IfaceIntf) then begin
        IfaceIntf.DeleteByDefs(DataSet.ExecuteDefs);
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

function TSgtsDataDeleteIface.GetNewDeleteQuestion(const S: String): String;
var
  i: Integer;
  Def: TSgtsExecuteDef;
begin
  Result:=S;
  with DataSet.ExecuteDefs do begin
    for i:=0 to Count-1 do begin
      Def:=Items[i];
      if not Def.IsKey then begin
        Result:=StringReplace(Result,'%'+Def.Name,VarToStrDef(Def.Value,''),[rfReplaceAll,rfIgnoreCase]);
      end;
    end;
  end;
end;

procedure TSgtsDataDeleteIface.Show;
var
  Ret: Integer;
begin
  InternalSetDefValues;
  Ret:=ShowQuestion(GetNewDeleteQuestion(FDeleteQuestion),mbNo);
  if Ret=mrYes then begin
    SaveChanges;
  end;
end;

end.
