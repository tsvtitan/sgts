unit SgtsFunPointInstrumentIfaces;

interface

uses Classes, DB,
     SgtsFm, SgtsRbkPointInstrumentEditFm, SgtsExecuteDefs;

type

  TSgtsFunPointInstrumentInsertIface=class(TSgtsRbkPointInstrumentInsertIface)
  private
    FSelected: Boolean;
    FParamIdDef: TSgtsExecuteDefEditLink;
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
    function NeedShow: Boolean; override;
  public
    procedure Init; override;
  end;

  TSgtsFunPointInstrumentUpdateIface=class(TSgtsRbkPointInstrumentUpdateIface)
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
  public
    procedure Init; override;
  end;

  TSgtsFunPointInstrumentDeleteIface=class(TSgtsRbkPointInstrumentDeleteIface)
  end;

implementation

uses SgtsConsts, SgtsProviderConsts, SgtsCDS,
     SgtsIface, SgtsDataEditFm, SgtsDatabaseCDS, SgtsRbkInstrumentsFm;

{ TSgtsFunPointInstrumentInsertIface }

procedure TSgtsFunPointInstrumentInsertIface.Init;
begin
  inherited Init;
  with DataSet do begin
    with ExecuteDefs do begin
      FParamIdDef:=TSgtsExecuteDefEditLink(Find('PARAM_ID'));
    end;
  end;
end;

procedure TSgtsFunPointInstrumentInsertIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with TSgtsRbkPointInstrumentEditForm(Form) do begin
      LabelPoint.Enabled:=false;
      EditPoint.Enabled:=false;
      ButtonPoint.Enabled:=false;
      FSelected:=FParamIdDef.Select;
    end;
  end;
end;

function TSgtsFunPointInstrumentInsertIface.NeedShow: Boolean;
begin
  Result:=inherited NeedShow and FSelected;
end;

{ TSgtsFunPointInstrumentUpdateIface }

procedure TSgtsFunPointInstrumentUpdateIface.Init;
begin
  inherited Init;
end;

procedure TSgtsFunPointInstrumentUpdateIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with TSgtsRbkPointInstrumentEditForm(Form) do begin
      LabelPoint.Enabled:=false;
      EditPoint.Enabled:=false;
      ButtonPoint.Enabled:=false;
    end;
  end;  
end;

end.
