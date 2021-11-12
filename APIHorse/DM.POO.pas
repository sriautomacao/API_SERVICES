unit DM.POO;

interface

uses
  SysUtils, 
  Generics.Collections, 
  Aurelius.Mapping.Attributes, 
  Aurelius.Types.Blob, 
  Aurelius.Types.DynamicProperties, 
  Aurelius.Types.Nullable, 
  Aurelius.Types.Proxy, 
  Aurelius.Dictionary.Classes, 
  Aurelius.Linq;

type
  TPRODUTO = class;
  TPRODUTOXCOMPOSTO = class;
  TRECEBIMENTO = class;
  TSANGRIA = class;
  TSRIBANK = class;
  TTPR04 = class;
  TTPR05 = class;
  TVENDA = class;
  TPRODUTODictionary = class;
  TPRODUTOXCOMPOSTODictionary = class;
  TRECEBIMENTODictionary = class;
  TSANGRIADictionary = class;
  TSRIBANKDictionary = class;
  TTPR04Dictionary = class;
  TTPR05Dictionary = class;
  TVENDADictionary = class;
  
  [Entity]
  [Table('PRODUTO')]
  [UniqueKey('COD_PRODUTO')]
  [Id('FEMPRESA', TIdGenerator.None)]
  [Id('FCOD_INTERNO', TIdGenerator.None)]
  TPRODUTO = class
  private
    [Column('EMPRESA', [TColumnProp.Required])]
    FEMPRESA: Integer;
    
    [Column('COD_INTERNO', [TColumnProp.Required])]
    FCOD_INTERNO: Integer;
    
    [Column('COD_PRODUTO', [], 14)]
    FCOD_PRODUTO: Nullable<string>;
    
    [Column('DESCRICAO', [], 40)]
    FDESCRICAO: Nullable<string>;
    
    [Column('COD_GRUPO', [])]
    FCOD_GRUPO: Nullable<Integer>;
    
    [Column('COD_SUBGRUPO', [])]
    FCOD_SUBGRUPO: Nullable<Integer>;
    
    [Column('COD_LINHA', [])]
    FCOD_LINHA: Nullable<Integer>;
    
    [Column('BRUTO', [], 9, 3)]
    FBRUTO: Nullable<Double>;
    
    [Column('LIQUIDO', [], 9, 3)]
    FLIQUIDO: Nullable<Double>;
    
    [Column('ESTOQUE', [], 12, 3)]
    FESTOQUE: Nullable<Double>;
    
    [Column('CUSTO', [], 9, 2)]
    FCUSTO: Nullable<Double>;
    
    [Column('ICMS_IN', [], 4, 2)]
    FICMS_IN: Nullable<Double>;
    
    [Column('ST', [], 4)]
    FST: Nullable<string>;
    
    [Column('UNIDADE', [], 2)]
    FUNIDADE: Nullable<string>;
    
    [Column('MINIMO', [])]
    FMINIMO: Nullable<Integer>;
    
    [Column('ALIQUOTA', [], 2)]
    FALIQUOTA: Nullable<string>;
    
    [Column('TIPO', [], 1)]
    FTIPO: Nullable<string>;
    
    [Column('ICMS_OUT', [], 4, 2)]
    FICMS_OUT: Nullable<Double>;
    
    [Column('COFINS', [], 1)]
    FCOFINS: Nullable<string>;
    
    [Column('FEDERAL', [], 4, 2)]
    FFEDERAL: Nullable<Double>;
    
    [Column('VENDA_MARKUP', [], 9, 2)]
    FVENDA_MARKUP: Nullable<Double>;
    
    [Column('COMISSAO', [], 4, 2)]
    FCOMISSAO: Nullable<Double>;
    
    [Column('GONDOLA', [], 9, 2)]
    FGONDOLA: Nullable<Double>;
    
    [Column('RESERVADO', [], 9, 3)]
    FRESERVADO: Nullable<Double>;
    
    [Column('ULT_COMPRA', [], 9, 2)]
    FULT_COMPRA: Nullable<Double>;
    
    [Column('TIPO_VENDA', [], 1)]
    FTIPO_VENDA: Nullable<string>;
    
    [Column('MAXIMO', [])]
    FMAXIMO: Nullable<Integer>;
    
    [Column('COD_FABRICANTE', [])]
    FCOD_FABRICANTE: Nullable<Integer>;
    
    [Column('MULCOMISSAO', [], 4, 2)]
    FMULCOMISSAO: Nullable<Double>;
    
    [Column('ATACADO', [], 9, 2)]
    FATACADO: Nullable<Double>;
    
    [Column('ATACADO1', [], 9, 2)]
    FATACADO1: Nullable<Double>;
    
    [Column('ATACADO2', [], 9, 2)]
    FATACADO2: Nullable<Double>;
    
    [Column('VENDA', [], 9, 2)]
    FVENDA: Nullable<Double>;
    
    [Column('DATA_ULTCOMPRA', [])]
    FDATA_ULTCOMPRA: Nullable<TDateTime>;
    
    [Column('DATA_CADASTRO', [])]
    FDATA_CADASTRO: Nullable<TDateTime>;
    
    [Column('COD_COLABORADORCADASTRO', [])]
    FCOD_COLABORADORCADASTRO: Nullable<Integer>;
    
    [Column('DATA_ALTERACAO', [])]
    FDATA_ALTERACAO: Nullable<TDateTime>;
    
    [Column('COD_COLABORADORALTERACAO', [])]
    FCOD_COLABORADORALTERACAO: Nullable<Integer>;
    
    [Column('QTD_EMBALAGEM', [], 12, 4)]
    FQTD_EMBALAGEM: Nullable<Double>;
    
    [Column('PRECO_EMBALAGEM', [], 9, 2)]
    FPRECO_EMBALAGEM: Nullable<Double>;
    
    [Column('PAUTA', [], 9, 2)]
    FPAUTA: Nullable<Double>;
    
    [Column('DESC_ATACADO', [], 50)]
    FDESC_ATACADO: Nullable<string>;
    
    [Column('QTD_ULT_COMPRA', [], 9, 3)]
    FQTD_ULT_COMPRA: Nullable<Double>;
    
    [Column('DATA_ULT_COMPRA', [])]
    FDATA_ULT_COMPRA: Nullable<TDateTime>;
    
    [Column('PRECO_ULT_COMPRA', [], 12, 2)]
    FPRECO_ULT_COMPRA: Nullable<Double>;
    
    [Column('UND_EMBALAGEM', [], 10)]
    FUND_EMBALAGEM: Nullable<string>;
    
    [Column('QTD_ANTES_ULT_COMPRA', [], 9, 3)]
    FQTD_ANTES_ULT_COMPRA: Nullable<Double>;
    
    [Column('ST_PROMOCAO', [], 1)]
    FST_PROMOCAO: Nullable<string>;
    
    [Column('DATA_INICIO_PROM', [])]
    FDATA_INICIO_PROM: Nullable<TDateTime>;
    
    [Column('DATA_FINAL_PROM', [])]
    FDATA_FINAL_PROM: Nullable<TDateTime>;
    
    [Column('PRECO_PROM', [], 10, 2)]
    FPRECO_PROM: Nullable<Double>;
    
    [Column('DATA_ULT_VENDA', [])]
    FDATA_ULT_VENDA: Nullable<TDateTime>;
    
    [Column('COD_BARRA_EMBALAGEM', [], 14)]
    FCOD_BARRA_EMBALAGEM: Nullable<string>;
    
    [Column('BALANCA', [], 1)]
    FBALANCA: Nullable<string>;
    
    [Column('COD_NCM', [], 10)]
    FCOD_NCM: Nullable<string>;
    
    [Column('EX_IPI', [], 10)]
    FEX_IPI: Nullable<string>;
    
    [Column('COD_GEN', [])]
    FCOD_GEN: Nullable<Integer>;
    
    [Column('COD_LST', [])]
    FCOD_LST: Nullable<Integer>;
    
    [Column('INDARRTRUN', [], 1)]
    FINDARRTRUN: Nullable<string>;
    
    [Column('CSTPC', [])]
    FCSTPC: Nullable<Integer>;
    
    [Column('MOD_BCICMS', [], 2)]
    FMOD_BCICMS: Nullable<string>;
    
    [Column('MOD_BCICMSST', [], 2)]
    FMOD_BCICMSST: Nullable<string>;
    
    [Column('ALI_ICMSST', [], 2)]
    FALI_ICMSST: Nullable<string>;
    
    [Column('FABRICACAO', [], 1)]
    FFABRICACAO: Nullable<string>;
    
    [Column('QTD_VOL', [])]
    FQTD_VOL: Nullable<Integer>;
    
    [Column('PRECO_VOL', [], 9, 3)]
    FPRECO_VOL: Nullable<Double>;
    
    [Column('INATIVO', [], 1)]
    FINATIVO: Nullable<string>;
    
    [Column('CONTROLA_ESTOQUE', [], 1)]
    FCONTROLA_ESTOQUE: Nullable<string>;
    
    [Column('DESCRICAO_PROMOCAO', [], 25)]
    FDESCRICAO_PROMOCAO: Nullable<string>;
    
    [Column('PRED_BCST', [], 4, 2)]
    FPRED_BCST: Nullable<Double>;
    
    [Column('CREDITO_IN', [], 4, 2)]
    FCREDITO_IN: Nullable<Double>;
    
    [Column('CREDITO_OUT', [], 4, 2)]
    FCREDITO_OUT: Nullable<Double>;
    
    [Column('MVA_IN', [], 12, 2)]
    FMVA_IN: Nullable<Double>;
    
    [Column('MVA_OUT', [], 12, 2)]
    FMVA_OUT: Nullable<Double>;
    
    [Column('ALI_IPI', [], 4, 2)]
    FALI_IPI: Nullable<Double>;
    
    [Column('CSTIPI', [])]
    FCSTIPI: Nullable<Integer>;
    
    [Column('STATUS', [], 1)]
    FSTATUS: Nullable<string>;
    
    [Column('VAL_INFO', [], 300)]
    FVAL_INFO: Nullable<string>;
    
    [Column('CFOP_IN', [], 4)]
    FCFOP_IN: Nullable<string>;
    
    [Column('CFOP_OUT', [], 4)]
    FCFOP_OUT: Nullable<string>;
    
    [Column('MARKUP_VAREJO', [], 9, 2)]
    FMARKUP_VAREJO: Nullable<Double>;
    
    [Column('VENDA_MARKUP_VAREJO', [], 9, 2)]
    FVENDA_MARKUP_VAREJO: Nullable<Double>;
    
    [Column('STATUS_INV', [], 1)]
    FSTATUS_INV: Nullable<string>;
    
    [Column('LOCALIZACAO', [], 25)]
    FLOCALIZACAO: Nullable<string>;
    
    [Column('BAL_VALIDADE', [])]
    FBAL_VALIDADE: Nullable<Integer>;
    
    [Column('CRTL_SERIE', [], 1)]
    FCRTL_SERIE: Nullable<string>;
    
    [Column('COD_RECEITA_PIS', [], 3)]
    FCOD_RECEITA_PIS: Nullable<string>;
    
    [Column('CSTPC_ENTRADA', [])]
    FCSTPC_ENTRADA: Nullable<Integer>;
    
    [Column('ALI_PIS_CREDITO', [], 9, 4)]
    FALI_PIS_CREDITO: Nullable<Double>;
    
    [Column('ALI_PIS_DEBITO', [], 9, 4)]
    FALI_PIS_DEBITO: Nullable<Double>;
    
    [Column('ALI_COFINS_CREDITO', [], 9, 4)]
    FALI_COFINS_CREDITO: Nullable<Double>;
    
    [Column('ALI_COFINS_DEBITO', [], 9, 4)]
    FALI_COFINS_DEBITO: Nullable<Double>;
    
    [Column('VASILHAME', [], 1)]
    FVASILHAME: Nullable<string>;
    
    [Column('DATA_INV', [])]
    FDATA_INV: Nullable<TDateTime>;
    
    [Column('FAMILIA', [])]
    FFAMILIA: Nullable<Integer>;
    
    [Column('PERC_IBPT', [], 12, 4)]
    FPERC_IBPT: Nullable<Double>;
    
    [Column('REFERENCIA', [], 14)]
    FREFERENCIA: Nullable<string>;
    
    [Column('PRFUTURO', [], 9, 2)]
    FPRFUTURO: Nullable<Double>;
    
    [Column('COMPRA', [], 9, 2)]
    FCOMPRA: Nullable<Double>;
    
    [Column('MARKUP', [], 9, 2)]
    FMARKUP: Nullable<Double>;
    
    [Column('COTACAO', [], 1)]
    FCOTACAO: Nullable<string>;
    
    [Column('ST_OUT', [], 4)]
    FST_OUT: Nullable<string>;
    
    [Column('TIPO_VENDA_VOLUME', [], 1)]
    FTIPO_VENDA_VOLUME: Nullable<string>;
    
    [Column('CEST', [], 9)]
    FCEST: Nullable<string>;
    
    [Column('COR', [], 20)]
    FCOR: Nullable<string>;
    
    [Column('TAMANHO', [], 20)]
    FTAMANHO: Nullable<string>;
    
    [Column('PERC_AVISTA', [], 12, 2)]
    FPERC_AVISTA: Nullable<Double>;
    
    [Column('FUNDO_CP', [], 15, 2)]
    FFUNDO_CP: Nullable<Double>;
    
    [Column('ICMS_SUB', [], 15, 2)]
    FICMS_SUB: Nullable<Double>;
    
    [Column('ALIQUOTA_ICMS_SUB', [], 15, 2)]
    FALIQUOTA_ICMS_SUB: Nullable<Double>;
    
    [Column('VENDA_EMBALAGEM', [], 15, 2)]
    FVENDA_EMBALAGEM: Nullable<Double>;
  public
    property EMPRESA: Integer read FEMPRESA write FEMPRESA;
    property COD_INTERNO: Integer read FCOD_INTERNO write FCOD_INTERNO;
    property COD_PRODUTO: Nullable<string> read FCOD_PRODUTO write FCOD_PRODUTO;
    property DESCRICAO: Nullable<string> read FDESCRICAO write FDESCRICAO;
    property COD_GRUPO: Nullable<Integer> read FCOD_GRUPO write FCOD_GRUPO;
    property COD_SUBGRUPO: Nullable<Integer> read FCOD_SUBGRUPO write FCOD_SUBGRUPO;
    property COD_LINHA: Nullable<Integer> read FCOD_LINHA write FCOD_LINHA;
    property BRUTO: Nullable<Double> read FBRUTO write FBRUTO;
    property LIQUIDO: Nullable<Double> read FLIQUIDO write FLIQUIDO;
    property ESTOQUE: Nullable<Double> read FESTOQUE write FESTOQUE;
    property CUSTO: Nullable<Double> read FCUSTO write FCUSTO;
    property ICMS_IN: Nullable<Double> read FICMS_IN write FICMS_IN;
    property ST: Nullable<string> read FST write FST;
    property UNIDADE: Nullable<string> read FUNIDADE write FUNIDADE;
    property MINIMO: Nullable<Integer> read FMINIMO write FMINIMO;
    property ALIQUOTA: Nullable<string> read FALIQUOTA write FALIQUOTA;
    property TIPO: Nullable<string> read FTIPO write FTIPO;
    property ICMS_OUT: Nullable<Double> read FICMS_OUT write FICMS_OUT;
    property COFINS: Nullable<string> read FCOFINS write FCOFINS;
    property FEDERAL: Nullable<Double> read FFEDERAL write FFEDERAL;
    property VENDA_MARKUP: Nullable<Double> read FVENDA_MARKUP write FVENDA_MARKUP;
    property COMISSAO: Nullable<Double> read FCOMISSAO write FCOMISSAO;
    property GONDOLA: Nullable<Double> read FGONDOLA write FGONDOLA;
    property RESERVADO: Nullable<Double> read FRESERVADO write FRESERVADO;
    property ULT_COMPRA: Nullable<Double> read FULT_COMPRA write FULT_COMPRA;
    property TIPO_VENDA: Nullable<string> read FTIPO_VENDA write FTIPO_VENDA;
    property MAXIMO: Nullable<Integer> read FMAXIMO write FMAXIMO;
    property COD_FABRICANTE: Nullable<Integer> read FCOD_FABRICANTE write FCOD_FABRICANTE;
    property MULCOMISSAO: Nullable<Double> read FMULCOMISSAO write FMULCOMISSAO;
    property ATACADO: Nullable<Double> read FATACADO write FATACADO;
    property ATACADO1: Nullable<Double> read FATACADO1 write FATACADO1;
    property ATACADO2: Nullable<Double> read FATACADO2 write FATACADO2;
    property VENDA: Nullable<Double> read FVENDA write FVENDA;
    property DATA_ULTCOMPRA: Nullable<TDateTime> read FDATA_ULTCOMPRA write FDATA_ULTCOMPRA;
    property DATA_CADASTRO: Nullable<TDateTime> read FDATA_CADASTRO write FDATA_CADASTRO;
    property COD_COLABORADORCADASTRO: Nullable<Integer> read FCOD_COLABORADORCADASTRO write FCOD_COLABORADORCADASTRO;
    property DATA_ALTERACAO: Nullable<TDateTime> read FDATA_ALTERACAO write FDATA_ALTERACAO;
    property COD_COLABORADORALTERACAO: Nullable<Integer> read FCOD_COLABORADORALTERACAO write FCOD_COLABORADORALTERACAO;
    property QTD_EMBALAGEM: Nullable<Double> read FQTD_EMBALAGEM write FQTD_EMBALAGEM;
    property PRECO_EMBALAGEM: Nullable<Double> read FPRECO_EMBALAGEM write FPRECO_EMBALAGEM;
    property PAUTA: Nullable<Double> read FPAUTA write FPAUTA;
    property DESC_ATACADO: Nullable<string> read FDESC_ATACADO write FDESC_ATACADO;
    property QTD_ULT_COMPRA: Nullable<Double> read FQTD_ULT_COMPRA write FQTD_ULT_COMPRA;
    property DATA_ULT_COMPRA: Nullable<TDateTime> read FDATA_ULT_COMPRA write FDATA_ULT_COMPRA;
    property PRECO_ULT_COMPRA: Nullable<Double> read FPRECO_ULT_COMPRA write FPRECO_ULT_COMPRA;
    property UND_EMBALAGEM: Nullable<string> read FUND_EMBALAGEM write FUND_EMBALAGEM;
    property QTD_ANTES_ULT_COMPRA: Nullable<Double> read FQTD_ANTES_ULT_COMPRA write FQTD_ANTES_ULT_COMPRA;
    property ST_PROMOCAO: Nullable<string> read FST_PROMOCAO write FST_PROMOCAO;
    property DATA_INICIO_PROM: Nullable<TDateTime> read FDATA_INICIO_PROM write FDATA_INICIO_PROM;
    property DATA_FINAL_PROM: Nullable<TDateTime> read FDATA_FINAL_PROM write FDATA_FINAL_PROM;
    property PRECO_PROM: Nullable<Double> read FPRECO_PROM write FPRECO_PROM;
    property DATA_ULT_VENDA: Nullable<TDateTime> read FDATA_ULT_VENDA write FDATA_ULT_VENDA;
    property COD_BARRA_EMBALAGEM: Nullable<string> read FCOD_BARRA_EMBALAGEM write FCOD_BARRA_EMBALAGEM;
    property BALANCA: Nullable<string> read FBALANCA write FBALANCA;
    property COD_NCM: Nullable<string> read FCOD_NCM write FCOD_NCM;
    property EX_IPI: Nullable<string> read FEX_IPI write FEX_IPI;
    property COD_GEN: Nullable<Integer> read FCOD_GEN write FCOD_GEN;
    property COD_LST: Nullable<Integer> read FCOD_LST write FCOD_LST;
    property INDARRTRUN: Nullable<string> read FINDARRTRUN write FINDARRTRUN;
    property CSTPC: Nullable<Integer> read FCSTPC write FCSTPC;
    property MOD_BCICMS: Nullable<string> read FMOD_BCICMS write FMOD_BCICMS;
    property MOD_BCICMSST: Nullable<string> read FMOD_BCICMSST write FMOD_BCICMSST;
    property ALI_ICMSST: Nullable<string> read FALI_ICMSST write FALI_ICMSST;
    property FABRICACAO: Nullable<string> read FFABRICACAO write FFABRICACAO;
    property QTD_VOL: Nullable<Integer> read FQTD_VOL write FQTD_VOL;
    property PRECO_VOL: Nullable<Double> read FPRECO_VOL write FPRECO_VOL;
    property INATIVO: Nullable<string> read FINATIVO write FINATIVO;
    property CONTROLA_ESTOQUE: Nullable<string> read FCONTROLA_ESTOQUE write FCONTROLA_ESTOQUE;
    property DESCRICAO_PROMOCAO: Nullable<string> read FDESCRICAO_PROMOCAO write FDESCRICAO_PROMOCAO;
    property PRED_BCST: Nullable<Double> read FPRED_BCST write FPRED_BCST;
    property CREDITO_IN: Nullable<Double> read FCREDITO_IN write FCREDITO_IN;
    property CREDITO_OUT: Nullable<Double> read FCREDITO_OUT write FCREDITO_OUT;
    property MVA_IN: Nullable<Double> read FMVA_IN write FMVA_IN;
    property MVA_OUT: Nullable<Double> read FMVA_OUT write FMVA_OUT;
    property ALI_IPI: Nullable<Double> read FALI_IPI write FALI_IPI;
    property CSTIPI: Nullable<Integer> read FCSTIPI write FCSTIPI;
    property STATUS: Nullable<string> read FSTATUS write FSTATUS;
    property VAL_INFO: Nullable<string> read FVAL_INFO write FVAL_INFO;
    property CFOP_IN: Nullable<string> read FCFOP_IN write FCFOP_IN;
    property CFOP_OUT: Nullable<string> read FCFOP_OUT write FCFOP_OUT;
    property MARKUP_VAREJO: Nullable<Double> read FMARKUP_VAREJO write FMARKUP_VAREJO;
    property VENDA_MARKUP_VAREJO: Nullable<Double> read FVENDA_MARKUP_VAREJO write FVENDA_MARKUP_VAREJO;
    property STATUS_INV: Nullable<string> read FSTATUS_INV write FSTATUS_INV;
    property LOCALIZACAO: Nullable<string> read FLOCALIZACAO write FLOCALIZACAO;
    property BAL_VALIDADE: Nullable<Integer> read FBAL_VALIDADE write FBAL_VALIDADE;
    property CRTL_SERIE: Nullable<string> read FCRTL_SERIE write FCRTL_SERIE;
    property COD_RECEITA_PIS: Nullable<string> read FCOD_RECEITA_PIS write FCOD_RECEITA_PIS;
    property CSTPC_ENTRADA: Nullable<Integer> read FCSTPC_ENTRADA write FCSTPC_ENTRADA;
    property ALI_PIS_CREDITO: Nullable<Double> read FALI_PIS_CREDITO write FALI_PIS_CREDITO;
    property ALI_PIS_DEBITO: Nullable<Double> read FALI_PIS_DEBITO write FALI_PIS_DEBITO;
    property ALI_COFINS_CREDITO: Nullable<Double> read FALI_COFINS_CREDITO write FALI_COFINS_CREDITO;
    property ALI_COFINS_DEBITO: Nullable<Double> read FALI_COFINS_DEBITO write FALI_COFINS_DEBITO;
    property VASILHAME: Nullable<string> read FVASILHAME write FVASILHAME;
    property DATA_INV: Nullable<TDateTime> read FDATA_INV write FDATA_INV;
    property FAMILIA: Nullable<Integer> read FFAMILIA write FFAMILIA;
    property PERC_IBPT: Nullable<Double> read FPERC_IBPT write FPERC_IBPT;
    property REFERENCIA: Nullable<string> read FREFERENCIA write FREFERENCIA;
    property PRFUTURO: Nullable<Double> read FPRFUTURO write FPRFUTURO;
    property COMPRA: Nullable<Double> read FCOMPRA write FCOMPRA;
    property MARKUP: Nullable<Double> read FMARKUP write FMARKUP;
    property COTACAO: Nullable<string> read FCOTACAO write FCOTACAO;
    property ST_OUT: Nullable<string> read FST_OUT write FST_OUT;
    property TIPO_VENDA_VOLUME: Nullable<string> read FTIPO_VENDA_VOLUME write FTIPO_VENDA_VOLUME;
    property CEST: Nullable<string> read FCEST write FCEST;
    property COR: Nullable<string> read FCOR write FCOR;
    property TAMANHO: Nullable<string> read FTAMANHO write FTAMANHO;
    property PERC_AVISTA: Nullable<Double> read FPERC_AVISTA write FPERC_AVISTA;
    property FUNDO_CP: Nullable<Double> read FFUNDO_CP write FFUNDO_CP;
    property ICMS_SUB: Nullable<Double> read FICMS_SUB write FICMS_SUB;
    property ALIQUOTA_ICMS_SUB: Nullable<Double> read FALIQUOTA_ICMS_SUB write FALIQUOTA_ICMS_SUB;
    property VENDA_EMBALAGEM: Nullable<Double> read FVENDA_EMBALAGEM write FVENDA_EMBALAGEM;
  end;
  
  [Entity]
  [Table('PRODUTOXCOMPOSTO')]
  [Id('FCOD_PROD', TIdGenerator.None)]
  [Id('FBARRA', TIdGenerator.None)]
  TPRODUTOXCOMPOSTO = class
  private
    [Column('COD_PROD', [TColumnProp.Required], 14)]
    FCOD_PROD: string;
    
    [Column('BARRA', [TColumnProp.Required], 14)]
    FBARRA: string;
    
    [Column('PRECO', [], 15, 2)]
    FPRECO: Nullable<Double>;
    
    [Column('QTD', [], 9, 3)]
    FQTD: Nullable<Double>;
  public
    property COD_PROD: string read FCOD_PROD write FCOD_PROD;
    property BARRA: string read FBARRA write FBARRA;
    property PRECO: Nullable<Double> read FPRECO write FPRECO;
    property QTD: Nullable<Double> read FQTD write FQTD;
  end;
  
  [Entity]
  [Table('RECEBIMENTO')]
  [Id('FEMPRESA', TIdGenerator.None)]
  [Id('FCAIXA', TIdGenerator.None)]
  [Id('FDOCUMENTO', TIdGenerator.None)]
  [Id('FDATA', TIdGenerator.None)]
  [Id('FCOD_FINALIZADORA', TIdGenerator.None)]
  [Id('FCOD_COLABORADOR', TIdGenerator.None)]
  [Id('FNTEF', TIdGenerator.None)]
  [Id('FVALOR', TIdGenerator.None)]
  [Id('FSEQ', TIdGenerator.None)]
  TRECEBIMENTO = class
  private
    [Column('EMPRESA', [TColumnProp.Required])]
    FEMPRESA: Integer;
    
    [Column('CAIXA', [TColumnProp.Required], 10)]
    FCAIXA: string;
    
    [Column('DOCUMENTO', [TColumnProp.Required], 10)]
    FDOCUMENTO: string;
    
    [Column('DATA', [TColumnProp.Required])]
    FDATA: TDateTime;
    
    [Column('COD_FINALIZADORA', [TColumnProp.Required])]
    FCOD_FINALIZADORA: Integer;
    
    [Column('COD_COLABORADOR', [TColumnProp.Required])]
    FCOD_COLABORADOR: Integer;
    
    [Column('NTEF', [TColumnProp.Required], 6)]
    FNTEF: string;
    
    [Column('VALOR', [TColumnProp.Required], 12, 2)]
    FVALOR: Double;
    
    [Column('SEQ', [TColumnProp.Required])]
    FSEQ: Integer;
    
    [Column('FINALIZADORA', [], 15)]
    FFINALIZADORA: Nullable<string>;
    
    [Column('TROCO', [], 12, 2)]
    FTROCO: Nullable<Double>;
    
    [Column('COD_TIPO_MOVIMENTO', [])]
    FCOD_TIPO_MOVIMENTO: Nullable<Integer>;
    
    [Column('ORCAMENTO', [])]
    FORCAMENTO: Nullable<Double>;
    
    [Column('TEF', [])]
    FTEF: Nullable<Integer>;
    
    [Column('STATUS', [], 1)]
    FSTATUS: Nullable<string>;
    
    [Column('CFOP', [], 4)]
    FCFOP: Nullable<string>;
    
    [Column('CONTA_BANCARIA', [])]
    FCONTA_BANCARIA: Nullable<Integer>;
    
    [Column('PROCESSADO', [], 1)]
    FPROCESSADO: Nullable<string>;
    
    [Column('CARTAO', [], 1)]
    FCARTAO: Nullable<string>;
    
    [Column('PROCESSADO_POR', [])]
    FPROCESSADO_POR: Nullable<Integer>;
    
    [Column('PROCESSADO_EM', [])]
    FPROCESSADO_EM: Nullable<TDateTime>;
    
    [Column('IMPRESSO', [], 1)]
    FIMPRESSO: Nullable<string>;
    
    [Column('HORA', [])]
    FHORA: Nullable<TDateTime>;
    
    [Column('NSU', [], 100)]
    FNSU: Nullable<string>;
    
    [Column('COD_CLIENTE', [])]
    FCOD_CLIENTE: Nullable<Integer>;
    
    [Column('REDE', [], 50)]
    FREDE: Nullable<string>;
    
    [Column('DATA_TEF', [])]
    FDATA_TEF: Nullable<TDateTime>;
    
    [Column('HORA_TEF', [])]
    FHORA_TEF: Nullable<TDateTime>;
    
    [Column('COOCCD', [], 10)]
    FCOOCCD: Nullable<string>;
    
    [Column('PRODUTO', [], 20)]
    FPRODUTO: Nullable<string>;
    
    [Column('LOGICO', [], 15)]
    FLOGICO: Nullable<string>;
    
    [Column('NRPARCELAS', [])]
    FNRPARCELAS: Nullable<Integer>;
    
    [Column('VALE_TROCO', [])]
    FVALE_TROCO: Nullable<Integer>;
    
    [Column('ORIGEM', [])]
    FORIGEM: Nullable<Integer>;
    
    [Column('AUTORIZACAO', [], 40)]
    FAUTORIZACAO: Nullable<string>;
    
    [Column('DESC_IMP_REC', [], 20)]
    FDESC_IMP_REC: Nullable<string>;
    
    [Column('MSG', [], 4096)]
    FMSG: Nullable<string>;
    
    [Column('DOC_ORIGINAL', [], 6)]
    FDOC_ORIGINAL: Nullable<string>;
    
    [Column('CREDDEB', [])]
    FCREDDEB: Nullable<Integer>;
    
    [Column('BANDEIRA', [], 50)]
    FBANDEIRA: Nullable<string>;
    
    [Column('INTPOS', [TColumnProp.Lazy], 4096, 0)]
    FINTPOS: TBlob;
    
    [Column('ANALITICO', [])]
    FANALITICO: Nullable<Integer>;
    
    [Column('SINTETICO', [])]
    FSINTETICO: Nullable<Integer>;
    
    [Column('VIA01', [], 4096)]
    FVIA01: Nullable<string>;
    
    [Column('VIA02', [], 4096)]
    FVIA02: Nullable<string>;
    
    [Column('CNPJ_CREDENCIADA', [], 20)]
    FCNPJ_CREDENCIADA: Nullable<string>;
  public
    property EMPRESA: Integer read FEMPRESA write FEMPRESA;
    property CAIXA: string read FCAIXA write FCAIXA;
    property DOCUMENTO: string read FDOCUMENTO write FDOCUMENTO;
    property DATA: TDateTime read FDATA write FDATA;
    property COD_FINALIZADORA: Integer read FCOD_FINALIZADORA write FCOD_FINALIZADORA;
    property COD_COLABORADOR: Integer read FCOD_COLABORADOR write FCOD_COLABORADOR;
    property NTEF: string read FNTEF write FNTEF;
    property VALOR: Double read FVALOR write FVALOR;
    property SEQ: Integer read FSEQ write FSEQ;
    property FINALIZADORA: Nullable<string> read FFINALIZADORA write FFINALIZADORA;
    property TROCO: Nullable<Double> read FTROCO write FTROCO;
    property COD_TIPO_MOVIMENTO: Nullable<Integer> read FCOD_TIPO_MOVIMENTO write FCOD_TIPO_MOVIMENTO;
    property ORCAMENTO: Nullable<Double> read FORCAMENTO write FORCAMENTO;
    property TEF: Nullable<Integer> read FTEF write FTEF;
    property STATUS: Nullable<string> read FSTATUS write FSTATUS;
    property CFOP: Nullable<string> read FCFOP write FCFOP;
    property CONTA_BANCARIA: Nullable<Integer> read FCONTA_BANCARIA write FCONTA_BANCARIA;
    property PROCESSADO: Nullable<string> read FPROCESSADO write FPROCESSADO;
    property CARTAO: Nullable<string> read FCARTAO write FCARTAO;
    property PROCESSADO_POR: Nullable<Integer> read FPROCESSADO_POR write FPROCESSADO_POR;
    property PROCESSADO_EM: Nullable<TDateTime> read FPROCESSADO_EM write FPROCESSADO_EM;
    property IMPRESSO: Nullable<string> read FIMPRESSO write FIMPRESSO;
    property HORA: Nullable<TDateTime> read FHORA write FHORA;
    property NSU: Nullable<string> read FNSU write FNSU;
    property COD_CLIENTE: Nullable<Integer> read FCOD_CLIENTE write FCOD_CLIENTE;
    property REDE: Nullable<string> read FREDE write FREDE;
    property DATA_TEF: Nullable<TDateTime> read FDATA_TEF write FDATA_TEF;
    property HORA_TEF: Nullable<TDateTime> read FHORA_TEF write FHORA_TEF;
    property COOCCD: Nullable<string> read FCOOCCD write FCOOCCD;
    property PRODUTO: Nullable<string> read FPRODUTO write FPRODUTO;
    property LOGICO: Nullable<string> read FLOGICO write FLOGICO;
    property NRPARCELAS: Nullable<Integer> read FNRPARCELAS write FNRPARCELAS;
    property VALE_TROCO: Nullable<Integer> read FVALE_TROCO write FVALE_TROCO;
    property ORIGEM: Nullable<Integer> read FORIGEM write FORIGEM;
    property AUTORIZACAO: Nullable<string> read FAUTORIZACAO write FAUTORIZACAO;
    property DESC_IMP_REC: Nullable<string> read FDESC_IMP_REC write FDESC_IMP_REC;
    property MSG: Nullable<string> read FMSG write FMSG;
    property DOC_ORIGINAL: Nullable<string> read FDOC_ORIGINAL write FDOC_ORIGINAL;
    property CREDDEB: Nullable<Integer> read FCREDDEB write FCREDDEB;
    property BANDEIRA: Nullable<string> read FBANDEIRA write FBANDEIRA;
    property INTPOS: TBlob read FINTPOS write FINTPOS;
    property ANALITICO: Nullable<Integer> read FANALITICO write FANALITICO;
    property SINTETICO: Nullable<Integer> read FSINTETICO write FSINTETICO;
    property VIA01: Nullable<string> read FVIA01 write FVIA01;
    property VIA02: Nullable<string> read FVIA02 write FVIA02;
    property CNPJ_CREDENCIADA: Nullable<string> read FCNPJ_CREDENCIADA write FCNPJ_CREDENCIADA;
  end;
  
  [Entity]
  [Table('SANGRIA')]
  [Id('FNRFAB', TIdGenerator.None)]
  [Id('FNRDOCECF', TIdGenerator.None)]
  [Id('FDATA', TIdGenerator.None)]
  [Id('FTIPO', TIdGenerator.None)]
  [Id('FCOD_SANGRIA', TIdGenerator.None)]
  TSANGRIA = class
  private
    [Column('EMPRESA', [])]
    FEMPRESA: Nullable<Integer>;
    
    [Column('COD_SANGRIA', [TColumnProp.Required])]
    FCOD_SANGRIA: Integer;
    
    [Column('CAIXA', [], 3)]
    FCAIXA: Nullable<string>;
    
    [Column('VALOR', [], 15, 2)]
    FVALOR: Nullable<Double>;
    
    [Column('DATA', [TColumnProp.Required])]
    FDATA: TDateTime;
    
    [Column('COD_COLABORADOR', [])]
    FCOD_COLABORADOR: Nullable<Integer>;
    
    [Column('NRDOCECF', [TColumnProp.Required])]
    FNRDOCECF: Integer;
    
    [Column('TIPO', [TColumnProp.Required])]
    FTIPO: Integer;
    
    [Column('NRFAB', [TColumnProp.Required], 20)]
    FNRFAB: string;
    
    [Column('HORA', [])]
    FHORA: Nullable<TDateTime>;
    
    [Column('COD_GERENTE', [])]
    FCOD_GERENTE: Nullable<Integer>;
    
    [Column('MD5', [], 32)]
    FMD5: Nullable<string>;
  public
    property EMPRESA: Nullable<Integer> read FEMPRESA write FEMPRESA;
    property COD_SANGRIA: Integer read FCOD_SANGRIA write FCOD_SANGRIA;
    property CAIXA: Nullable<string> read FCAIXA write FCAIXA;
    property VALOR: Nullable<Double> read FVALOR write FVALOR;
    property DATA: TDateTime read FDATA write FDATA;
    property COD_COLABORADOR: Nullable<Integer> read FCOD_COLABORADOR write FCOD_COLABORADOR;
    property NRDOCECF: Integer read FNRDOCECF write FNRDOCECF;
    property TIPO: Integer read FTIPO write FTIPO;
    property NRFAB: string read FNRFAB write FNRFAB;
    property HORA: Nullable<TDateTime> read FHORA write FHORA;
    property COD_GERENTE: Nullable<Integer> read FCOD_GERENTE write FCOD_GERENTE;
    property MD5: Nullable<string> read FMD5 write FMD5;
  end;
  
  [Entity]
  [Table('SRIBANK')]
  [Id('FCNPJ', TIdGenerator.None)]
  TSRIBANK = class
  private
    [Column('CNPJ', [TColumnProp.Required], 14)]
    FCNPJ: string;
    
    [Column('ID_ACCOUNT', [], 36)]
    FID_ACCOUNT: Nullable<string>;
    
    [Column('ALIAS', [], 36)]
    FALIAS: Nullable<string>;
    
    [Column('ACCESS_TOKEN', [], 255)]
    FACCESS_TOKEN: Nullable<string>;
  public
    property CNPJ: string read FCNPJ write FCNPJ;
    property ID_ACCOUNT: Nullable<string> read FID_ACCOUNT write FID_ACCOUNT;
    property ALIAS: Nullable<string> read FALIAS write FALIAS;
    property ACCESS_TOKEN: Nullable<string> read FACCESS_TOKEN write FACCESS_TOKEN;
  end;
  
  [Entity]
  [Table('TPR04')]
  [Id('FSEQ', TIdGenerator.None)]
  [Id('FNUMCCF', TIdGenerator.None)]
  [Id('FDATAEMISSAO', TIdGenerator.None)]
  [Id('FDOCUMENTO', TIdGenerator.None)]
  TTPR04 = class
  private
    [Column('EMPRESA', [])]
    FEMPRESA: Nullable<Integer>;
    
    [Column('SEQ', [TColumnProp.Required])]
    FSEQ: Integer;
    
    [Column('NRFABRICACAO', [], 20)]
    FNRFABRICACAO: Nullable<string>;
    
    [Column('NUMCCF', [TColumnProp.Required])]
    FNUMCCF: Integer;
    
    [Column('LMFA', [], 1)]
    FLMFA: Nullable<string>;
    
    [Column('MODELOECF', [], 20)]
    FMODELOECF: Nullable<string>;
    
    [Column('NRUSUARIO', [], 2)]
    FNRUSUARIO: Nullable<string>;
    
    [Column('DOCUMENTO', [TColumnProp.Required])]
    FDOCUMENTO: Integer;
    
    [Column('DATAEMISSAO', [TColumnProp.Required])]
    FDATAEMISSAO: TDateTime;
    
    [Column('SUBTOTAL', [], 14, 2)]
    FSUBTOTAL: Nullable<Double>;
    
    [Column('DESCONTO', [], 12, 2)]
    FDESCONTO: Nullable<Double>;
    
    [Column('TIPODESC', [], 1)]
    FTIPODESC: Nullable<string>;
    
    [Column('ACRESCIMO', [], 12, 2)]
    FACRESCIMO: Nullable<Double>;
    
    [Column('TIPOACRE', [], 1)]
    FTIPOACRE: Nullable<string>;
    
    [Column('INDCANCELAMENTO', [], 1)]
    FINDCANCELAMENTO: Nullable<string>;
    
    [Column('CANCACRESC', [], 12, 2)]
    FCANCACRESC: Nullable<Double>;
    
    [Column('TOTALLIQUIDO', [], 12, 2)]
    FTOTALLIQUIDO: Nullable<Double>;
    
    [Column('INDREJEICAO', [], 1)]
    FINDREJEICAO: Nullable<string>;
    
    [Column('ORDEMAPLIQDESCACRES', [], 1)]
    FORDEMAPLIQDESCACRES: Nullable<string>;
    
    [Column('NOMEADQUIRENTE', [], 60)]
    FNOMEADQUIRENTE: Nullable<string>;
    
    [Column('CPFCNPJADQUIRENTE', [], 14)]
    FCPFCNPJADQUIRENTE: Nullable<string>;
    
    [Column('VL_PIS', [], 14, 2)]
    FVL_PIS: Nullable<Double>;
    
    [Column('VL_COFINS', [], 14, 2)]
    FVL_COFINS: Nullable<Double>;
    
    [Column('TRANSMITIDO', [], 1)]
    FTRANSMITIDO: Nullable<string>;
    
    [Column('TIPO_DOC', [], 2)]
    FTIPO_DOC: Nullable<string>;
  public
    property EMPRESA: Nullable<Integer> read FEMPRESA write FEMPRESA;
    property SEQ: Integer read FSEQ write FSEQ;
    property NRFABRICACAO: Nullable<string> read FNRFABRICACAO write FNRFABRICACAO;
    property NUMCCF: Integer read FNUMCCF write FNUMCCF;
    property LMFA: Nullable<string> read FLMFA write FLMFA;
    property MODELOECF: Nullable<string> read FMODELOECF write FMODELOECF;
    property NRUSUARIO: Nullable<string> read FNRUSUARIO write FNRUSUARIO;
    property DOCUMENTO: Integer read FDOCUMENTO write FDOCUMENTO;
    property DATAEMISSAO: TDateTime read FDATAEMISSAO write FDATAEMISSAO;
    property SUBTOTAL: Nullable<Double> read FSUBTOTAL write FSUBTOTAL;
    property DESCONTO: Nullable<Double> read FDESCONTO write FDESCONTO;
    property TIPODESC: Nullable<string> read FTIPODESC write FTIPODESC;
    property ACRESCIMO: Nullable<Double> read FACRESCIMO write FACRESCIMO;
    property TIPOACRE: Nullable<string> read FTIPOACRE write FTIPOACRE;
    property INDCANCELAMENTO: Nullable<string> read FINDCANCELAMENTO write FINDCANCELAMENTO;
    property CANCACRESC: Nullable<Double> read FCANCACRESC write FCANCACRESC;
    property TOTALLIQUIDO: Nullable<Double> read FTOTALLIQUIDO write FTOTALLIQUIDO;
    property INDREJEICAO: Nullable<string> read FINDREJEICAO write FINDREJEICAO;
    property ORDEMAPLIQDESCACRES: Nullable<string> read FORDEMAPLIQDESCACRES write FORDEMAPLIQDESCACRES;
    property NOMEADQUIRENTE: Nullable<string> read FNOMEADQUIRENTE write FNOMEADQUIRENTE;
    property CPFCNPJADQUIRENTE: Nullable<string> read FCPFCNPJADQUIRENTE write FCPFCNPJADQUIRENTE;
    property VL_PIS: Nullable<Double> read FVL_PIS write FVL_PIS;
    property VL_COFINS: Nullable<Double> read FVL_COFINS write FVL_COFINS;
    property TRANSMITIDO: Nullable<string> read FTRANSMITIDO write FTRANSMITIDO;
    property TIPO_DOC: Nullable<string> read FTIPO_DOC write FTIPO_DOC;
  end;
  
  [Entity]
  [Table('TPR05')]
  [Id('FSEQ', TIdGenerator.None)]
  [Id('FNRFABRICACAO', TIdGenerator.None)]
  [Id('FNRITEM', TIdGenerator.None)]
  [Id('FCOD_PRODUTO', TIdGenerator.None)]
  [Id('FDATA', TIdGenerator.None)]
  [Id('FDOCUMENTO', TIdGenerator.None)]
  TTPR05 = class
  private
    [Column('SEQ', [TColumnProp.Required])]
    FSEQ: Integer;
    
    [Column('TIPO', [], 3)]
    FTIPO: Nullable<string>;
    
    [Column('NRFABRICACAO', [TColumnProp.Required], 20)]
    FNRFABRICACAO: string;
    
    [Column('LMFA', [], 1)]
    FLMFA: Nullable<string>;
    
    [Column('MODELOECF', [], 20)]
    FMODELOECF: Nullable<string>;
    
    [Column('NRUSUARIO', [], 2)]
    FNRUSUARIO: Nullable<string>;
    
    [Column('DOCUMENTO', [TColumnProp.Required])]
    FDOCUMENTO: Integer;
    
    [Column('NRITEM', [TColumnProp.Required], 3)]
    FNRITEM: string;
    
    [Column('COD_PRODUTO', [TColumnProp.Required], 14)]
    FCOD_PRODUTO: string;
    
    [Column('DESCRICAO', [], 100)]
    FDESCRICAO: Nullable<string>;
    
    [Column('QUANTIDADE', [], 12, 4)]
    FQUANTIDADE: Nullable<Double>;
    
    [Column('UNIDADE', [], 3)]
    FUNIDADE: Nullable<string>;
    
    [Column('VALORUNITARIO', [], 12, 2)]
    FVALORUNITARIO: Nullable<Double>;
    
    [Column('DESCONTOITEM', [], 12, 2)]
    FDESCONTOITEM: Nullable<Double>;
    
    [Column('ACRESCIMOITEM', [], 12, 2)]
    FACRESCIMOITEM: Nullable<Double>;
    
    [Column('TOTALLIQUIDO', [], 14, 2)]
    FTOTALLIQUIDO: Nullable<Double>;
    
    [Column('TOTALIZADORPARCIAL', [], 14, 2)]
    FTOTALIZADORPARCIAL: Nullable<Double>;
    
    [Column('INDCANCELAMENTO', [], 1)]
    FINDCANCELAMENTO: Nullable<string>;
    
    [Column('QTDCANCELADA', [], 9)]
    FQTDCANCELADA: Nullable<string>;
    
    [Column('VALORCANCELADO', [], 12, 2)]
    FVALORCANCELADO: Nullable<Double>;
    
    [Column('CANCACRESITEM', [], 12, 2)]
    FCANCACRESITEM: Nullable<Double>;
    
    [Column('INDARREDTRUNC', [], 1)]
    FINDARREDTRUNC: Nullable<string>;
    
    [Column('INDPROD', [], 1)]
    FINDPROD: Nullable<string>;
    
    [Column('CASASDECQTD', [], 1)]
    FCASASDECQTD: Nullable<string>;
    
    [Column('CASADECVLR', [], 1)]
    FCASADECVLR: Nullable<string>;
    
    [Column('VL_PIS', [], 14, 2)]
    FVL_PIS: Nullable<Double>;
    
    [Column('VL_COFINS', [], 14, 2)]
    FVL_COFINS: Nullable<Double>;
    
    [Column('CST_ICMS', [], 4)]
    FCST_ICMS: Nullable<string>;
    
    [Column('CFOP', [], 4)]
    FCFOP: Nullable<string>;
    
    [Column('ALIQ_ICMS', [], 6, 2)]
    FALIQ_ICMS: Nullable<Double>;
    
    [Column('COD_ALIQ', [], 2)]
    FCOD_ALIQ: Nullable<string>;
    
    [Column('EMPRESA', [])]
    FEMPRESA: Nullable<Integer>;
    
    [Column('TRANSMITIDO', [], 1)]
    FTRANSMITIDO: Nullable<string>;
    
    [Column('DATA', [TColumnProp.Required])]
    FDATA: TDateTime;
    
    [Column('VAL_INFO', [], 300)]
    FVAL_INFO: Nullable<string>;
    
    [Column('COD_VENDEDOR', [])]
    FCOD_VENDEDOR: Nullable<Integer>;
    
    [Column('NRCX', [], 3)]
    FNRCX: Nullable<string>;
  public
    property SEQ: Integer read FSEQ write FSEQ;
    property TIPO: Nullable<string> read FTIPO write FTIPO;
    property NRFABRICACAO: string read FNRFABRICACAO write FNRFABRICACAO;
    property LMFA: Nullable<string> read FLMFA write FLMFA;
    property MODELOECF: Nullable<string> read FMODELOECF write FMODELOECF;
    property NRUSUARIO: Nullable<string> read FNRUSUARIO write FNRUSUARIO;
    property DOCUMENTO: Integer read FDOCUMENTO write FDOCUMENTO;
    property NRITEM: string read FNRITEM write FNRITEM;
    property COD_PRODUTO: string read FCOD_PRODUTO write FCOD_PRODUTO;
    property DESCRICAO: Nullable<string> read FDESCRICAO write FDESCRICAO;
    property QUANTIDADE: Nullable<Double> read FQUANTIDADE write FQUANTIDADE;
    property UNIDADE: Nullable<string> read FUNIDADE write FUNIDADE;
    property VALORUNITARIO: Nullable<Double> read FVALORUNITARIO write FVALORUNITARIO;
    property DESCONTOITEM: Nullable<Double> read FDESCONTOITEM write FDESCONTOITEM;
    property ACRESCIMOITEM: Nullable<Double> read FACRESCIMOITEM write FACRESCIMOITEM;
    property TOTALLIQUIDO: Nullable<Double> read FTOTALLIQUIDO write FTOTALLIQUIDO;
    property TOTALIZADORPARCIAL: Nullable<Double> read FTOTALIZADORPARCIAL write FTOTALIZADORPARCIAL;
    property INDCANCELAMENTO: Nullable<string> read FINDCANCELAMENTO write FINDCANCELAMENTO;
    property QTDCANCELADA: Nullable<string> read FQTDCANCELADA write FQTDCANCELADA;
    property VALORCANCELADO: Nullable<Double> read FVALORCANCELADO write FVALORCANCELADO;
    property CANCACRESITEM: Nullable<Double> read FCANCACRESITEM write FCANCACRESITEM;
    property INDARREDTRUNC: Nullable<string> read FINDARREDTRUNC write FINDARREDTRUNC;
    property INDPROD: Nullable<string> read FINDPROD write FINDPROD;
    property CASASDECQTD: Nullable<string> read FCASASDECQTD write FCASASDECQTD;
    property CASADECVLR: Nullable<string> read FCASADECVLR write FCASADECVLR;
    property VL_PIS: Nullable<Double> read FVL_PIS write FVL_PIS;
    property VL_COFINS: Nullable<Double> read FVL_COFINS write FVL_COFINS;
    property CST_ICMS: Nullable<string> read FCST_ICMS write FCST_ICMS;
    property CFOP: Nullable<string> read FCFOP write FCFOP;
    property ALIQ_ICMS: Nullable<Double> read FALIQ_ICMS write FALIQ_ICMS;
    property COD_ALIQ: Nullable<string> read FCOD_ALIQ write FCOD_ALIQ;
    property EMPRESA: Nullable<Integer> read FEMPRESA write FEMPRESA;
    property TRANSMITIDO: Nullable<string> read FTRANSMITIDO write FTRANSMITIDO;
    property DATA: TDateTime read FDATA write FDATA;
    property VAL_INFO: Nullable<string> read FVAL_INFO write FVAL_INFO;
    property COD_VENDEDOR: Nullable<Integer> read FCOD_VENDEDOR write FCOD_VENDEDOR;
    property NRCX: Nullable<string> read FNRCX write FNRCX;
  end;
  
  [Entity]
  [Table('VENDA')]
  [Id('FDATA', TIdGenerator.None)]
  [Id('FCAIXA', TIdGenerator.None)]
  [Id('FDOCUMENTO', TIdGenerator.None)]
  [Id('FEMPRESA', TIdGenerator.None)]
  TVENDA = class
  private
    [Column('EMPRESA', [TColumnProp.Required])]
    FEMPRESA: Integer;
    
    [Column('COD_VENDA', [])]
    FCOD_VENDA: Nullable<Integer>;
    
    [Column('DATA', [TColumnProp.Required])]
    FDATA: TDateTime;
    
    [Column('DOCUMENTO', [TColumnProp.Required], 10)]
    FDOCUMENTO: string;
    
    [Column('CAIXA', [TColumnProp.Required], 4)]
    FCAIXA: string;
    
    [Column('COD_COLABORADOR', [])]
    FCOD_COLABORADOR: Nullable<Integer>;
    
    [Column('TIPO_MOVIMENTO', [])]
    FTIPO_MOVIMENTO: Nullable<Integer>;
    
    [Column('RESPONSAVEL', [])]
    FRESPONSAVEL: Nullable<Integer>;
    
    [Column('CFOP', [], 4)]
    FCFOP: Nullable<string>;
    
    [Column('CANCELADO', [], 1)]
    FCANCELADO: Nullable<string>;
    
    [Column('VALOR', [], 12, 2)]
    FVALOR: Nullable<Double>;
    
    [Column('ICMS', [], 12, 2)]
    FICMS: Nullable<Double>;
    
    [Column('CREDITO', [], 12, 2)]
    FCREDITO: Nullable<Double>;
    
    [Column('FEDERAL', [], 12, 2)]
    FFEDERAL: Nullable<Double>;
    
    [Column('FORMA_PAGAMENTO', [])]
    FFORMA_PAGAMENTO: Nullable<Integer>;
    
    [Column('FATURADO', [], 1)]
    FFATURADO: Nullable<string>;
    
    [Column('DESCONTO', [], 12, 2)]
    FDESCONTO: Nullable<Double>;
    
    [Column('TOTAL', [], 12, 2)]
    FTOTAL: Nullable<Double>;
    
    [Column('SELO', [], 10)]
    FSELO: Nullable<string>;
    
    [Column('TRANSPORTADORA', [])]
    FTRANSPORTADORA: Nullable<Integer>;
    
    [Column('BRUTO', [], 12, 2)]
    FBRUTO: Nullable<Double>;
    
    [Column('LIQUIDO', [], 12, 2)]
    FLIQUIDO: Nullable<Double>;
    
    [Column('COMISSAO', [], 12, 2)]
    FCOMISSAO: Nullable<Double>;
    
    [Column('FRETE', [], 1)]
    FFRETE: Nullable<string>;
    
    [Column('PLACA', [], 8)]
    FPLACA: Nullable<string>;
    
    [Column('QUANTIDADE', [], 12, 4)]
    FQUANTIDADE: Nullable<Double>;
    
    [Column('ESPECIE', [], 10)]
    FESPECIE: Nullable<string>;
    
    [Column('COD_VENDEDOR', [])]
    FCOD_VENDEDOR: Nullable<Integer>;
    
    [Column('HORA', [])]
    FHORA: Nullable<TDateTime>;
    
    [Column('DATA_EMISSAO_NF', [])]
    FDATA_EMISSAO_NF: Nullable<TDateTime>;
    
    [Column('BASE_CALC_ICMS', [], 12, 2)]
    FBASE_CALC_ICMS: Nullable<Double>;
    
    [Column('ICMS_SUBST', [], 12, 2)]
    FICMS_SUBST: Nullable<Double>;
    
    [Column('BASE_CALC_SUBST', [], 12, 2)]
    FBASE_CALC_SUBST: Nullable<Double>;
    
    [Column('VALOR_FRETE', [], 12, 2)]
    FVALOR_FRETE: Nullable<Double>;
    
    [Column('SEGURO', [], 12, 2)]
    FSEGURO: Nullable<Double>;
    
    [Column('IPI', [], 12, 2)]
    FIPI: Nullable<Double>;
    
    [Column('DESPESAS', [], 12, 2)]
    FDESPESAS: Nullable<Double>;
    
    [Column('TIPO_DOC', [], 2)]
    FTIPO_DOC: Nullable<string>;
    
    [Column('NUMCCF', [])]
    FNUMCCF: Nullable<Integer>;
    
    [Column('CPFCNPJ', [], 17)]
    FCPFCNPJ: Nullable<string>;
    
    [Column('ACRESCIMO', [], 12, 2)]
    FACRESCIMO: Nullable<Double>;
    
    [Column('NOME_CLI', [], 60)]
    FNOME_CLI: Nullable<string>;
    
    [Column('ENDERECO_CLI', [], 100)]
    FENDERECO_CLI: Nullable<string>;
    
    [Column('NFCE_CHAVE', [], 44)]
    FNFCE_CHAVE: Nullable<string>;
    
    [Column('NFCE_STATUS', [])]
    FNFCE_STATUS: Nullable<Integer>;
    
    [Column('NFCE_MOTIVO', [], 100)]
    FNFCE_MOTIVO: Nullable<string>;
    
    [Column('XML_NFCE_ENVIO', [TColumnProp.Lazy], 4096, 0)]
    FXML_NFCE_ENVIO: TBlob;
    
    [Column('NFCE_CHAVE_SUFIXO', [], 8)]
    FNFCE_CHAVE_SUFIXO: Nullable<string>;
    
    [Column('CAN_REJEICAO', [], 1)]
    FCAN_REJEICAO: Nullable<string>;
    
    [Column('NUM_NFSE', [])]
    FNUM_NFSE: Nullable<Integer>;
    
    [Column('XML_NFSE', [TColumnProp.Lazy], 4096, 0)]
    FXML_NFSE: TBlob;
    
    [Column('PEDIDO', [], 100)]
    FPEDIDO: Nullable<string>;
  public
    property EMPRESA: Integer read FEMPRESA write FEMPRESA;
    property COD_VENDA: Nullable<Integer> read FCOD_VENDA write FCOD_VENDA;
    property DATA: TDateTime read FDATA write FDATA;
    property DOCUMENTO: string read FDOCUMENTO write FDOCUMENTO;
    property CAIXA: string read FCAIXA write FCAIXA;
    property COD_COLABORADOR: Nullable<Integer> read FCOD_COLABORADOR write FCOD_COLABORADOR;
    property TIPO_MOVIMENTO: Nullable<Integer> read FTIPO_MOVIMENTO write FTIPO_MOVIMENTO;
    property RESPONSAVEL: Nullable<Integer> read FRESPONSAVEL write FRESPONSAVEL;
    property CFOP: Nullable<string> read FCFOP write FCFOP;
    property CANCELADO: Nullable<string> read FCANCELADO write FCANCELADO;
    property VALOR: Nullable<Double> read FVALOR write FVALOR;
    property ICMS: Nullable<Double> read FICMS write FICMS;
    property CREDITO: Nullable<Double> read FCREDITO write FCREDITO;
    property FEDERAL: Nullable<Double> read FFEDERAL write FFEDERAL;
    property FORMA_PAGAMENTO: Nullable<Integer> read FFORMA_PAGAMENTO write FFORMA_PAGAMENTO;
    property FATURADO: Nullable<string> read FFATURADO write FFATURADO;
    property DESCONTO: Nullable<Double> read FDESCONTO write FDESCONTO;
    property TOTAL: Nullable<Double> read FTOTAL write FTOTAL;
    property SELO: Nullable<string> read FSELO write FSELO;
    property TRANSPORTADORA: Nullable<Integer> read FTRANSPORTADORA write FTRANSPORTADORA;
    property BRUTO: Nullable<Double> read FBRUTO write FBRUTO;
    property LIQUIDO: Nullable<Double> read FLIQUIDO write FLIQUIDO;
    property COMISSAO: Nullable<Double> read FCOMISSAO write FCOMISSAO;
    property FRETE: Nullable<string> read FFRETE write FFRETE;
    property PLACA: Nullable<string> read FPLACA write FPLACA;
    property QUANTIDADE: Nullable<Double> read FQUANTIDADE write FQUANTIDADE;
    property ESPECIE: Nullable<string> read FESPECIE write FESPECIE;
    property COD_VENDEDOR: Nullable<Integer> read FCOD_VENDEDOR write FCOD_VENDEDOR;
    property HORA: Nullable<TDateTime> read FHORA write FHORA;
    property DATA_EMISSAO_NF: Nullable<TDateTime> read FDATA_EMISSAO_NF write FDATA_EMISSAO_NF;
    property BASE_CALC_ICMS: Nullable<Double> read FBASE_CALC_ICMS write FBASE_CALC_ICMS;
    property ICMS_SUBST: Nullable<Double> read FICMS_SUBST write FICMS_SUBST;
    property BASE_CALC_SUBST: Nullable<Double> read FBASE_CALC_SUBST write FBASE_CALC_SUBST;
    property VALOR_FRETE: Nullable<Double> read FVALOR_FRETE write FVALOR_FRETE;
    property SEGURO: Nullable<Double> read FSEGURO write FSEGURO;
    property IPI: Nullable<Double> read FIPI write FIPI;
    property DESPESAS: Nullable<Double> read FDESPESAS write FDESPESAS;
    property TIPO_DOC: Nullable<string> read FTIPO_DOC write FTIPO_DOC;
    property NUMCCF: Nullable<Integer> read FNUMCCF write FNUMCCF;
    property CPFCNPJ: Nullable<string> read FCPFCNPJ write FCPFCNPJ;
    property ACRESCIMO: Nullable<Double> read FACRESCIMO write FACRESCIMO;
    property NOME_CLI: Nullable<string> read FNOME_CLI write FNOME_CLI;
    property ENDERECO_CLI: Nullable<string> read FENDERECO_CLI write FENDERECO_CLI;
    property NFCE_CHAVE: Nullable<string> read FNFCE_CHAVE write FNFCE_CHAVE;
    property NFCE_STATUS: Nullable<Integer> read FNFCE_STATUS write FNFCE_STATUS;
    property NFCE_MOTIVO: Nullable<string> read FNFCE_MOTIVO write FNFCE_MOTIVO;
    property XML_NFCE_ENVIO: TBlob read FXML_NFCE_ENVIO write FXML_NFCE_ENVIO;
    property NFCE_CHAVE_SUFIXO: Nullable<string> read FNFCE_CHAVE_SUFIXO write FNFCE_CHAVE_SUFIXO;
    property CAN_REJEICAO: Nullable<string> read FCAN_REJEICAO write FCAN_REJEICAO;
    property NUM_NFSE: Nullable<Integer> read FNUM_NFSE write FNUM_NFSE;
    property XML_NFSE: TBlob read FXML_NFSE write FXML_NFSE;
    property PEDIDO: Nullable<string> read FPEDIDO write FPEDIDO;
  end;
  
  IPRODUTODictionary = interface;
  
  IPRODUTOXCOMPOSTODictionary = interface;
  
  IRECEBIMENTODictionary = interface;
  
  ISANGRIADictionary = interface;
  
  ISRIBANKDictionary = interface;
  
  ITPR04Dictionary = interface;
  
  ITPR05Dictionary = interface;
  
  IVENDADictionary = interface;
  
  IPRODUTODictionary = interface(IAureliusEntityDictionary)
    function EMPRESA: TLinqProjection;
    function COD_INTERNO: TLinqProjection;
    function COD_PRODUTO: TLinqProjection;
    function DESCRICAO: TLinqProjection;
    function COD_GRUPO: TLinqProjection;
    function COD_SUBGRUPO: TLinqProjection;
    function COD_LINHA: TLinqProjection;
    function BRUTO: TLinqProjection;
    function LIQUIDO: TLinqProjection;
    function ESTOQUE: TLinqProjection;
    function CUSTO: TLinqProjection;
    function ICMS_IN: TLinqProjection;
    function ST: TLinqProjection;
    function UNIDADE: TLinqProjection;
    function MINIMO: TLinqProjection;
    function ALIQUOTA: TLinqProjection;
    function TIPO: TLinqProjection;
    function ICMS_OUT: TLinqProjection;
    function COFINS: TLinqProjection;
    function FEDERAL: TLinqProjection;
    function VENDA_MARKUP: TLinqProjection;
    function COMISSAO: TLinqProjection;
    function GONDOLA: TLinqProjection;
    function RESERVADO: TLinqProjection;
    function ULT_COMPRA: TLinqProjection;
    function TIPO_VENDA: TLinqProjection;
    function MAXIMO: TLinqProjection;
    function COD_FABRICANTE: TLinqProjection;
    function MULCOMISSAO: TLinqProjection;
    function ATACADO: TLinqProjection;
    function ATACADO1: TLinqProjection;
    function ATACADO2: TLinqProjection;
    function VENDA: TLinqProjection;
    function DATA_ULTCOMPRA: TLinqProjection;
    function DATA_CADASTRO: TLinqProjection;
    function COD_COLABORADORCADASTRO: TLinqProjection;
    function DATA_ALTERACAO: TLinqProjection;
    function COD_COLABORADORALTERACAO: TLinqProjection;
    function QTD_EMBALAGEM: TLinqProjection;
    function PRECO_EMBALAGEM: TLinqProjection;
    function PAUTA: TLinqProjection;
    function DESC_ATACADO: TLinqProjection;
    function QTD_ULT_COMPRA: TLinqProjection;
    function DATA_ULT_COMPRA: TLinqProjection;
    function PRECO_ULT_COMPRA: TLinqProjection;
    function UND_EMBALAGEM: TLinqProjection;
    function QTD_ANTES_ULT_COMPRA: TLinqProjection;
    function ST_PROMOCAO: TLinqProjection;
    function DATA_INICIO_PROM: TLinqProjection;
    function DATA_FINAL_PROM: TLinqProjection;
    function PRECO_PROM: TLinqProjection;
    function DATA_ULT_VENDA: TLinqProjection;
    function COD_BARRA_EMBALAGEM: TLinqProjection;
    function BALANCA: TLinqProjection;
    function COD_NCM: TLinqProjection;
    function EX_IPI: TLinqProjection;
    function COD_GEN: TLinqProjection;
    function COD_LST: TLinqProjection;
    function INDARRTRUN: TLinqProjection;
    function CSTPC: TLinqProjection;
    function MOD_BCICMS: TLinqProjection;
    function MOD_BCICMSST: TLinqProjection;
    function ALI_ICMSST: TLinqProjection;
    function FABRICACAO: TLinqProjection;
    function QTD_VOL: TLinqProjection;
    function PRECO_VOL: TLinqProjection;
    function INATIVO: TLinqProjection;
    function CONTROLA_ESTOQUE: TLinqProjection;
    function DESCRICAO_PROMOCAO: TLinqProjection;
    function PRED_BCST: TLinqProjection;
    function CREDITO_IN: TLinqProjection;
    function CREDITO_OUT: TLinqProjection;
    function MVA_IN: TLinqProjection;
    function MVA_OUT: TLinqProjection;
    function ALI_IPI: TLinqProjection;
    function CSTIPI: TLinqProjection;
    function STATUS: TLinqProjection;
    function VAL_INFO: TLinqProjection;
    function CFOP_IN: TLinqProjection;
    function CFOP_OUT: TLinqProjection;
    function MARKUP_VAREJO: TLinqProjection;
    function VENDA_MARKUP_VAREJO: TLinqProjection;
    function STATUS_INV: TLinqProjection;
    function LOCALIZACAO: TLinqProjection;
    function BAL_VALIDADE: TLinqProjection;
    function CRTL_SERIE: TLinqProjection;
    function COD_RECEITA_PIS: TLinqProjection;
    function CSTPC_ENTRADA: TLinqProjection;
    function ALI_PIS_CREDITO: TLinqProjection;
    function ALI_PIS_DEBITO: TLinqProjection;
    function ALI_COFINS_CREDITO: TLinqProjection;
    function ALI_COFINS_DEBITO: TLinqProjection;
    function VASILHAME: TLinqProjection;
    function DATA_INV: TLinqProjection;
    function FAMILIA: TLinqProjection;
    function PERC_IBPT: TLinqProjection;
    function REFERENCIA: TLinqProjection;
    function PRFUTURO: TLinqProjection;
    function COMPRA: TLinqProjection;
    function MARKUP: TLinqProjection;
    function COTACAO: TLinqProjection;
    function ST_OUT: TLinqProjection;
    function TIPO_VENDA_VOLUME: TLinqProjection;
    function CEST: TLinqProjection;
    function COR: TLinqProjection;
    function TAMANHO: TLinqProjection;
    function PERC_AVISTA: TLinqProjection;
    function FUNDO_CP: TLinqProjection;
    function ICMS_SUB: TLinqProjection;
    function ALIQUOTA_ICMS_SUB: TLinqProjection;
    function VENDA_EMBALAGEM: TLinqProjection;
  end;
  
  IPRODUTOXCOMPOSTODictionary = interface(IAureliusEntityDictionary)
    function COD_PROD: TLinqProjection;
    function BARRA: TLinqProjection;
    function PRECO: TLinqProjection;
    function QTD: TLinqProjection;
  end;
  
  IRECEBIMENTODictionary = interface(IAureliusEntityDictionary)
    function EMPRESA: TLinqProjection;
    function CAIXA: TLinqProjection;
    function DOCUMENTO: TLinqProjection;
    function DATA: TLinqProjection;
    function COD_FINALIZADORA: TLinqProjection;
    function COD_COLABORADOR: TLinqProjection;
    function NTEF: TLinqProjection;
    function VALOR: TLinqProjection;
    function SEQ: TLinqProjection;
    function FINALIZADORA: TLinqProjection;
    function TROCO: TLinqProjection;
    function COD_TIPO_MOVIMENTO: TLinqProjection;
    function ORCAMENTO: TLinqProjection;
    function TEF: TLinqProjection;
    function STATUS: TLinqProjection;
    function CFOP: TLinqProjection;
    function CONTA_BANCARIA: TLinqProjection;
    function PROCESSADO: TLinqProjection;
    function CARTAO: TLinqProjection;
    function PROCESSADO_POR: TLinqProjection;
    function PROCESSADO_EM: TLinqProjection;
    function IMPRESSO: TLinqProjection;
    function HORA: TLinqProjection;
    function NSU: TLinqProjection;
    function COD_CLIENTE: TLinqProjection;
    function REDE: TLinqProjection;
    function DATA_TEF: TLinqProjection;
    function HORA_TEF: TLinqProjection;
    function COOCCD: TLinqProjection;
    function PRODUTO: TLinqProjection;
    function LOGICO: TLinqProjection;
    function NRPARCELAS: TLinqProjection;
    function VALE_TROCO: TLinqProjection;
    function ORIGEM: TLinqProjection;
    function AUTORIZACAO: TLinqProjection;
    function DESC_IMP_REC: TLinqProjection;
    function MSG: TLinqProjection;
    function DOC_ORIGINAL: TLinqProjection;
    function CREDDEB: TLinqProjection;
    function BANDEIRA: TLinqProjection;
    function INTPOS: TLinqProjection;
    function ANALITICO: TLinqProjection;
    function SINTETICO: TLinqProjection;
    function VIA01: TLinqProjection;
    function VIA02: TLinqProjection;
    function CNPJ_CREDENCIADA: TLinqProjection;
  end;
  
  ISANGRIADictionary = interface(IAureliusEntityDictionary)
    function EMPRESA: TLinqProjection;
    function COD_SANGRIA: TLinqProjection;
    function CAIXA: TLinqProjection;
    function VALOR: TLinqProjection;
    function DATA: TLinqProjection;
    function COD_COLABORADOR: TLinqProjection;
    function NRDOCECF: TLinqProjection;
    function TIPO: TLinqProjection;
    function NRFAB: TLinqProjection;
    function HORA: TLinqProjection;
    function COD_GERENTE: TLinqProjection;
    function MD5: TLinqProjection;
  end;
  
  ISRIBANKDictionary = interface(IAureliusEntityDictionary)
    function CNPJ: TLinqProjection;
    function ID_ACCOUNT: TLinqProjection;
    function ALIAS: TLinqProjection;
    function ACCESS_TOKEN: TLinqProjection;
  end;
  
  ITPR04Dictionary = interface(IAureliusEntityDictionary)
    function EMPRESA: TLinqProjection;
    function SEQ: TLinqProjection;
    function NRFABRICACAO: TLinqProjection;
    function NUMCCF: TLinqProjection;
    function LMFA: TLinqProjection;
    function MODELOECF: TLinqProjection;
    function NRUSUARIO: TLinqProjection;
    function DOCUMENTO: TLinqProjection;
    function DATAEMISSAO: TLinqProjection;
    function SUBTOTAL: TLinqProjection;
    function DESCONTO: TLinqProjection;
    function TIPODESC: TLinqProjection;
    function ACRESCIMO: TLinqProjection;
    function TIPOACRE: TLinqProjection;
    function INDCANCELAMENTO: TLinqProjection;
    function CANCACRESC: TLinqProjection;
    function TOTALLIQUIDO: TLinqProjection;
    function INDREJEICAO: TLinqProjection;
    function ORDEMAPLIQDESCACRES: TLinqProjection;
    function NOMEADQUIRENTE: TLinqProjection;
    function CPFCNPJADQUIRENTE: TLinqProjection;
    function VL_PIS: TLinqProjection;
    function VL_COFINS: TLinqProjection;
    function TRANSMITIDO: TLinqProjection;
    function TIPO_DOC: TLinqProjection;
  end;
  
  ITPR05Dictionary = interface(IAureliusEntityDictionary)
    function SEQ: TLinqProjection;
    function TIPO: TLinqProjection;
    function NRFABRICACAO: TLinqProjection;
    function LMFA: TLinqProjection;
    function MODELOECF: TLinqProjection;
    function NRUSUARIO: TLinqProjection;
    function DOCUMENTO: TLinqProjection;
    function NRITEM: TLinqProjection;
    function COD_PRODUTO: TLinqProjection;
    function DESCRICAO: TLinqProjection;
    function QUANTIDADE: TLinqProjection;
    function UNIDADE: TLinqProjection;
    function VALORUNITARIO: TLinqProjection;
    function DESCONTOITEM: TLinqProjection;
    function ACRESCIMOITEM: TLinqProjection;
    function TOTALLIQUIDO: TLinqProjection;
    function TOTALIZADORPARCIAL: TLinqProjection;
    function INDCANCELAMENTO: TLinqProjection;
    function QTDCANCELADA: TLinqProjection;
    function VALORCANCELADO: TLinqProjection;
    function CANCACRESITEM: TLinqProjection;
    function INDARREDTRUNC: TLinqProjection;
    function INDPROD: TLinqProjection;
    function CASASDECQTD: TLinqProjection;
    function CASADECVLR: TLinqProjection;
    function VL_PIS: TLinqProjection;
    function VL_COFINS: TLinqProjection;
    function CST_ICMS: TLinqProjection;
    function CFOP: TLinqProjection;
    function ALIQ_ICMS: TLinqProjection;
    function COD_ALIQ: TLinqProjection;
    function EMPRESA: TLinqProjection;
    function TRANSMITIDO: TLinqProjection;
    function DATA: TLinqProjection;
    function VAL_INFO: TLinqProjection;
    function COD_VENDEDOR: TLinqProjection;
    function NRCX: TLinqProjection;
  end;
  
  IVENDADictionary = interface(IAureliusEntityDictionary)
    function EMPRESA: TLinqProjection;
    function COD_VENDA: TLinqProjection;
    function DATA: TLinqProjection;
    function DOCUMENTO: TLinqProjection;
    function CAIXA: TLinqProjection;
    function COD_COLABORADOR: TLinqProjection;
    function TIPO_MOVIMENTO: TLinqProjection;
    function RESPONSAVEL: TLinqProjection;
    function CFOP: TLinqProjection;
    function CANCELADO: TLinqProjection;
    function VALOR: TLinqProjection;
    function ICMS: TLinqProjection;
    function CREDITO: TLinqProjection;
    function FEDERAL: TLinqProjection;
    function FORMA_PAGAMENTO: TLinqProjection;
    function FATURADO: TLinqProjection;
    function DESCONTO: TLinqProjection;
    function TOTAL: TLinqProjection;
    function SELO: TLinqProjection;
    function TRANSPORTADORA: TLinqProjection;
    function BRUTO: TLinqProjection;
    function LIQUIDO: TLinqProjection;
    function COMISSAO: TLinqProjection;
    function FRETE: TLinqProjection;
    function PLACA: TLinqProjection;
    function QUANTIDADE: TLinqProjection;
    function ESPECIE: TLinqProjection;
    function COD_VENDEDOR: TLinqProjection;
    function HORA: TLinqProjection;
    function DATA_EMISSAO_NF: TLinqProjection;
    function BASE_CALC_ICMS: TLinqProjection;
    function ICMS_SUBST: TLinqProjection;
    function BASE_CALC_SUBST: TLinqProjection;
    function VALOR_FRETE: TLinqProjection;
    function SEGURO: TLinqProjection;
    function IPI: TLinqProjection;
    function DESPESAS: TLinqProjection;
    function TIPO_DOC: TLinqProjection;
    function NUMCCF: TLinqProjection;
    function CPFCNPJ: TLinqProjection;
    function ACRESCIMO: TLinqProjection;
    function NOME_CLI: TLinqProjection;
    function ENDERECO_CLI: TLinqProjection;
    function NFCE_CHAVE: TLinqProjection;
    function NFCE_STATUS: TLinqProjection;
    function NFCE_MOTIVO: TLinqProjection;
    function XML_NFCE_ENVIO: TLinqProjection;
    function NFCE_CHAVE_SUFIXO: TLinqProjection;
    function CAN_REJEICAO: TLinqProjection;
    function NUM_NFSE: TLinqProjection;
    function XML_NFSE: TLinqProjection;
    function PEDIDO: TLinqProjection;
  end;
  
  TPRODUTODictionary = class(TAureliusEntityDictionary, IPRODUTODictionary)
  public
    function EMPRESA: TLinqProjection;
    function COD_INTERNO: TLinqProjection;
    function COD_PRODUTO: TLinqProjection;
    function DESCRICAO: TLinqProjection;
    function COD_GRUPO: TLinqProjection;
    function COD_SUBGRUPO: TLinqProjection;
    function COD_LINHA: TLinqProjection;
    function BRUTO: TLinqProjection;
    function LIQUIDO: TLinqProjection;
    function ESTOQUE: TLinqProjection;
    function CUSTO: TLinqProjection;
    function ICMS_IN: TLinqProjection;
    function ST: TLinqProjection;
    function UNIDADE: TLinqProjection;
    function MINIMO: TLinqProjection;
    function ALIQUOTA: TLinqProjection;
    function TIPO: TLinqProjection;
    function ICMS_OUT: TLinqProjection;
    function COFINS: TLinqProjection;
    function FEDERAL: TLinqProjection;
    function VENDA_MARKUP: TLinqProjection;
    function COMISSAO: TLinqProjection;
    function GONDOLA: TLinqProjection;
    function RESERVADO: TLinqProjection;
    function ULT_COMPRA: TLinqProjection;
    function TIPO_VENDA: TLinqProjection;
    function MAXIMO: TLinqProjection;
    function COD_FABRICANTE: TLinqProjection;
    function MULCOMISSAO: TLinqProjection;
    function ATACADO: TLinqProjection;
    function ATACADO1: TLinqProjection;
    function ATACADO2: TLinqProjection;
    function VENDA: TLinqProjection;
    function DATA_ULTCOMPRA: TLinqProjection;
    function DATA_CADASTRO: TLinqProjection;
    function COD_COLABORADORCADASTRO: TLinqProjection;
    function DATA_ALTERACAO: TLinqProjection;
    function COD_COLABORADORALTERACAO: TLinqProjection;
    function QTD_EMBALAGEM: TLinqProjection;
    function PRECO_EMBALAGEM: TLinqProjection;
    function PAUTA: TLinqProjection;
    function DESC_ATACADO: TLinqProjection;
    function QTD_ULT_COMPRA: TLinqProjection;
    function DATA_ULT_COMPRA: TLinqProjection;
    function PRECO_ULT_COMPRA: TLinqProjection;
    function UND_EMBALAGEM: TLinqProjection;
    function QTD_ANTES_ULT_COMPRA: TLinqProjection;
    function ST_PROMOCAO: TLinqProjection;
    function DATA_INICIO_PROM: TLinqProjection;
    function DATA_FINAL_PROM: TLinqProjection;
    function PRECO_PROM: TLinqProjection;
    function DATA_ULT_VENDA: TLinqProjection;
    function COD_BARRA_EMBALAGEM: TLinqProjection;
    function BALANCA: TLinqProjection;
    function COD_NCM: TLinqProjection;
    function EX_IPI: TLinqProjection;
    function COD_GEN: TLinqProjection;
    function COD_LST: TLinqProjection;
    function INDARRTRUN: TLinqProjection;
    function CSTPC: TLinqProjection;
    function MOD_BCICMS: TLinqProjection;
    function MOD_BCICMSST: TLinqProjection;
    function ALI_ICMSST: TLinqProjection;
    function FABRICACAO: TLinqProjection;
    function QTD_VOL: TLinqProjection;
    function PRECO_VOL: TLinqProjection;
    function INATIVO: TLinqProjection;
    function CONTROLA_ESTOQUE: TLinqProjection;
    function DESCRICAO_PROMOCAO: TLinqProjection;
    function PRED_BCST: TLinqProjection;
    function CREDITO_IN: TLinqProjection;
    function CREDITO_OUT: TLinqProjection;
    function MVA_IN: TLinqProjection;
    function MVA_OUT: TLinqProjection;
    function ALI_IPI: TLinqProjection;
    function CSTIPI: TLinqProjection;
    function STATUS: TLinqProjection;
    function VAL_INFO: TLinqProjection;
    function CFOP_IN: TLinqProjection;
    function CFOP_OUT: TLinqProjection;
    function MARKUP_VAREJO: TLinqProjection;
    function VENDA_MARKUP_VAREJO: TLinqProjection;
    function STATUS_INV: TLinqProjection;
    function LOCALIZACAO: TLinqProjection;
    function BAL_VALIDADE: TLinqProjection;
    function CRTL_SERIE: TLinqProjection;
    function COD_RECEITA_PIS: TLinqProjection;
    function CSTPC_ENTRADA: TLinqProjection;
    function ALI_PIS_CREDITO: TLinqProjection;
    function ALI_PIS_DEBITO: TLinqProjection;
    function ALI_COFINS_CREDITO: TLinqProjection;
    function ALI_COFINS_DEBITO: TLinqProjection;
    function VASILHAME: TLinqProjection;
    function DATA_INV: TLinqProjection;
    function FAMILIA: TLinqProjection;
    function PERC_IBPT: TLinqProjection;
    function REFERENCIA: TLinqProjection;
    function PRFUTURO: TLinqProjection;
    function COMPRA: TLinqProjection;
    function MARKUP: TLinqProjection;
    function COTACAO: TLinqProjection;
    function ST_OUT: TLinqProjection;
    function TIPO_VENDA_VOLUME: TLinqProjection;
    function CEST: TLinqProjection;
    function COR: TLinqProjection;
    function TAMANHO: TLinqProjection;
    function PERC_AVISTA: TLinqProjection;
    function FUNDO_CP: TLinqProjection;
    function ICMS_SUB: TLinqProjection;
    function ALIQUOTA_ICMS_SUB: TLinqProjection;
    function VENDA_EMBALAGEM: TLinqProjection;
  end;
  
  TPRODUTOXCOMPOSTODictionary = class(TAureliusEntityDictionary, IPRODUTOXCOMPOSTODictionary)
  public
    function COD_PROD: TLinqProjection;
    function BARRA: TLinqProjection;
    function PRECO: TLinqProjection;
    function QTD: TLinqProjection;
  end;
  
  TRECEBIMENTODictionary = class(TAureliusEntityDictionary, IRECEBIMENTODictionary)
  public
    function EMPRESA: TLinqProjection;
    function CAIXA: TLinqProjection;
    function DOCUMENTO: TLinqProjection;
    function DATA: TLinqProjection;
    function COD_FINALIZADORA: TLinqProjection;
    function COD_COLABORADOR: TLinqProjection;
    function NTEF: TLinqProjection;
    function VALOR: TLinqProjection;
    function SEQ: TLinqProjection;
    function FINALIZADORA: TLinqProjection;
    function TROCO: TLinqProjection;
    function COD_TIPO_MOVIMENTO: TLinqProjection;
    function ORCAMENTO: TLinqProjection;
    function TEF: TLinqProjection;
    function STATUS: TLinqProjection;
    function CFOP: TLinqProjection;
    function CONTA_BANCARIA: TLinqProjection;
    function PROCESSADO: TLinqProjection;
    function CARTAO: TLinqProjection;
    function PROCESSADO_POR: TLinqProjection;
    function PROCESSADO_EM: TLinqProjection;
    function IMPRESSO: TLinqProjection;
    function HORA: TLinqProjection;
    function NSU: TLinqProjection;
    function COD_CLIENTE: TLinqProjection;
    function REDE: TLinqProjection;
    function DATA_TEF: TLinqProjection;
    function HORA_TEF: TLinqProjection;
    function COOCCD: TLinqProjection;
    function PRODUTO: TLinqProjection;
    function LOGICO: TLinqProjection;
    function NRPARCELAS: TLinqProjection;
    function VALE_TROCO: TLinqProjection;
    function ORIGEM: TLinqProjection;
    function AUTORIZACAO: TLinqProjection;
    function DESC_IMP_REC: TLinqProjection;
    function MSG: TLinqProjection;
    function DOC_ORIGINAL: TLinqProjection;
    function CREDDEB: TLinqProjection;
    function BANDEIRA: TLinqProjection;
    function INTPOS: TLinqProjection;
    function ANALITICO: TLinqProjection;
    function SINTETICO: TLinqProjection;
    function VIA01: TLinqProjection;
    function VIA02: TLinqProjection;
    function CNPJ_CREDENCIADA: TLinqProjection;
  end;
  
  TSANGRIADictionary = class(TAureliusEntityDictionary, ISANGRIADictionary)
  public
    function EMPRESA: TLinqProjection;
    function COD_SANGRIA: TLinqProjection;
    function CAIXA: TLinqProjection;
    function VALOR: TLinqProjection;
    function DATA: TLinqProjection;
    function COD_COLABORADOR: TLinqProjection;
    function NRDOCECF: TLinqProjection;
    function TIPO: TLinqProjection;
    function NRFAB: TLinqProjection;
    function HORA: TLinqProjection;
    function COD_GERENTE: TLinqProjection;
    function MD5: TLinqProjection;
  end;
  
  TSRIBANKDictionary = class(TAureliusEntityDictionary, ISRIBANKDictionary)
  public
    function CNPJ: TLinqProjection;
    function ID_ACCOUNT: TLinqProjection;
    function ALIAS: TLinqProjection;
    function ACCESS_TOKEN: TLinqProjection;
  end;
  
  TTPR04Dictionary = class(TAureliusEntityDictionary, ITPR04Dictionary)
  public
    function EMPRESA: TLinqProjection;
    function SEQ: TLinqProjection;
    function NRFABRICACAO: TLinqProjection;
    function NUMCCF: TLinqProjection;
    function LMFA: TLinqProjection;
    function MODELOECF: TLinqProjection;
    function NRUSUARIO: TLinqProjection;
    function DOCUMENTO: TLinqProjection;
    function DATAEMISSAO: TLinqProjection;
    function SUBTOTAL: TLinqProjection;
    function DESCONTO: TLinqProjection;
    function TIPODESC: TLinqProjection;
    function ACRESCIMO: TLinqProjection;
    function TIPOACRE: TLinqProjection;
    function INDCANCELAMENTO: TLinqProjection;
    function CANCACRESC: TLinqProjection;
    function TOTALLIQUIDO: TLinqProjection;
    function INDREJEICAO: TLinqProjection;
    function ORDEMAPLIQDESCACRES: TLinqProjection;
    function NOMEADQUIRENTE: TLinqProjection;
    function CPFCNPJADQUIRENTE: TLinqProjection;
    function VL_PIS: TLinqProjection;
    function VL_COFINS: TLinqProjection;
    function TRANSMITIDO: TLinqProjection;
    function TIPO_DOC: TLinqProjection;
  end;
  
  TTPR05Dictionary = class(TAureliusEntityDictionary, ITPR05Dictionary)
  public
    function SEQ: TLinqProjection;
    function TIPO: TLinqProjection;
    function NRFABRICACAO: TLinqProjection;
    function LMFA: TLinqProjection;
    function MODELOECF: TLinqProjection;
    function NRUSUARIO: TLinqProjection;
    function DOCUMENTO: TLinqProjection;
    function NRITEM: TLinqProjection;
    function COD_PRODUTO: TLinqProjection;
    function DESCRICAO: TLinqProjection;
    function QUANTIDADE: TLinqProjection;
    function UNIDADE: TLinqProjection;
    function VALORUNITARIO: TLinqProjection;
    function DESCONTOITEM: TLinqProjection;
    function ACRESCIMOITEM: TLinqProjection;
    function TOTALLIQUIDO: TLinqProjection;
    function TOTALIZADORPARCIAL: TLinqProjection;
    function INDCANCELAMENTO: TLinqProjection;
    function QTDCANCELADA: TLinqProjection;
    function VALORCANCELADO: TLinqProjection;
    function CANCACRESITEM: TLinqProjection;
    function INDARREDTRUNC: TLinqProjection;
    function INDPROD: TLinqProjection;
    function CASASDECQTD: TLinqProjection;
    function CASADECVLR: TLinqProjection;
    function VL_PIS: TLinqProjection;
    function VL_COFINS: TLinqProjection;
    function CST_ICMS: TLinqProjection;
    function CFOP: TLinqProjection;
    function ALIQ_ICMS: TLinqProjection;
    function COD_ALIQ: TLinqProjection;
    function EMPRESA: TLinqProjection;
    function TRANSMITIDO: TLinqProjection;
    function DATA: TLinqProjection;
    function VAL_INFO: TLinqProjection;
    function COD_VENDEDOR: TLinqProjection;
    function NRCX: TLinqProjection;
  end;
  
  TVENDADictionary = class(TAureliusEntityDictionary, IVENDADictionary)
  public
    function EMPRESA: TLinqProjection;
    function COD_VENDA: TLinqProjection;
    function DATA: TLinqProjection;
    function DOCUMENTO: TLinqProjection;
    function CAIXA: TLinqProjection;
    function COD_COLABORADOR: TLinqProjection;
    function TIPO_MOVIMENTO: TLinqProjection;
    function RESPONSAVEL: TLinqProjection;
    function CFOP: TLinqProjection;
    function CANCELADO: TLinqProjection;
    function VALOR: TLinqProjection;
    function ICMS: TLinqProjection;
    function CREDITO: TLinqProjection;
    function FEDERAL: TLinqProjection;
    function FORMA_PAGAMENTO: TLinqProjection;
    function FATURADO: TLinqProjection;
    function DESCONTO: TLinqProjection;
    function TOTAL: TLinqProjection;
    function SELO: TLinqProjection;
    function TRANSPORTADORA: TLinqProjection;
    function BRUTO: TLinqProjection;
    function LIQUIDO: TLinqProjection;
    function COMISSAO: TLinqProjection;
    function FRETE: TLinqProjection;
    function PLACA: TLinqProjection;
    function QUANTIDADE: TLinqProjection;
    function ESPECIE: TLinqProjection;
    function COD_VENDEDOR: TLinqProjection;
    function HORA: TLinqProjection;
    function DATA_EMISSAO_NF: TLinqProjection;
    function BASE_CALC_ICMS: TLinqProjection;
    function ICMS_SUBST: TLinqProjection;
    function BASE_CALC_SUBST: TLinqProjection;
    function VALOR_FRETE: TLinqProjection;
    function SEGURO: TLinqProjection;
    function IPI: TLinqProjection;
    function DESPESAS: TLinqProjection;
    function TIPO_DOC: TLinqProjection;
    function NUMCCF: TLinqProjection;
    function CPFCNPJ: TLinqProjection;
    function ACRESCIMO: TLinqProjection;
    function NOME_CLI: TLinqProjection;
    function ENDERECO_CLI: TLinqProjection;
    function NFCE_CHAVE: TLinqProjection;
    function NFCE_STATUS: TLinqProjection;
    function NFCE_MOTIVO: TLinqProjection;
    function XML_NFCE_ENVIO: TLinqProjection;
    function NFCE_CHAVE_SUFIXO: TLinqProjection;
    function CAN_REJEICAO: TLinqProjection;
    function NUM_NFSE: TLinqProjection;
    function XML_NFSE: TLinqProjection;
    function PEDIDO: TLinqProjection;
  end;
  
  IDictionary = interface(IAureliusDictionary)
    function PRODUTO: IPRODUTODictionary;
    function PRODUTOXCOMPOSTO: IPRODUTOXCOMPOSTODictionary;
    function RECEBIMENTO: IRECEBIMENTODictionary;
    function SANGRIA: ISANGRIADictionary;
    function SRIBANK: ISRIBANKDictionary;
    function TPR04: ITPR04Dictionary;
    function TPR05: ITPR05Dictionary;
    function VENDA: IVENDADictionary;
  end;
  
  TDictionary = class(TAureliusDictionary, IDictionary)
  public
    function PRODUTO: IPRODUTODictionary;
    function PRODUTOXCOMPOSTO: IPRODUTOXCOMPOSTODictionary;
    function RECEBIMENTO: IRECEBIMENTODictionary;
    function SANGRIA: ISANGRIADictionary;
    function SRIBANK: ISRIBANKDictionary;
    function TPR04: ITPR04Dictionary;
    function TPR05: ITPR05Dictionary;
    function VENDA: IVENDADictionary;
  end;
  
