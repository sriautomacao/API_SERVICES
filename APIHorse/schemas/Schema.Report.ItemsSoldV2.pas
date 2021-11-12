unit Schema.Report.ItemsSoldV2;

interface

uses
  System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TItemsSoldV2Value = class
  private
    FCodProduto: string;
    FDescricao: string;
    FQTotal: Double;
  published
    property Cod_Produto: string read FCodProduto write FCodProduto;
    property Descricao: string read FDescricao write FDescricao;
    property QTotal: Double read FQTotal write FQTotal;
  end;

  TReportItemsSoldV2 = class
  private
    FResult: Boolean;
    FValueArray: TArray<TItemsSoldV2Value>;
    [GenericListReflect]
    FValue: TObjectList<TItemsSoldV2Value>;

  public
    property result: Boolean read FResult write FResult;
    property value: TObjectList<TItemsSoldV2Value> read FValue;

  end;

implementation


end.
