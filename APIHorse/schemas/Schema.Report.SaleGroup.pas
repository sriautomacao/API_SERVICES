unit Schema.Report.SaleGroup;

interface

uses
 System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TReportSaleGroup = class
  private
    FCount: Integer;
    FResult: Boolean;
    FSum: Double;
  published
    property count: Integer read FCount write FCount;
    property result: Boolean read FResult write FResult;
    property sum: Double read FSum write FSum;
  end;

implementation

end.
