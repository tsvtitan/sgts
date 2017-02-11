unit SgtsFmIntf;

interface

uses SgtsIfaceIntf;

type

  ISgtsForm=interface(ISgtsIface)
  ['{EBB008F3-372A-4971-8587-509125CE6866}']
  { methods }
    function CanShow: Boolean;
    procedure Show;
    procedure Hide;
    procedure Repaint;

  { properties }
    function _GetAsModal: Boolean;
    function _GetCaption: String;

    property AsModal: Boolean read _GetAsModal;
    property Caption: String read _GetCaption;
  end;

implementation

end.
