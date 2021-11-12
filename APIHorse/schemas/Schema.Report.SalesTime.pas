unit Schema.Report.SalesTime;

interface

uses
  System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TReportSaleTimeValue = class
  private
    FCaixa: string;
    FHora: string;
    FQtd: Integer;
    FTotal: Double;
  published
    property Caixa: string read FCaixa write FCaixa;
    property Qtd: Integer read FQtd write FQtd;
    property Hora: string read FHora write FHora;
    property Total: Double read FTotal write FTotal;
  end;

  TReportSaleTime = class
  private
    FResult: Boolean;
    FValueArray: TArray<TReportSaleTimeValue>;
    [GenericListReflect]
    FValue: TObjectList<TReportSaleTimeValue>;
  public
    property result: Boolean read FResult write FResult;
    property value: TObjectList<TReportSaleTimeValue> read FValue;

  end;

implementation



end.
