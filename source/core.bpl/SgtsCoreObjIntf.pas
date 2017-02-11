unit SgtsCoreObjIntf;

interface

uses SgtsObjIntf, SgtsCoreIntf;

type

  ISgtsCoreObj=interface(ISgtsObj)
  ['{030C9E01-17B6-4F7F-A885-92849AE41ADB}']
  { properties }
    function _GetCore: ISgtsCore;

    property Core: ISgtsCore read _GetCore;
  end;

implementation

end.
