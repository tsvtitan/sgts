unit SgtsFunConverterComponentIfaces;

interface

uses Classes, DB,
     SgtsRbkComponentEditFm, SgtsFm, 
     SgtsExecuteDefs;

type
  TSgtsFunConverterComponentInsertIface=class(TSgtsRbkComponentInsertIface)
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsFunConverterComponentUpdateIface=class(TSgtsRbkComponentUpdateIface)
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
  end;

  TSgtsFunConverterComponentDeleteIface=class(TSgtsRbkComponentDeleteIface)
  end;

implementation

{ TSgtsFunConverterComponentInsertIface }

procedure TSgtsFunConverterComponentInsertIface.Init;
begin
  inherited Init;
  with DataSet do begin
    with ExecuteDefs do begin
    end;
  end;  
end;

procedure TSgtsFunConverterComponentInsertIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with TSgtsRbkComponentEditForm(Form) do begin
      EditConverter.Enabled:=false;
      LabelConverter.Enabled:=false;
      ButtonConverter.Enabled:=false;
    end;
  end;
end;

procedure TSgtsFunConverterComponentInsertIface.SetDefValues;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      
    end;
  end;
end;

{ TSgtsFunConverterComponentUpdateIface }

procedure TSgtsFunConverterComponentUpdateIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with TSgtsRbkComponentEditForm(Form) do begin
      EditConverter.Enabled:=false;
      LabelConverter.Enabled:=false;
      ButtonConverter.Enabled:=false;
    end;
  end;
end;

end.
