unit SgtsInstallSqlFmIntf;

interface

uses SgtsDialogFmIntf;

type

  ISgtsInstallSqlForm=interface(ISgtsDialogForm)
  ['{035A5975-FDAA-4483-87DB-3EB359843E7F}']
  { methods }
    function Install: Boolean;
    function Uninstall: Boolean;  
  end;

implementation

end.