function Dic: IDictionary;

implementation

var
  __Dic: IDictionary;

function Dic: IDictionary;
begin
  if __Dic = nil then __Dic := TDictionary.Create;
  result := __Dic;
end;

{ TPRODUTODictionary }

function TPRODUTODictionary.EMPRESA: TLinqProjection;
begin
  Result := Prop('EMPRESA');
end;

function TPRODUTODictionary.COD_INTERNO: TLinqProjection;
begin
  Result := Prop('COD_INTERNO');
end;

function TPRODUTODictionary.COD_PRODUTO: TLinqProjection;
begin
  Result := Prop('COD_PRODUTO');
end;

function TPRODUTODictionary.DESCRICAO: TLinqProjection;
begin
  Result := Prop('DESCRICAO');
end;

function TPRODUTODictionary.COD_GRUPO: TLinqProjection;
begin
  Result := Prop('COD_GRUPO');
end;

function TPRODUTODictionary.COD_SUBGRUPO: TLinqProjection;
begin
  Result := Prop('COD_SUBGRUPO');
end;

function TPRODUTODictionary.COD_LINHA: TLinqProjection;
begin
  Result := Prop('COD_LINHA');
end;

function TPRODUTODictionary.BRUTO: TLinqProjection;
begin
  Result := Prop('BRUTO');
