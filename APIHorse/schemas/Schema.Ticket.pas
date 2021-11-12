unit Schema.Ticket;

interface

uses
   System.Generics.Collections, REST.Json.Types;
{$M+}

type
  TRecebimento = class
  private
    FCodFinalizadora: Integer;
    FFinalizadora: string;
    FTroco: Integer;
    FValor: Double;
  published
    property CodFinalizadora: Integer read FCodFinalizadora write FCodFinalizadora;
    property Finalizadora: string read FFinalizadora write FFinalizadora;
    property Troco: Integer read FTroco write FTroco;
    property Valor: Double read FValor write FValor;
  end;
  
  TMovimento = class
  private
    FCancelado: Boolean;
    FCfop: string;
    FCodProduto: string;
    FCompra: Double;
    FDesconto: Integer;
    FDescricao: string;
    FItem: string;
    FQuantidade: Double;
    FTotal: Double;
    FUnidade: string;
    FVenda: Double;
  published
    property Cancelado: Boolean read FCancelado write FCancelado;
    property Cfop: string read FCfop write FCfop;
    property CodProduto: string read FCodProduto write FCodProduto;
    property Compra: Double read FCompra write FCompra;
    property Desconto: Integer read FDesconto write FDesconto;
    property Descricao: string read FDescricao write FDescricao;
    property Item: string read FItem write FItem;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property Total: Double read FTotal write FTotal;
    property Unidade: string read FUnidade write FUnidade;
    property Venda: Double read FVenda write FVenda;
  end;
  TVendaResponse = class
  private
    Fresult: Boolean;
    procedure Setresult(const Value: Boolean);
  public
    property result: Boolean read Fresult write Setresult default True;
  end;



  TVenda = class
  private
    FAcrescimo: Integer;
    FCaixa: string;
    FCancelado: Boolean;
    FCnpj: string;
    FCodColaborador: Integer;
    FColaborador: string;
    FData: string;
    FDesconto: Integer;
    FDocCliente: string;
    FDocumento: string;
    FHora: string;
    [JSONName('Movimento'), JSONMarshalled(False)]
    FMovimentoArray: TArray<TMovimento>;
    [GenericListReflect]
    FMovimento: TObjectList<TMovimento>;
    FNomeCliente: string;
    FNumCCF: Integer;
    FRazao: string;
    [JSONName('Recebimento'), JSONMarshalled(False)]
    FRecebimentoArray: TArray<TRecebimento>;
    [GenericListReflect]
    FRecebimento: TObjectList<TRecebimento>;
    FSubTotal: Double;
    FValor: Double;


  public
    property Acrescimo: Integer read FAcrescimo write FAcrescimo;
    property Caixa: string read FCaixa write FCaixa;
    property Cancelado: Boolean read FCancelado write FCancelado;
    property Cnpj: string read FCnpj write FCnpj;
    property CodColaborador: Integer read FCodColaborador write FCodColaborador;
    property Colaborador: string read FColaborador write FColaborador;
    property Data: string read FData write FData;
    property Desconto: Integer read FDesconto write FDesconto;
    property DocCliente: string read FDocCliente write FDocCliente;
    property Documento: string read FDocumento write FDocumento;
    property Hora: string read FHora write FHora;
    property Movimento: TObjectList<TMovimento> read FMovimento;
    property NomeCliente: string read FNomeCliente write FNomeCliente;
    property NumCCF: Integer read FNumCCF write FNumCCF;
    property Razao: string read FRazao write FRazao;
    property Recebimento: TObjectList<TRecebimento> read FRecebimento;
    property SubTotal: Double read FSubTotal write FSubTotal;
    property Valor: Double read FValor write FValor;

  end;
  
implementation







{ TVendaResponse }

procedure TVendaResponse.Setresult(const Value: Boolean);
begin
  Fresult := Value;
end;





end.