unit SgtsCmdLineIntf;

interface

uses SgtsObjIntf;

type

  ISgtsCmdLine=interface(ISgtsObj)
  ['{44DC47A5-5340-4809-831F-08BF183B669B}']
  { methods }
    function ParamExists(const Param: String): Boolean;
    function ValueByParam(const Param: String; Index: Integer=0): String;
    
  { properties }
    function _GetFileName: String;

    property FileName: String read _GetFileName;
  end;

implementation

end.