end;

function TPRODUTODictionary.LIQUIDO: TLinqProjection;
begin
  Result := Prop('LIQUIDO');
end;

function TPRODUTODictionary.ESTOQUE: TLinqProjection;
begin
  Result := Prop('ESTOQUE');
end;

function TPRODUTODictionary.CUSTO: TLinqProjection;
begin
  Result := Prop('CUSTO');
end;

function TPRODUTODictionary.ICMS_IN: TLinqProjection;
begin
  Result := Prop('ICMS_IN');
end;

function TPRODUTODictionary.ST: TLinqProjection;
begin
  Result := Prop('ST');
end;

function TPRODUTODictionary.UNIDADE: TLinqProjection;
begin
  Result := Prop('UNIDADE');
end;

function TPRODUTODictionary.MINIMO: TLinqProjection;
begin
  Result := Prop('MINIMO');
end;

function TPRODUTODictionary.ALIQUOTA: TLinqProjection;
begin
  Result := Prop('ALIQUOTA');
end;

function TPRODUTODictionary.TIPO: TLinqProjection;
begin
  Result := Prop('TIPO');
end;

function TPRODUTODictionary.ICMS_OUT: TLinqProjection;
begin
  Result := Prop('ICMS_OUT');
end;

function TPRODUTODictionary.COFINS: TLinqProjection;
begin
  Result := Prop('COFINS');
