unit Schema.Report.POSList;

interface

uses
 System.Generics.Collections, REST.Json.Types;



type
  TArrayPOSValue = class
  private
    FCaixa: string;
  published
    property Caixa: string read FCaixa write FCaixa;
  end;

  TPOSList = class
  private
    FResult: Boolean;
    [JSONName('value'), JSONMarshalled(False)]
    FValueArray: TArray<TArrayPOSValue>;
    [GenericListReflect]
    FValue: TObjectList<TArrayPOSValue>;

  public
    property result: Boolean read FResult write FResult;
    property value: TObjectList<TArrayPOSValue> read FValue;

  end;

implementation




end.
