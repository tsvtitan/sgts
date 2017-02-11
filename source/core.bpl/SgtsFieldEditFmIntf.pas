unit SgtsFieldEditFmIntf;

interface

uses SgtsDialogFmIntf;

type
  TSgtsFieldEditType=(etDefault,etString);

  ISgtsFieldEditForm=interface(ISgtsDialogForm)
  ['{77AC3247-95BD-4BD8-84EC-73A693C8BF47}']
  { methods }
    function Show(OldValue: Variant; out NewValue: Variant; EditType: TSgtsFieldEditType): Boolean;
  end;

implementation

end.
