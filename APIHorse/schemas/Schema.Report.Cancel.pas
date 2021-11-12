unit Schema.Report.Cancel;

interface

uses
  System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TReportCancelValue = class
  private
    FCaixa: string;
    [JSONName('Cod_Colaborador')]
    FCodColaborador: Integer;
    FTDesconto: Integer;
    FTTotal: Double;
    FTValor: Double;
  published
    property Caixa: string read FCaixa write FCaixa;
    property Cod_Colaborador: Integer read FCodColaborador write FCodColaborador;
    property TDesconto: Integer read FTDesconto write FTDesconto;
    property TTotal: Double read FTTotal write FTTotal;
    property TValor: Double read FTValor write FTValor;
  end;

  TReportCancel = class
  private
    FResult: Boolean;
    [JSONName('value'), JSONMarshalled(False)]
    FValueArray: TArray<TReportCancelValue>;
    [GenericListReflect]
    FValue: TObjectList<TReportCancelValue>;
  public
    property result: Boolean read FResult write FResult;
    property value: TObjectList<TReportCancelValue> read FValue;
  end;

implementation


end.
