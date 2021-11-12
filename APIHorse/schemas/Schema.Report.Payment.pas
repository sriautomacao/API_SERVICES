unit Schema.Report.Payment;

interface

uses
   System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TArrayValue = class
  private
    FCaixa: string;
    [JSONName('cod_finalizadora')]
    FCodFinalizadora: Integer;
    FFinalizadora: string;
    [JSONName('Valor_final')]
    FValorFinal: Double;
  public
    property Caixa: string read FCaixa write FCaixa;
    property cod_finalizadora: Integer read FCodFinalizadora write FCodFinalizadora;
    property Finalizadora: string read FFinalizadora write FFinalizadora;
    property Valor_final: Double read FValorFinal write FValorFinal;
  end;

  TReportPayment = class
  private
    FResult: Boolean;
    [JSONName('value'), JSONMarshalled(False)]
    FValueArray: TArray<TArrayValue>;
    [GenericListReflect]
    FValue: TObjectList<TArrayValue>;
    procedure Setvalue(const Value: TObjectList<TArrayValue>);
  public
    property result: Boolean read FResult write FResult;
    property value: TObjectList<TArrayValue> read Fvalue write Setvalue;
  end;

implementation


{ TReportPayment }

procedure TReportPayment.Setvalue(const Value: TObjectList<TArrayValue>);
begin
  Fvalue := Value;
end;

end.