end;

function TPRODUTODictionary.FEDERAL: TLinqProjection;
begin
  Result := Prop('FEDERAL');
end;

function TPRODUTODictionary.VENDA_MARKUP: TLinqProjection;
begin
  Result := Prop('VENDA_MARKUP');
end;

function TPRODUTODictionary.COMISSAO: TLinqProjection;
begin
  Result := Prop('COMISSAO');
end;

function TPRODUTODictionary.GONDOLA: TLinqProjection;
begin
  Result := Prop('GONDOLA');
end;

function TPRODUTODictionary.RESERVADO: TLinqProjection;
begin
  Result := Prop('RESERVADO');
end;

function TPRODUTODictionary.ULT_COMPRA: TLinqProjection;
begin
  Result := Prop('ULT_COMPRA');
end;

function TPRODUTODictionary.TIPO_VENDA: TLinqProjection;
begin
  Result := Prop('TIPO_VENDA');
end;

function TPRODUTODictionary.MAXIMO: TLinqProjection;
begin
  Result := Prop('MAXIMO');
end;

function TPRODUTODictionary.COD_FABRICANTE: TLinqProjection;
begin
  Result := Prop('COD_FABRICANTE');
end;

function TPRODUTODictionary.MULCOMISSAO: TLinqProjection;
begin
  Result := Prop('MULCOMISSAO');
