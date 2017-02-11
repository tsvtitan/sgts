unit SgtsBase64;

interface

uses IdCoderMIME;

type
   TSgtsBase64Encoder=class(TIdEncoderMIME)
   end;

   TSgtsBase64Decoder=class(TIdDecoderMIME)
   end;

function Base64ToStr(S: String): String;
function StrToBase64(S: String): String;

implementation

function Base64ToStr(S: String): String;
var
  Decoder: TSgtsBase64Decoder;
begin
  Decoder:=TSgtsBase64Decoder.Create(nil);
  try
    try
      Result:=Decoder.DecodeString(S);
    except
    end;  
  finally
    Decoder.Free;
  end;
end;

function StrToBase64(S: String): String;
var
  Encoder: TSgtsBase64Encoder;
begin
  Encoder:=TSgtsBase64Encoder.Create(nil);
  try
    try
      Result:=Encoder.Encode(S);
    except
    end;  
  finally
    Encoder.Free;
  end;
end;


end.
