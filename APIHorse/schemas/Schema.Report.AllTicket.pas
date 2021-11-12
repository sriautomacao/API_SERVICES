unit Schema.Report.AllTicket;

interface

uses
  System.Generics.Collections, REST.Json.Types;


type
  TReportAllTicketValue = class
  private
    FCaixa: string;
    FHora: string;
    FTotal: Double;
  public
    property Caixa: string read FCaixa write FCaixa;
    property Hora: string read FHora write FHora;
    property Total: Double read FTotal write FTotal;
  end;

  TReportAllTicket = class
  private
    FResult: Boolean;
    FValueArray: TArray<TReportAllTicketValue>;
    FValue: TObjectList<TReportAllTicketValue>;
  public
    property result: Boolean read FResult write FResult;
    property value: TObjectList<TReportAllTicketValue> read FValue;

  end;

implementation



end.