end;

function TPRODUTODictionary.ATACADO: TLinqProjection;
begin
  Result := Prop('ATACADO');
end;

function TPRODUTODictionary.ATACADO1: TLinqProjection;
begin
  Result := Prop('ATACADO1');
end;

function TPRODUTODictionary.ATACADO2: TLinqProjection;
begin
  Result := Prop('ATACADO2');
end;

function TPRODUTODictionary.VENDA: TLinqProjection;
begin
  Result := Prop('VENDA');
end;

function TPRODUTODictionary.DATA_ULTCOMPRA: TLinqProjection;
begin
  Result := Prop('DATA_ULTCOMPRA');
end;

function TPRODUTODictionary.DATA_CADASTRO: TLinqProjection;
begin
  Result := Prop('DATA_CADASTRO');
end;

function TPRODUTODictionary.COD_COLABORADORCADASTRO: TLinqProjection;
begin
  Result := Prop('COD_COLABORADORCADASTRO');
end;

function TPRODUTODictionary.DATA_ALTERACAO: TLinqProjection;
begin
  Result := Prop('DATA_ALTERACAO');
end;

function TPRODUTODictionary.COD_COLABORADORALTERACAO: TLinqProjection;
begin
  Result := Prop('COD_COLABORADORALTERACAO');
