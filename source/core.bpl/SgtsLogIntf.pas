unit SgtsLogIntf;

interface

uses SgtsObjIntf;

type

  TSgtsLogType=(ltInformation,ltWarning,ltError);

  ISgtsLog=interface(ISgtsObj)
  ['{958FDB5A-3C06-4EEC-BB49-EED30CCF38C7}']
  { methods }
    function Write(const Message: String; LogType: TSgtsLogType): Boolean;
    function WriteInfo(const Message: String): Boolean;
    function WriteError(const Message: String): Boolean;
    function WriteWarn(const Message: String): Boolean;

  end;

implementation

end.
