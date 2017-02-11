library test;

{$R *.res}
                           
uses
  SgtsChildFm in '..\core.bpl\SgtsChildFm.pas' {SgtsChildForm},
  SgtsDataEditFm in '..\core.bpl\SgtsDataEditFm.pas' {SgtsDataEditForm},
  SgtsDataFm in '..\core.bpl\SgtsDataFm.pas' {SgtsDataForm},
  SgtsDataGridFm in '..\core.bpl\SgtsDataGridFm.pas' {SgtsDataGridForm},
  SgtsFm in '..\core.bpl\SgtsFm.pas' {SgtsForm},
  SgtsTestInterface in 'SgtsTestInterface.pas',
  SgtsRbkTestEditFm in 'SgtsRbkTestEditFm.pas' {SgtsRbkTestEditForm},
  SgtsRbkTestFm in 'SgtsRbkTestFm.pas' {SgtsRbkTestForm},
  SgtsTest in 'SgtsTest.pas',
  SgtsTestFm in 'SgtsTestFm.pas' {SgtsTestForm};

exports
  InitInterface;
      
begin
end.
