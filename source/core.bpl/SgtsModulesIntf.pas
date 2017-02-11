unit SgtsModulesIntf;

interface

uses SgtsObjIntf, SgtsConfigIntf, SgtsLogIntf;

type

  ISgtsModule=interface(ISgtsObj)
  ['{12AED82A-19A4-4FE1-B401-2F86ED32CFBA}']
  { properties }
    function _GetEnabled: Boolean;
    function _GetCaption: String;
    function _GetFileName: String;

    property Enabled: Boolean read _GetEnabled;
    property Caption: String read _GetCaption;
    property FileName: String read _GetFileName;
  end;

  ISgtsModules=interface(ISgtsObj)
  ['{0985CF1F-58F9-4327-9701-DC1D020AB710}']
  { properties }
    function _GetCount: Integer;

    property Count: Integer read _GetCount;
  end;

implementation

end.