end;

function TPRODUTODictionary.QTD_EMBALAGEM: TLinqProjection;
begin
  Result := Prop('QTD_EMBALAGEM');
end;

function TPRODUTODictionary.PRECO_EMBALAGEM: TLinqProjection;
begin
  Result := Prop('PRECO_EMBALAGEM');
end;

function TPRODUTODictionary.PAUTA: TLinqProjection;
begin
  Result := Prop('PAUTA');
end;

function TPRODUTODictionary.DESC_ATACADO: TLinqProjection;
begin
  Result := Prop('DESC_ATACADO');
end;

function TPRODUTODictionary.QTD_ULT_COMPRA: TLinqProjection;
begin
  Result := Prop('QTD_ULT_COMPRA');
end;

function TPRODUTODictionary.DATA_ULT_COMPRA: TLinqProjection;
begin
  Result := Prop('DATA_ULT_COMPRA');
end;

function TPRODUTODictionary.PRECO_ULT_COMPRA: TLinqProjection;
begin
  Result := Prop('PRECO_ULT_COMPRA');
end;

function TPRODUTODictionary.UND_EMBALAGEM: TLinqProjection;
begin
  Result := Prop('UND_EMBALAGEM');
end;

function TPRODUTODictionary.QTD_ANTES_ULT_COMPRA: TLinqProjection;
begin
  Result := Prop('QTD_ANTES_ULT_COMPRA');
