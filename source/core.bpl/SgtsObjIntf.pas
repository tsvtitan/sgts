unit SgtsObjIntf;

interface

type

  ISgtsObj=interface
  ['{2D119626-5684-4289-9A52-80FC61A3A86C}']
    { methods }
    procedure Init;
    procedure Done;

    { properties }
    function _GetName: String;

    property Name: String read _GetName;
  end;


implementation

end.
