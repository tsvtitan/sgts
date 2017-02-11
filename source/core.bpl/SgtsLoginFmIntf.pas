unit SgtsLoginFmIntf;

interface

uses SgtsDialogFmIntf;

type

  ISgtsLoginForm=interface(ISgtsDialogForm)
  ['{6DBF8453-0FE5-4968-B31A-861B9702E7ED}']
  { methods }
    function Login: Boolean;  
  end;

implementation

end.
