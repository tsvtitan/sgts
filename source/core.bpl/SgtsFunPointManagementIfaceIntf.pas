unit SgtsFunPointManagementIfaceIntf;

interface

uses SgtsDataTreeIfaceIntf;

type

  ISgtsFunPointManagementIface=interface(ISgtsDataTreeIface)
  ['{2A7299C4-217A-4619-ADD4-0B24673EA6FE}']
  { methods }

  { properties }
    function _GetMeasureTypeIsVisual: Boolean;

    property MeasureTypeIsVisual: Boolean read _GetMeasureTypeIsVisual;
  end;

implementation

end.
