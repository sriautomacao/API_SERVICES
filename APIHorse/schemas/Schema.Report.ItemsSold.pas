unit Schema.Report.ItemsSold;

interface

uses
  System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TItemsSoldValue = class
  private
    FCodProduto: string;
    FDescricao: string;
    FQTotal: Double;
    FTotalCompra: Double;
    FVTotal: Double;
    FValorLucro: Double;
  public
    property Cod_Produto: string read FCodProduto write FCodProduto;
    property Descricao: string read FDescricao write FDescricao;
    property QTotal: Double read FQTotal write FQTotal;
    property Total_Compra: Double read FTotalCompra write FTotalCompra;
    property VTotal: Double read FVTotal write FVTotal;
    property Valor_Lucro: Double read FValorLucro write FValorLucro;
  end;

  TReportItemsSold = class
  private
    FResult: Boolean;
    FValueArray: TArray<TItemsSoldValue>;
    [GenericListReflect]
    FValue: TObjectList<TItemsSoldValue>;
  public
    property result: Boolean read FResult write FResult;
    property value: TObjectList<TItemsSoldValue> read FValue;

  end;

implementation


end.
