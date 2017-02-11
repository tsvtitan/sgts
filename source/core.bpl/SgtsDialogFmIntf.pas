unit SgtsDialogFmIntf;

interface

uses Controls,
     SgtsFmIntf;

type

  ISgtsDialogForm=interface(ISgtsForm)
  ['{2CB10A5A-0AF6-43A9-A0E8-8C30445C2846}']
  { methods }
    function ShowModal: TModalResult;
  end;

implementation

end.