end;

function TPRODUTODictionary.ST_PROMOCAO: TLinqProjection;
begin
  Result := Prop('ST_PROMOCAO');
end;

function TPRODUTODictionary.DATA_INICIO_PROM: TLinqProjection;
begin
  Result := Prop('DATA_INICIO_PROM');
end;

function TPRODUTODictionary.DATA_FINAL_PROM: TLinqProjection;
begin
  Result := Prop('DATA_FINAL_PROM');
end;

function TPRODUTODictionary.PRECO_PROM: TLinqProjection;
begin
  Result := Prop('PRECO_PROM');
end;

function TPRODUTODictionary.DATA_ULT_VENDA: TLinqProjection;
begin
  Result := Prop('DATA_ULT_VENDA');
end;

function TPRODUTODictionary.COD_BARRA_EMBALAGEM: TLinqProjection;
begin
  Result := Prop('COD_BARRA_EMBALAGEM');
end;

function TPRODUTODictionary.BALANCA: TLinqProjection;
begin
  Result := Prop('BALANCA');
end;

function TPRODUTODictionary.COD_NCM: TLinqProjection;
begin
  Result := Prop('COD_NCM');
end;

function TPRODUTODictionary.EX_IPI: TLinqProjection;
begin
  Result := Prop('EX_IPI');
end;

function TPRODUTODictionary.COD_GEN: TLinqProjection;
begin
  Result := Prop('COD_GEN');
end;

function TPRODUTODictionary.COD_LST: TLinqProjection;
begin
  Result := Prop('COD_LST');
end;

function TPRODUTODictionary.INDARRTRUN: TLinqProjection;
begin
  Result := Prop('INDARRTRUN');
end;

function TPRODUTODictionary.CSTPC: TLinqProjection;
begin
  Result := Prop('CSTPC');
end;

function TPRODUTODictionary.MOD_BCICMS: TLinqProjection;
begin
  Result := Prop('MOD_BCICMS');
end;

function TPRODUTODictionary.MOD_BCICMSST: TLinqProjection;
begin
  Result := Prop('MOD_BCICMSST');
end;

function TPRODUTODictionary.ALI_ICMSST: TLinqProjection;
begin
  Result := Prop('ALI_ICMSST');
end;

function TPRODUTODictionary.FABRICACAO: TLinqProjection;
begin
  Result := Prop('FABRICACAO');
end;

function TPRODUTODictionary.QTD_VOL: TLinqProjection;
begin
  Result := Prop('QTD_VOL');
end;

function TPRODUTODictionary.PRECO_VOL: TLinqProjection;
begin
  Result := Prop('PRECO_VOL');
end;

function TPRODUTODictionary.INATIVO: TLinqProjection;
begin
  Result := Prop('INATIVO');
end;

function TPRODUTODictionary.CONTROLA_ESTOQUE: TLinqProjection;
begin
  Result := Prop('CONTROLA_ESTOQUE');
end;

function TPRODUTODictionary.DESCRICAO_PROMOCAO: TLinqProjection;
begin
  Result := Prop('DESCRICAO_PROMOCAO');
end;

function TPRODUTODictionary.PRED_BCST: TLinqProjection;
begin
  Result := Prop('PRED_BCST');
end;

function TPRODUTODictionary.CREDITO_IN: TLinqProjection;
begin
  Result := Prop('CREDITO_IN');
end;

function TPRODUTODictionary.CREDITO_OUT: TLinqProjection;
begin
  Result := Prop('CREDITO_OUT');
end;

function TPRODUTODictionary.MVA_IN: TLinqProjection;
begin
  Result := Prop('MVA_IN');
end;

function TPRODUTODictionary.MVA_OUT: TLinqProjection;
begin
  Result := Prop('MVA_OUT');
end;

function TPRODUTODictionary.ALI_IPI: TLinqProjection;
begin
  Result := Prop('ALI_IPI');
end;

function TPRODUTODictionary.CSTIPI: TLinqProjection;
begin
  Result := Prop('CSTIPI');
end;

function TPRODUTODictionary.STATUS: TLinqProjection;
begin
  Result := Prop('STATUS');
end;

function TPRODUTODictionary.VAL_INFO: TLinqProjection;
begin
  Result := Prop('VAL_INFO');
end;

function TPRODUTODictionary.CFOP_IN: TLinqProjection;
begin
  Result := Prop('CFOP_IN');
end;

function TPRODUTODictionary.CFOP_OUT: TLinqProjection;
begin
  Result := Prop('CFOP_OUT');
end;

function TPRODUTODictionary.MARKUP_VAREJO: TLinqProjection;
begin
  Result := Prop('MARKUP_VAREJO');
end;

function TPRODUTODictionary.VENDA_MARKUP_VAREJO: TLinqProjection;
begin
  Result := Prop('VENDA_MARKUP_VAREJO');
end;

function TPRODUTODictionary.STATUS_INV: TLinqProjection;
begin
  Result := Prop('STATUS_INV');
end;

function TPRODUTODictionary.LOCALIZACAO: TLinqProjection;
begin
  Result := Prop('LOCALIZACAO');
end;

function TPRODUTODictionary.BAL_VALIDADE: TLinqProjection;
begin
  Result := Prop('BAL_VALIDADE');
end;

function TPRODUTODictionary.CRTL_SERIE: TLinqProjection;
begin
  Result := Prop('CRTL_SERIE');
end;

function TPRODUTODictionary.COD_RECEITA_PIS: TLinqProjection;
begin
  Result := Prop('COD_RECEITA_PIS');
end;

function TPRODUTODictionary.CSTPC_ENTRADA: TLinqProjection;
begin
  Result := Prop('CSTPC_ENTRADA');
end;

function TPRODUTODictionary.ALI_PIS_CREDITO: TLinqProjection;
begin
  Result := Prop('ALI_PIS_CREDITO');
end;

function TPRODUTODictionary.ALI_PIS_DEBITO: TLinqProjection;
begin
  Result := Prop('ALI_PIS_DEBITO');
end;

function TPRODUTODictionary.ALI_COFINS_CREDITO: TLinqProjection;
begin
  Result := Prop('ALI_COFINS_CREDITO');
end;

function TPRODUTODictionary.ALI_COFINS_DEBITO: TLinqProjection;
begin
  Result := Prop('ALI_COFINS_DEBITO');
end;

function TPRODUTODictionary.VASILHAME: TLinqProjection;
begin
  Result := Prop('VASILHAME');
end;

function TPRODUTODictionary.DATA_INV: TLinqProjection;
begin
  Result := Prop('DATA_INV');
end;

function TPRODUTODictionary.FAMILIA: TLinqProjection;
begin
  Result := Prop('FAMILIA');
end;

function TPRODUTODictionary.PERC_IBPT: TLinqProjection;
begin
  Result := Prop('PERC_IBPT');
end;

function TPRODUTODictionary.REFERENCIA: TLinqProjection;
begin
  Result := Prop('REFERENCIA');
end;

function TPRODUTODictionary.PRFUTURO: TLinqProjection;
begin
  Result := Prop('PRFUTURO');
end;

function TPRODUTODictionary.COMPRA: TLinqProjection;
begin
  Result := Prop('COMPRA');
end;

function TPRODUTODictionary.MARKUP: TLinqProjection;
begin
  Result := Prop('MARKUP');
end;

function TPRODUTODictionary.COTACAO: TLinqProjection;
begin
  Result := Prop('COTACAO');
end;

function TPRODUTODictionary.ST_OUT: TLinqProjection;
begin
  Result := Prop('ST_OUT');
end;

function TPRODUTODictionary.TIPO_VENDA_VOLUME: TLinqProjection;
begin
  Result := Prop('TIPO_VENDA_VOLUME');
end;

function TPRODUTODictionary.CEST: TLinqProjection;
begin
  Result := Prop('CEST');
end;

function TPRODUTODictionary.COR: TLinqProjection;
begin
  Result := Prop('COR');
end;

function TPRODUTODictionary.TAMANHO: TLinqProjection;
begin
  Result := Prop('TAMANHO');
end;

function TPRODUTODictionary.PERC_AVISTA: TLinqProjection;
begin
  Result := Prop('PERC_AVISTA');
end;

function TPRODUTODictionary.FUNDO_CP: TLinqProjection;
begin
  Result := Prop('FUNDO_CP');
end;

function TPRODUTODictionary.ICMS_SUB: TLinqProjection;
begin
  Result := Prop('ICMS_SUB');
end;

function TPRODUTODictionary.ALIQUOTA_ICMS_SUB: TLinqProjection;
begin
  Result := Prop('ALIQUOTA_ICMS_SUB');
end;

function TPRODUTODictionary.VENDA_EMBALAGEM: TLinqProjection;
begin
  Result := Prop('VENDA_EMBALAGEM');
end;

{ TPRODUTOXCOMPOSTODictionary }

function TPRODUTOXCOMPOSTODictionary.COD_PROD: TLinqProjection;
begin
  Result := Prop('COD_PROD');
end;

function TPRODUTOXCOMPOSTODictionary.BARRA: TLinqProjection;
begin
  Result := Prop('BARRA');
end;

function TPRODUTOXCOMPOSTODictionary.PRECO: TLinqProjection;
begin
  Result := Prop('PRECO');
end;

function TPRODUTOXCOMPOSTODictionary.QTD: TLinqProjection;
begin
  Result := Prop('QTD');
end;

{ TRECEBIMENTODictionary }

function TRECEBIMENTODictionary.EMPRESA: TLinqProjection;
begin
  Result := Prop('EMPRESA');
end;

function TRECEBIMENTODictionary.CAIXA: TLinqProjection;
begin
  Result := Prop('CAIXA');
end;

function TRECEBIMENTODictionary.DOCUMENTO: TLinqProjection;
begin
  Result := Prop('DOCUMENTO');
end;

function TRECEBIMENTODictionary.DATA: TLinqProjection;
begin
  Result := Prop('DATA');
end;

function TRECEBIMENTODictionary.COD_FINALIZADORA: TLinqProjection;
begin
  Result := Prop('COD_FINALIZADORA');
end;

function TRECEBIMENTODictionary.COD_COLABORADOR: TLinqProjection;
begin
  Result := Prop('COD_COLABORADOR');
end;

function TRECEBIMENTODictionary.NTEF: TLinqProjection;
begin
  Result := Prop('NTEF');
end;

function TRECEBIMENTODictionary.VALOR: TLinqProjection;
begin
  Result := Prop('VALOR');
end;

function TRECEBIMENTODictionary.SEQ: TLinqProjection;
begin
  Result := Prop('SEQ');
end;

function TRECEBIMENTODictionary.FINALIZADORA: TLinqProjection;
begin
  Result := Prop('FINALIZADORA');
end;

function TRECEBIMENTODictionary.TROCO: TLinqProjection;
begin
  Result := Prop('TROCO');
end;

function TRECEBIMENTODictionary.COD_TIPO_MOVIMENTO: TLinqProjection;
begin
  Result := Prop('COD_TIPO_MOVIMENTO');
end;

function TRECEBIMENTODictionary.ORCAMENTO: TLinqProjection;
begin
  Result := Prop('ORCAMENTO');
end;

function TRECEBIMENTODictionary.TEF: TLinqProjection;
begin
  Result := Prop('TEF');
end;

function TRECEBIMENTODictionary.STATUS: TLinqProjection;
begin
  Result := Prop('STATUS');
end;

function TRECEBIMENTODictionary.CFOP: TLinqProjection;
begin
  Result := Prop('CFOP');
end;

function TRECEBIMENTODictionary.CONTA_BANCARIA: TLinqProjection;
begin
  Result := Prop('CONTA_BANCARIA');
end;

function TRECEBIMENTODictionary.PROCESSADO: TLinqProjection;
begin
  Result := Prop('PROCESSADO');
end;

function TRECEBIMENTODictionary.CARTAO: TLinqProjection;
begin
  Result := Prop('CARTAO');
end;

function TRECEBIMENTODictionary.PROCESSADO_POR: TLinqProjection;
begin
  Result := Prop('PROCESSADO_POR');
end;

function TRECEBIMENTODictionary.PROCESSADO_EM: TLinqProjection;
begin
  Result := Prop('PROCESSADO_EM');
end;

function TRECEBIMENTODictionary.IMPRESSO: TLinqProjection;
begin
  Result := Prop('IMPRESSO');
end;

function TRECEBIMENTODictionary.HORA: TLinqProjection;
begin
  Result := Prop('HORA');
end;

function TRECEBIMENTODictionary.NSU: TLinqProjection;
begin
  Result := Prop('NSU');
end;

function TRECEBIMENTODictionary.COD_CLIENTE: TLinqProjection;
begin
  Result := Prop('COD_CLIENTE');
end;

function TRECEBIMENTODictionary.REDE: TLinqProjection;
begin
  Result := Prop('REDE');
end;

function TRECEBIMENTODictionary.DATA_TEF: TLinqProjection;
begin
  Result := Prop('DATA_TEF');
end;

function TRECEBIMENTODictionary.HORA_TEF: TLinqProjection;
begin
  Result := Prop('HORA_TEF');
end;

function TRECEBIMENTODictionary.COOCCD: TLinqProjection;
begin
  Result := Prop('COOCCD');
end;

function TRECEBIMENTODictionary.PRODUTO: TLinqProjection;
begin
  Result := Prop('PRODUTO');
end;

function TRECEBIMENTODictionary.LOGICO: TLinqProjection;
begin
  Result := Prop('LOGICO');
end;

function TRECEBIMENTODictionary.NRPARCELAS: TLinqProjection;
begin
  Result := Prop('NRPARCELAS');
end;

function TRECEBIMENTODictionary.VALE_TROCO: TLinqProjection;
begin
  Result := Prop('VALE_TROCO');
end;

function TRECEBIMENTODictionary.ORIGEM: TLinqProjection;
begin
  Result := Prop('ORIGEM');
end;

function TRECEBIMENTODictionary.AUTORIZACAO: TLinqProjection;
begin
  Result := Prop('AUTORIZACAO');
end;

function TRECEBIMENTODictionary.DESC_IMP_REC: TLinqProjection;
begin
  Result := Prop('DESC_IMP_REC');
end;

function TRECEBIMENTODictionary.MSG: TLinqProjection;
begin
  Result := Prop('MSG');
end;

function TRECEBIMENTODictionary.DOC_ORIGINAL: TLinqProjection;
begin
  Result := Prop('DOC_ORIGINAL');
end;

function TRECEBIMENTODictionary.CREDDEB: TLinqProjection;
begin
  Result := Prop('CREDDEB');
end;

function TRECEBIMENTODictionary.BANDEIRA: TLinqProjection;
begin
  Result := Prop('BANDEIRA');
end;

function TRECEBIMENTODictionary.INTPOS: TLinqProjection;
begin
  Result := Prop('INTPOS');
end;

function TRECEBIMENTODictionary.ANALITICO: TLinqProjection;
begin
  Result := Prop('ANALITICO');
end;

function TRECEBIMENTODictionary.SINTETICO: TLinqProjection;
begin
  Result := Prop('SINTETICO');
end;

function TRECEBIMENTODictionary.VIA01: TLinqProjection;
begin
  Result := Prop('VIA01');
end;

function TRECEBIMENTODictionary.VIA02: TLinqProjection;
begin
  Result := Prop('VIA02');
end;

function TRECEBIMENTODictionary.CNPJ_CREDENCIADA: TLinqProjection;
begin
  Result := Prop('CNPJ_CREDENCIADA');
end;

{ TSANGRIADictionary }

function TSANGRIADictionary.EMPRESA: TLinqProjection;
begin
  Result := Prop('EMPRESA');
end;

function TSANGRIADictionary.COD_SANGRIA: TLinqProjection;
begin
  Result := Prop('COD_SANGRIA');
end;

function TSANGRIADictionary.CAIXA: TLinqProjection;
begin
  Result := Prop('CAIXA');
end;

function TSANGRIADictionary.VALOR: TLinqProjection;
begin
  Result := Prop('VALOR');
end;

function TSANGRIADictionary.DATA: TLinqProjection;
begin
  Result := Prop('DATA');
end;

function TSANGRIADictionary.COD_COLABORADOR: TLinqProjection;
begin
  Result := Prop('COD_COLABORADOR');
end;

function TSANGRIADictionary.NRDOCECF: TLinqProjection;
begin
  Result := Prop('NRDOCECF');
end;

function TSANGRIADictionary.TIPO: TLinqProjection;
begin
  Result := Prop('TIPO');
end;

function TSANGRIADictionary.NRFAB: TLinqProjection;
begin
  Result := Prop('NRFAB');
end;

function TSANGRIADictionary.HORA: TLinqProjection;
begin
  Result := Prop('HORA');
end;

function TSANGRIADictionary.COD_GERENTE: TLinqProjection;
begin
  Result := Prop('COD_GERENTE');
end;

