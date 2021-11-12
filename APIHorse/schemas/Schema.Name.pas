unit Schema.Name;

interface

uses
  System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TName = class
  private
    FResult: Boolean;
    FValue: string;
  published
    property result: Boolean read FResult write FResult;
    property value: string read FValue write FValue;
  end;

implementation

end.
