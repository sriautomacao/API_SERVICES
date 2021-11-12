unit Schema.Report.ItemsServicesSold;

interface

uses
  System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TItemsServicesSoldValue = class
  private
    FCodProduto: string;
    FDescricao: string;
    FQTotal: Double;
    FTotalCompra: Double;
    FVTotal: Double;
    FValorLucro: Double;
  published
    property Cod_Produto: string read FCodProduto write FCodProduto;
    property Descricao: string read FDescricao write FDescricao;
    property QTotal: Double read FQTotal write FQTotal;
    property Total_Compra: Double read FTotalCompra write FTotalCompra;
    property VTotal: Double read FVTotal write FVTotal;
    property Valor_Lucro: Double read FValorLucro write FValorLucro;
  end;

  TReportItemsServicesSold = class
  private
    FResult: Boolean;
    FValueArray: TArray<TItemsServicesSoldValue>;
    [GenericListReflect]
    FValue: TObjectList<TItemsServicesSoldValue>;
  public
    property result: Boolean read FResult write FResult;
    property value: TObjectList<TItemsServicesSoldValue> read FValue;

  end;

implementation


end.
