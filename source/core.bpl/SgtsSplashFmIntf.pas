unit SgtsSplashFmIntf;

interface

uses SgtsFmIntf;

type

  ISgtsSplashForm=interface(ISgtsForm)
  ['{F34673B0-D774-40B7-8BAB-03FC24324CFB}']
  { methods }
    procedure HideByTimer(Interval: Integer);
    procedure Status(const S: String);
  end;

implementation

end.
