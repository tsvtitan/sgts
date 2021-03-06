unit SgtsDataIfaceIntf;

interface

uses DB, SgtsCDS, SgtsExecuteDefs, SgtsGetRecordsConfig,
     SgtsIfaceIntf;

type
  TSgtsDataIfaceMode=(imDefault,imSelect,imMultiSelect);

  ISgtsDataIface=interface(ISgtsIface)
  ['{7E9B1C4A-D5B1-4512-9E5E-679691A71876}']
  { methods }
    procedure Repaint;

    function CanRefresh: Boolean;
    procedure Refresh;
    function CanInsert: Boolean;
    procedure Insert;
    function CanUpdate: Boolean;
    procedure Update;
    function CanDelete: Boolean;
    procedure Delete;
    function CanCopy: Boolean;
    procedure Copy;
    function CanFirst: Boolean;
    procedure First;
    function CanPrior: Boolean;
    procedure Prior;
    function CanNext: Boolean;
    procedure Next;
    function CanLast: Boolean;
    procedure Last;
    function CanSelect: Boolean;
    function CanDetail: Boolean;
    procedure Detail;
    function CanReport: Boolean;
    procedure Report;
    function CanInfo: Boolean;
    procedure Info;

    procedure InsertByDefs(ExecuteDefs: Pointer);
    procedure UpdateByDefs(ExecuteDefs: Pointer);
    procedure DeleteByDefs(ExecuteDefs: Pointer);

  { properties }
    function _GetDataSet: TSgtsCDS;
    function _GetExecuteDefs: TSgtsExecuteDefs;
    function _GetMode: TSgtsDataIfaceMode;
    function _GetFilterGroups: TSgtsGetRecordsConfigFilterGroups;

    property DataSet: TSgtsCDS read _GetDataSet;
    property ExecuteDefs: TSgtsExecuteDefs read _GetExecuteDefs;
    property FilterGroups: TSgtsGetRecordsConfigFilterGroups read _GetFilterGroups;
    property Mode: TSgtsDataIfaceMode read _GetMode;
  end;

implementation

end.
