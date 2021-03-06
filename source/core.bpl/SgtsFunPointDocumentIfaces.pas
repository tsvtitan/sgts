unit SgtsFunPointDocumentIfaces;

interface

uses Classes, DB,
     SgtsRbkDocumentEditFm, SgtsRbkPointDocumentEditFm,
     SgtsDataInsertBySelect, SgtsExecuteDefs;

type

  TSgtsFunPointDocumentInsertIface=class(TSgtsDataInsertBySelectIface)
  private
    FPriorityDef: TSgtsExecuteDefCalc;
    FDocumentNameDef: TSgtsExecuteDefInvisible;
    FDocumentDescDef: TSgtsExecuteDefInvisible;
    function GetPriority(Def: TSgtsExecuteDefCalc): Variant;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsFunPointDocumentUpdateIface=class(TSgtsRbkDocumentUpdateIface)
  private
    FDocumentNameDef: TSgtsExecuteDefEdit;
    FDocumentDescDef: TSgtsExecuteDefMemo;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsFunPointDocumentDeleteIface=class(TSgtsRbkPointDocumentDeleteIface)
  end;

implementation

uses SgtsConsts, SgtsProviderConsts, SgtsCDS,
     SgtsIface, SgtsDataEditFm, SgtsDatabaseCDS, SgtsRbkDocumentsFm;

{ TSgtsFunPointDocumentInsertIface }

procedure TSgtsFunPointDocumentInsertIface.Init;
begin
  inherited Init;
  SelectClass:=TSgtsRbkDocumentsIface;
  with DataSet do begin
    ProviderName:=SProviderInsertPointDocument;
    with ExecuteDefs do begin
      AddInvisible('POINT_ID');
      AddInvisible('DOCUMENT_ID');
      FPriorityDef:=AddCalc('PRIORITY',GetPriority);

      FDocumentNameDef:=AddInvisible('DOCUMENT_NAME',ptUnknown);
      FDocumentNameDef.Twins.Add('NAME');
      FDocumentDescDef:=AddInvisible('DOCUMENT_DESCRIPTION',ptUnknown);
      FDocumentDescDef.Twins.Add('DESCRIPTION');
      
      AddInvisible('FILE_NAME',ptUnknown);
      AddInvisible('POINT_NAME',ptUnknown);
    end;
  end;
end;

function TSgtsFunPointDocumentInsertIface.GetPriority(Def: TSgtsExecuteDefCalc): Variant;
var
  DS: TSgtsCDS;
begin
  Result:=Def.DefaultValue;
  if Assigned(IfaceIntf) then begin
    DS:=TSgtsCDS.Create(nil);
    try
      DS.AddIndexDef(Def.FieldName,tsAsc);
      DS.Data:=IfaceIntf.DataSet.Data;
      if DS.Active then begin
        DS.SetIndexBySort(Def.FieldName,tsAsc);
        DS.Last;
        Result:=DS.FieldByName(Def.FieldName).AsInteger+1;
      end;
    finally
      DS.Free;
    end;
  end;
end;

procedure TSgtsFunPointDocumentInsertIface.SetDefValues; 
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    FPriorityDef.DefaultValue:=GetPriority(FPriorityDef);
    FPriorityDef.SetDefault;
  end;
end;

{ TSgtsFunPointDocumentUpdateIface }

procedure TSgtsFunPointDocumentUpdateIface.Init;
begin
  inherited Init;
  with DataSet do begin
    with ExecuteDefs do begin
      FDocumentNameDef:=TSgtsExecuteDefEdit(Find('NAME'));
      FDocumentNameDef.Twins.Add('DOCUMENT_NAME');
      FDocumentDescDef:=TSgtsExecuteDefMemo(Find('DESCRIPTION'));
      FDocumentDescDef.Twins.Add('DOCUMENT_DESCRIPTION');
    end;
  end;
end;

procedure TSgtsFunPointDocumentUpdateIface.SetDefValues;
begin
  inherited SetDefValues;
end;

end.