function TSANGRIADictionary.MD5: TLinqProjection;
begin
  Result := Prop('MD5');
end;

{ TSRIBANKDictionary }

function TSRIBANKDictionary.CNPJ: TLinqProjection;
begin
  Result := Prop('CNPJ');
end;

function TSRIBANKDictionary.ID_ACCOUNT: TLinqProjection;
begin
  Result := Prop('ID_ACCOUNT');
end;

function TSRIBANKDictionary.ALIAS: TLinqProjection;
begin
  Result := Prop('ALIAS');
end;

function TSRIBANKDictionary.ACCESS_TOKEN: TLinqProjection;
begin
  Result := Prop('ACCESS_TOKEN');
end;

{ TTPR04Dictionary }

function TTPR04Dictionary.EMPRESA: TLinqProjection;
begin
  Result := Prop('EMPRESA');
end;

function TTPR04Dictionary.SEQ: TLinqProjection;
begin
  Result := Prop('SEQ');
end;

function TTPR04Dictionary.NRFABRICACAO: TLinqProjection;
begin
  Result := Prop('NRFABRICACAO');
end;

function TTPR04Dictionary.NUMCCF: TLinqProjection;
begin
  Result := Prop('NUMCCF');
end;

function TTPR04Dictionary.LMFA: TLinqProjection;
begin
  Result := Prop('LMFA');
end;

function TTPR04Dictionary.MODELOECF: TLinqProjection;
begin
  Result := Prop('MODELOECF');
end;

function TTPR04Dictionary.NRUSUARIO: TLinqProjection;
begin
  Result := Prop('NRUSUARIO');
end;

function TTPR04Dictionary.DOCUMENTO: TLinqProjection;
begin
  Result := Prop('DOCUMENTO');
end;

function TTPR04Dictionary.DATAEMISSAO: TLinqProjection;
begin
  Result := Prop('DATAEMISSAO');
end;

function TTPR04Dictionary.SUBTOTAL: TLinqProjection;
begin
  Result := Prop('SUBTOTAL');
end;

function TTPR04Dictionary.DESCONTO: TLinqProjection;
begin
  Result := Prop('DESCONTO');
end;

function TTPR04Dictionary.TIPODESC: TLinqProjection;
begin
  Result := Prop('TIPODESC');
end;

function TTPR04Dictionary.ACRESCIMO: TLinqProjection;
begin
  Result := Prop('ACRESCIMO');
end;

function TTPR04Dictionary.TIPOACRE: TLinqProjection;
begin
  Result := Prop('TIPOACRE');
end;

function TTPR04Dictionary.INDCANCELAMENTO: TLinqProjection;
begin
  Result := Prop('INDCANCELAMENTO');
end;

function TTPR04Dictionary.CANCACRESC: TLinqProjection;
begin
  Result := Prop('CANCACRESC');
end;

function TTPR04Dictionary.TOTALLIQUIDO: TLinqProjection;
begin
  Result := Prop('TOTALLIQUIDO');
end;

function TTPR04Dictionary.INDREJEICAO: TLinqProjection;
begin
  Result := Prop('INDREJEICAO');
end;

function TTPR04Dictionary.ORDEMAPLIQDESCACRES: TLinqProjection;
begin
  Result := Prop('ORDEMAPLIQDESCACRES');
end;

function TTPR04Dictionary.NOMEADQUIRENTE: TLinqProjection;
begin
  Result := Prop('NOMEADQUIRENTE');
end;

function TTPR04Dictionary.CPFCNPJADQUIRENTE: TLinqProjection;
begin
  Result := Prop('CPFCNPJADQUIRENTE');
end;

function TTPR04Dictionary.VL_PIS: TLinqProjection;
begin
  Result := Prop('VL_PIS');
end;

function TTPR04Dictionary.VL_COFINS: TLinqProjection;
begin
  Result := Prop('VL_COFINS');
end;

function TTPR04Dictionary.TRANSMITIDO: TLinqProjection;
begin
  Result := Prop('TRANSMITIDO');
end;

function TTPR04Dictionary.TIPO_DOC: TLinqProjection;
begin
  Result := Prop('TIPO_DOC');
end;

{ TTPR05Dictionary }

function TTPR05Dictionary.SEQ: TLinqProjection;
begin
  Result := Prop('SEQ');
end;

function TTPR05Dictionary.TIPO: TLinqProjection;
begin
  Result := Prop('TIPO');
end;

function TTPR05Dictionary.NRFABRICACAO: TLinqProjection;
begin
  Result := Prop('NRFABRICACAO');
end;

function TTPR05Dictionary.LMFA: TLinqProjection;
begin
  Result := Prop('LMFA');
end;

function TTPR05Dictionary.MODELOECF: TLinqProjection;
begin
  Result := Prop('MODELOECF');
end;

function TTPR05Dictionary.NRUSUARIO: TLinqProjection;
begin
  Result := Prop('NRUSUARIO');
end;

function TTPR05Dictionary.DOCUMENTO: TLinqProjection;
begin
  Result := Prop('DOCUMENTO');
end;

function TTPR05Dictionary.NRITEM: TLinqProjection;
begin
  Result := Prop('NRITEM');
end;

function TTPR05Dictionary.COD_PRODUTO: TLinqProjection;
begin
  Result := Prop('COD_PRODUTO');
end;

function TTPR05Dictionary.DESCRICAO: TLinqProjection;
begin
  Result := Prop('DESCRICAO');
end;

function TTPR05Dictionary.QUANTIDADE: TLinqProjection;
begin
  Result := Prop('QUANTIDADE');
end;

function TTPR05Dictionary.UNIDADE: TLinqProjection;
begin
  Result := Prop('UNIDADE');
end;

function TTPR05Dictionary.VALORUNITARIO: TLinqProjection;
begin
  Result := Prop('VALORUNITARIO');
end;

function TTPR05Dictionary.DESCONTOITEM: TLinqProjection;
begin
  Result := Prop('DESCONTOITEM');
end;

function TTPR05Dictionary.ACRESCIMOITEM: TLinqProjection;
begin
  Result := Prop('ACRESCIMOITEM');
end;

function TTPR05Dictionary.TOTALLIQUIDO: TLinqProjection;
begin
  Result := Prop('TOTALLIQUIDO');
end;

function TTPR05Dictionary.TOTALIZADORPARCIAL: TLinqProjection;
begin
  Result := Prop('TOTALIZADORPARCIAL');
end;

function TTPR05Dictionary.INDCANCELAMENTO: TLinqProjection;
begin
  Result := Prop('INDCANCELAMENTO');
end;

function TTPR05Dictionary.QTDCANCELADA: TLinqProjection;
begin
  Result := Prop('QTDCANCELADA');
end;

function TTPR05Dictionary.VALORCANCELADO: TLinqProjection;
begin
  Result := Prop('VALORCANCELADO');
end;

function TTPR05Dictionary.CANCACRESITEM: TLinqProjection;
begin
  Result := Prop('CANCACRESITEM');
end;

function TTPR05Dictionary.INDARREDTRUNC: TLinqProjection;
begin
  Result := Prop('INDARREDTRUNC');
end;

function TTPR05Dictionary.INDPROD: TLinqProjection;
begin
  Result := Prop('INDPROD');
end;

function TTPR05Dictionary.CASASDECQTD: TLinqProjection;
begin
  Result := Prop('CASASDECQTD');
end;

function TTPR05Dictionary.CASADECVLR: TLinqProjection;
begin
  Result := Prop('CASADECVLR');
end;

function TTPR05Dictionary.VL_PIS: TLinqProjection;
begin
  Result := Prop('VL_PIS');
end;

function TTPR05Dictionary.VL_COFINS: TLinqProjection;
begin
  Result := Prop('VL_COFINS');
end;

function TTPR05Dictionary.CST_ICMS: TLinqProjection;
begin
  Result := Prop('CST_ICMS');
end;

function TTPR05Dictionary.CFOP: TLinqProjection;
begin
  Result := Prop('CFOP');
end;

function TTPR05Dictionary.ALIQ_ICMS: TLinqProjection;
begin
  Result := Prop('ALIQ_ICMS');
end;

function TTPR05Dictionary.COD_ALIQ: TLinqProjection;
begin
  Result := Prop('COD_ALIQ');
end;

function TTPR05Dictionary.EMPRESA: TLinqProjection;
begin
  Result := Prop('EMPRESA');
end;

function TTPR05Dictionary.TRANSMITIDO: TLinqProjection;
begin
  Result := Prop('TRANSMITIDO');
end;

function TTPR05Dictionary.DATA: TLinqProjection;
begin
  Result := Prop('DATA');
end;

function TTPR05Dictionary.VAL_INFO: TLinqProjection;
begin
  Result := Prop('VAL_INFO');
end;

function TTPR05Dictionary.COD_VENDEDOR: TLinqProjection;
begin
  Result := Prop('COD_VENDEDOR');
end;

function TTPR05Dictionary.NRCX: TLinqProjection;
begin
  Result := Prop('NRCX');
end;

{ TVENDADictionary }

function TVENDADictionary.EMPRESA: TLinqProjection;
begin
  Result := Prop('EMPRESA');
end;

function TVENDADictionary.COD_VENDA: TLinqProjection;
begin
  Result := Prop('COD_VENDA');
end;

function TVENDADictionary.DATA: TLinqProjection;
begin
  Result := Prop('DATA');
end;

function TVENDADictionary.DOCUMENTO: TLinqProjection;
begin
  Result := Prop('DOCUMENTO');
end;

function TVENDADictionary.CAIXA: TLinqProjection;
begin
  Result := Prop('CAIXA');
end;

function TVENDADictionary.COD_COLABORADOR: TLinqProjection;
begin
  Result := Prop('COD_COLABORADOR');
end;

function TVENDADictionary.TIPO_MOVIMENTO: TLinqProjection;
begin
  Result := Prop('TIPO_MOVIMENTO');
end;

function TVENDADictionary.RESPONSAVEL: TLinqProjection;
begin
  Result := Prop('RESPONSAVEL');
end;

function TVENDADictionary.CFOP: TLinqProjection;
begin
  Result := Prop('CFOP');
end;

function TVENDADictionary.CANCELADO: TLinqProjection;
begin
  Result := Prop('CANCELADO');
end;

function TVENDADictionary.VALOR: TLinqProjection;
begin
  Result := Prop('VALOR');
end;

function TVENDADictionary.ICMS: TLinqProjection;
begin
  Result := Prop('ICMS');
end;

function TVENDADictionary.CREDITO: TLinqProjection;
begin
  Result := Prop('CREDITO');
end;

function TVENDADictionary.FEDERAL: TLinqProjection;
begin
  Result := Prop('FEDERAL');
end;

function TVENDADictionary.FORMA_PAGAMENTO: TLinqProjection;
begin
  Result := Prop('FORMA_PAGAMENTO');
end;

function TVENDADictionary.FATURADO: TLinqProjection;
begin
  Result := Prop('FATURADO');
end;

function TVENDADictionary.DESCONTO: TLinqProjection;
begin
  Result := Prop('DESCONTO');
end;

function TVENDADictionary.TOTAL: TLinqProjection;
begin
  Result := Prop('TOTAL');
end;

function TVENDADictionary.SELO: TLinqProjection;
begin
  Result := Prop('SELO');
end;

function TVENDADictionary.TRANSPORTADORA: TLinqProjection;
begin
  Result := Prop('TRANSPORTADORA');
end;

function TVENDADictionary.BRUTO: TLinqProjection;
begin
  Result := Prop('BRUTO');
end;

function TVENDADictionary.LIQUIDO: TLinqProjection;
begin
  Result := Prop('LIQUIDO');
end;

function TVENDADictionary.COMISSAO: TLinqProjection;
begin
  Result := Prop('COMISSAO');
end;

function TVENDADictionary.FRETE: TLinqProjection;
begin
  Result := Prop('FRETE');
end;

function TVENDADictionary.PLACA: TLinqProjection;
begin
  Result := Prop('PLACA');
end;

function TVENDADictionary.QUANTIDADE: TLinqProjection;
begin
  Result := Prop('QUANTIDADE');
end;

function TVENDADictionary.ESPECIE: TLinqProjection;
begin
  Result := Prop('ESPECIE');
end;

function TVENDADictionary.COD_VENDEDOR: TLinqProjection;
begin
  Result := Prop('COD_VENDEDOR');
end;

function TVENDADictionary.HORA: TLinqProjection;
begin
  Result := Prop('HORA');
end;

function TVENDADictionary.DATA_EMISSAO_NF: TLinqProjection;
begin
  Result := Prop('DATA_EMISSAO_NF');
end;

function TVENDADictionary.BASE_CALC_ICMS: TLinqProjection;
begin
  Result := Prop('BASE_CALC_ICMS');
end;

function TVENDADictionary.ICMS_SUBST: TLinqProjection;
begin
  Result := Prop('ICMS_SUBST');
end;

function TVENDADictionary.BASE_CALC_SUBST: TLinqProjection;
begin
  Result := Prop('BASE_CALC_SUBST');
end;

function TVENDADictionary.VALOR_FRETE: TLinqProjection;
begin
  Result := Prop('VALOR_FRETE');
end;

function TVENDADictionary.SEGURO: TLinqProjection;
begin
  Result := Prop('SEGURO');
end;

function TVENDADictionary.IPI: TLinqProjection;
begin
  Result := Prop('IPI');
end;

function TVENDADictionary.DESPESAS: TLinqProjection;
begin
  Result := Prop('DESPESAS');
end;

function TVENDADictionary.TIPO_DOC: TLinqProjection;
begin
  Result := Prop('TIPO_DOC');
end;

function TVENDADictionary.NUMCCF: TLinqProjection;
begin
  Result := Prop('NUMCCF');
end;

function TVENDADictionary.CPFCNPJ: TLinqProjection;
begin
  Result := Prop('CPFCNPJ');
end;

function TVENDADictionary.ACRESCIMO: TLinqProjection;
begin
  Result := Prop('ACRESCIMO');
end;

function TVENDADictionary.NOME_CLI: TLinqProjection;
begin
  Result := Prop('NOME_CLI');
end;

function TVENDADictionary.ENDERECO_CLI: TLinqProjection;
begin
  Result := Prop('ENDERECO_CLI');
end;

function TVENDADictionary.NFCE_CHAVE: TLinqProjection;
begin
  Result := Prop('NFCE_CHAVE');
end;

function TVENDADictionary.NFCE_STATUS: TLinqProjection;
begin
  Result := Prop('NFCE_STATUS');
end;

function TVENDADictionary.NFCE_MOTIVO: TLinqProjection;
begin
  Result := Prop('NFCE_MOTIVO');
end;

function TVENDADictionary.XML_NFCE_ENVIO: TLinqProjection;
begin
  Result := Prop('XML_NFCE_ENVIO');
end;

function TVENDADictionary.NFCE_CHAVE_SUFIXO: TLinqProjection;
begin
  Result := Prop('NFCE_CHAVE_SUFIXO');
end;

function TVENDADictionary.CAN_REJEICAO: TLinqProjection;
begin
  Result := Prop('CAN_REJEICAO');
end;

function TVENDADictionary.NUM_NFSE: TLinqProjection;
begin
  Result := Prop('NUM_NFSE');
end;

function TVENDADictionary.XML_NFSE: TLinqProjection;
begin
  Result := Prop('XML_NFSE');
end;

function TVENDADictionary.PEDIDO: TLinqProjection;
begin
  Result := Prop('PEDIDO');
end;

{ TDictionary }

function TDictionary.PRODUTO: IPRODUTODictionary;
begin
  Result := TPRODUTODictionary.Create;
end;

function TDictionary.PRODUTOXCOMPOSTO: IPRODUTOXCOMPOSTODictionary;
begin
  Result := TPRODUTOXCOMPOSTODictionary.Create;
end;

function TDictionary.RECEBIMENTO: IRECEBIMENTODictionary;
begin
  Result := TRECEBIMENTODictionary.Create;
end;

function TDictionary.SANGRIA: ISANGRIADictionary;
begin
  Result := TSANGRIADictionary.Create;
end;

function TDictionary.SRIBANK: ISRIBANKDictionary;
begin
  Result := TSRIBANKDictionary.Create;
end;

function TDictionary.TPR04: ITPR04Dictionary;
begin
  Result := TTPR04Dictionary.Create;
end;

function TDictionary.TPR05: ITPR05Dictionary;
begin
  Result := TTPR05Dictionary.Create;
end;

function TDictionary.VENDA: IVENDADictionary;
begin
  Result := TVENDADictionary.Create;
end;

initialization
  RegisterEntity(TPRODUTO);
  RegisterEntity(TPRODUTOXCOMPOSTO);
  RegisterEntity(TRECEBIMENTO);
  RegisterEntity(TSANGRIA);
  RegisterEntity(TSRIBANK);
  RegisterEntity(TTPR04);
  RegisterEntity(TTPR05);
  RegisterEntity(TVENDA);

end.
