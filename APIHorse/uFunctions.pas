unit uFunctions;

interface

uses
  Horse, System.SysUtils, System.Classes,
  System.Json, System.StrUtils, FireDAC.Comp.Client,
  FireDAC.Stan.Option;

    function connectDB(numDB: Integer = 1): TFDConnection;
     //v1
    procedure listTicket(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure startPIXTransaction(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure queryPIXTransaction(Req: THorseRequest; Res: THorseResponse; Next: TProc);

 type
   TParams = record
      cnpj               : string;
      document           : string;
      amount             : Real;
      total_amount       : Real;
      transaction_date   : TDateTime;
      expiration_date    : TDateTime;
      sender_comment     : string;
      recipient_comment  : string;
      origin_device      : string;
      public
        procedure addInterestFine(Interest, Fine: currency);
    end;

implementation

uses
   uClasses, uMain, uConstants, IdHTTP,
   System.DateUtils, SRIBANK.PARAMS;

procedure listTicket(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  dbConn      : TFDConnection;
  qry         : TFDQuery;
  I, iCOD     : Integer;
  erro, sCNPJ: string;
  Result     :  TJSONObject;
  jSONArray  : TJSONArray;
  JSONValue: TJSONValue;
begin
  try
    try
    sCNPJ:= Req.ContentFields['CNPJ'];
    except
      raise Exception.Create('Parametro CNPJ não informado');
    end;
    qry       := nil;
    erro      := EmptyStr;

    dbConn := connectDB();
    if (dbConn = nil) then
      raise Exception.Create('Nao foi possivel configurar o banco de dados');
    qry  := TFDQuery.Create(nil);
    qry.Connection := dbConn;
    qry.FetchOptions.RecsMax:= -1;
    qry.FetchOptions.Mode:= fmAll;
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT COD_CADASTRO');
    qry.SQL.Add('FROM CADASTRO');
    qry.SQL.Add('WHERE CNPJ = :PCOD');
    qry.ParamByName('PCOD').AsString := sCnpj;
    qry.Open();
    iCOD := qry.FieldByName('COD_CADASTRO').AsInteger;
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('select');
    qry.SQL.Add('a.seq');
    qry.SQL.Add(',b.razao');
    qry.SQL.Add(',d.endereco');
    qry.SQL.Add(',d.cgc');
    qry.SQL.Add(',d.bairro');
    qry.SQL.Add(',d.cep');
    qry.SQL.Add(',d.cidade');
    qry.SQL.Add(',d.uf');
    qry.SQL.Add(',a.nosso_numero');
    qry.SQL.Add(',a.documento');
    qry.SQL.Add(',a.juros');
    qry.SQL.Add(',a.multa');
    qry.SQL.Add(',a.desconto');
    qry.SQL.Add(',a.responsavel');
    qry.SQL.Add(',cast(a.data_emissao as varchar(11)) as emissao');
    qry.SQL.Add(',cast(a.data_venc as varchar(11)) as venc');
    qry.SQL.Add(',a.total_pagar');
    qry.SQL.Add(',d.nr');
    qry.SQL.Add(',d.razao_social as cedente');
    qry.SQL.Add(',c.localpagamento');
    qry.SQL.Add(',c.num_carteira');
    qry.SQL.Add(',c.num_conta');
    qry.SQL.Add(',c.digito_conta');
    qry.SQL.Add(',c.num_agencia');
    qry.SQL.Add(',c.digito_agencia');
    qry.SQL.Add(',a.seq_banco as banco');
    qry.SQL.Add(',c.descricao');
    qry.SQL.Add(',a.uuid_sribank');
    qry.SQL.Add('from contas a , cadastro b, banco c ,empresa d');
    qry.SQL.Add('where a.responsavel = b.cod_cadastro');
    qry.SQL.Add('  and a.tipo_conta = ''R''');
    qry.SQL.Add('  and a.cancelado  = ''F''');
    qry.SQL.Add('  and a.seq_banco  = c.seq_banco');
    qry.SQL.Add('  and d.empresa = 0');
    qry.SQL.Add('and a.responsavel   = :PCOD');
    qry.SQL.Add('and a.total_pagar   > 0');
    qry.SQL.Add('and a.data_venc     > :Pdata');

    qry.ParamByName('PCOD').AsInteger := iCOD;
    qry.ParamByName('pdata').AsDate   := StrToDate('01/08/2021');
    qry.Open();


  except
      on e: Exception do
      begin
        erro:= e.Message;
        if Assigned(Result) then
          FreeAndNil(Result);

        Result:= TJSONObject.Create();
        Result.AddPair(TJSONPair.Create('result', TJSONBool.Create(False)));
        Result.AddPair(TJSONPair.Create('error', erro));
        Res.Status(400).Send<TJSONObject>(Result);
        exit;
      end;
  end;
if Assigned(qry) and not qry.IsEmpty then
  begin
    jSONArray:= TJSONArray.Create;
    for I := 1 to qry.RecordCount do
      begin
        qry.RecNo:= I;
        var JSONObject:= TJSONObject.Create;

        JSONObject.AddPair('VENC'          , qry.FieldByName('VENC').AsString);
        JSONObject.AddPair('EMISSAO'       , qry.FieldByName('EMISSAO').AsString);
        JSONObject.AddPair('SEQ'           , qry.FieldByName('SEQ').AsString);
        JSONObject.AddPair('DOCUMENTO'     , qry.FieldByName('DOCUMENTO').AsString);
        JSONObject.AddPair('NOSSO_NUMERO'  , qry.FieldByName('NOSSO_NUMERO').AsString);
        JSONObject.AddPair('RAZAO'         , qry.FieldByName('RAZAO').AsString);
        JSONObject.AddPair('TOTAL_PAGAR'   , TJSONNumber.Create(qry.FieldByName('TOTAL_PAGAR').AsFloat));
        JSONObject.AddPair('CGC'           , qry.FieldByName('CGC').AsString);
        JSONObject.AddPair('ENDERECO'      , qry.FieldByName('ENDERECO').AsString);
        JSONObject.AddPair('NR'            , qry.FieldByName('NR').AsString);
        JSONObject.AddPair('BAIRRO'        , qry.FieldByName('BAIRRO').AsString);
        JSONObject.AddPair('CIDADE'        , qry.FieldByName('CIDADE').AsString);
        JSONObject.AddPair('CEDENTE'       , qry.FieldByName('CEDENTE').AsString);
        JSONObject.AddPair('UF'            , qry.FieldByName('UF').AsString);
        JSONObject.AddPair('NUM_CONTA'     , qry.FieldByName('NUM_CONTA').AsString);
        JSONObject.AddPair('NUM_CARTEIRA'  , qry.FieldByName('NUM_CARTEIRA').AsString);
        JSONObject.AddPair('NUM_AGENCIA'   , qry.FieldByName('NUM_AGENCIA').AsString);
        JSONObject.AddPair('DIGITO_CONTA'  , qry.FieldByName('DIGITO_CONTA').AsString);
        JSONObject.AddPair('DIGITO_AGENCIA', qry.FieldByName('DIGITO_AGENCIA').AsString);
        JSONObject.AddPair('LOCALPAGAMENTO', qry.FieldByName('LOCALPAGAMENTO').AsString);
        JSONObject.AddPair('CEP'           , qry.FieldByName('CEP').AsString);
        JSONObject.AddPair('BANCO'         , TJSONNumber.Create(qry.FieldByName('BANCO').AsInteger));
        JSONObject.AddPair('UUID_SRIBANK'  , qry.FieldByName('UUID_SRIBANK').AsString);

        jSONArray.Add(JSONObject);
      end;

    Res.Status(200).Send<TJSONArray>(jSONArray);
  end
else
  begin
    Result:= TJSONObject.Create();
    Result.AddPair(TJSONPair.Create('result', TJSONBool.Create(False)));
    Result.AddPair(TJSONPair.Create('error', 'nenhum resultado para a pesquisa'));
    Res.Status(500).Send<TJSONObject>(Result);
  end;

if Assigned(qry) then
  FreeAndNil(qry);
if Assigned(dbConn) then
  FreeAndNil(dbConn);
end;

procedure startPIXTransaction(Req: THorseRequest; Res: THorseResponse; Next: TProc);
type
  TTransaction = record
    status     : string;
    qrcodeStrStream: string;
    qrCodeData : string;
    totalAmount: Real;
    paidAmount : Real;
    reference  : string;
    qrcodeURL  : string;
    transactionId: string;
    transactionType: string;
    transactionDate: Double;
    externalIdentifier: string;
  end;

const
  bodyLogin = '{"login":"{{login}}","password":"{{password}}"} ';
  qryCons  = 'select a.*, b.*, c.* ' +
             ' from contas a , cadastro b, banco c ' +
             ' where a.responsavel = b.cod_cadastro ' +
             ' and a.tipo_conta = ''R'' ' +
             ' and a.cancelado  = ''F'' ' +
             ' and a.seq_banco  = c.seq_banco ' +
             ' and b.cnpj = :cnpj ' +
             ' and a.total_pagar   > 0 ' +
             ' and a.data_venc > ''01.08.2021'' ' +
             ' and a.uuid_sribank = :uuid ';
var
  sToken   : string;
  send     : TStringStream;
  response : TStringStream;
  LInput   : TStringStream;
  LOutput  : TBytesStream;
  _idhttp  : TIdHTTP;
  jso      : TJSONObject;
  jsoParams: TJSONObject;
  jsoData  : TJSONObject;
  JSonValue: TJSonValue;
  Params   : TParams;
  dbConn   : TFDConnection;
  qry      : TFDQuery;
 // Transaction: TTransaction;
 cValorTotal: Currency;
 sComantario: string;
 cJuros, cMulta: Currency;
 strTemp: string;
begin
 send     := nil;
 response := nil;
 LInput   := nil;
 LOutput  := nil;
 _idhttp  := nil;
 jso      := nil;
 jsoParams:= nil;
 JSonValue:= nil;
 jsoData  := nil;
 dbConn   := nil;
 qry      := nil;
try
  if (SRIBankParams.access_token =EmptyStr)
    or (SRIBankParams.id_account=EmptyStr)
    or (SRIBankParams.access_token=EmptyStr) then
    begin
      raise Exception.Create('Não configurado.');
    end;
  try
    jsoParams   := Req.Body<TJSONObject>;
    Params.cnpj := jsoParams.GetValue('cnpj').Value;
    Params.document:= jsoParams.GetValue('uuid_document').Value;
  except
    raise Exception.Create('Parâmetros não informados');
  end;

  if Params.document=EmptyStr then
    raise Exception.Create('Não é possivel gerar pagamento com PIX');
  if Params.cnpj=EmptyStr then
    raise Exception.Create('CNPJ não informado');

  dbConn := connectDB(2);
  if (dbConn = nil) then
    raise Exception.Create('Nao foi possivel configurar o banco de dados');
  qry  := TFDQuery.Create(nil);
  qry.Connection := dbConn;
  qry.FetchOptions.RecsMax:= -1;
  qry.FetchOptions.Mode:= fmAll;
  qry.Close;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT JUROSCOB, MULTACOB');
  qry.SQL.Add(' FROM CONFIG_PARAMENTROS');
  qry.Open();
  if qry.IsEmpty then
    raise Exception.Create('Parâmetros inválidos. Verifique com o suporte');
  cJuros:=  qry.FieldByName('JUROSCOB').AsCurrency;
  cMulta:=  qry.FieldByName('MULTACOB').AsCurrency;
  qry.Close;
  FreeAndNil(dbConn);
  dbConn:= connectDB();
  if (dbConn = nil) then
    raise Exception.Create('Nao foi possivel configurar o banco de dados');
  qry.Connection := dbConn;
  //
  qry.Close;
  qry.SQL.Clear;
  qry.SQL.Text:= qryCons;
  qry.ParamByName('cnpj').AsString:=  Params.cnpj;
  qry.ParamByName('uuid').AsString:= Params.document;
  qry.Open();
  if qry.IsEmpty then
    begin
      raise Exception.Create('Conta não localizada.');
    end;
  cValorTotal:= qry.FieldByName('VALOR').AsCurrency +
                qry.FieldByName('JUROS').AsCurrency +
                qry.FieldByName('MULTA').AsCurrency -
                qry.FieldByName('DESCONTO').AsCurrency +
                qry.FieldByName('VALOR_PAGO').AsCurrency;

  if not (cValorTotal > 0) then
    begin
      raise Exception.Create('Conta ja foi quitada.');
    end;
  send     := nil;
  response := nil;
  jso      := nil;
  send     := TStringStream.Create(
                bodyLogin
                  .Replace('{{login}}',SRIBankParams.username,[])
                  .Replace('{{password}}',SRIBankParams.password,[])
              );
  response:= TStringStream.Create;
  _idhttp:= TIdHTTP.Create();
  _idhttp.Request.Clear;
  _idhttp.Request.Accept := 'application/json';
  _idhttp.Request.ContentType := 'application/json';
  _idhttp.ProtocolVersion := pv1_1;
  try
    _idhttp.Post(SRIBankParams.host + '/admin/transaction/login', send, response);
  except
     raise Exception.Create('Serviço não disponível.');
  end;
  jso:= TJSONObject.Create;
  jso.Parse(response.Bytes, 0);
  sToken:= jso.GetValue('token').Value;
  FreeAndNil(send);
  FreeAndNil(response);
  FreeAndNil(jso);
  //
  response:= TStringStream.Create;
  _idhttp.Request.CustomHeaders.Clear;
  _idhttp.Request.CustomHeaders.AddValue('x-access-token', sToken);
  try
    _idhttp.Get(SRIBankParams.host + '/mediator/payment/' +  Params.document, response);
    jso.Parse(response.Bytes, 0);
    FreeAndNil(response);
    jsoData:= jso.GetValue('data') as TJSONObject;
    Res.Status(200).Send<TJSONObject>(jsoData);
    Exit;
  except
  end;
  //
  //sComantario               := qry.FieldByName('DESCRICAO').AsString;
  sComantario               := 'Nosso número ' + FormatCurr('00000000', qry.FieldByName('SEQ').AsInteger);
  Params.amount             := cValorTotal;
  Params.total_amount       := cValorTotal;
  Params.transaction_date   := qry.FieldByName('DATA_VENC').AsDateTime;
  Params.expiration_date    := IncSecond(qry.FieldByName('DATA_VENC').AsDateTime, 86399);
  Params.sender_comment     := sComantario;
  Params.recipient_comment  := sComantario;
  Params.origin_device      := 'sriservicos.com';

  //

  jso:= TJSONObject.Create;
  jso
    .AddPair('document', Params.document)
    .AddPair('amount', TJSONNumber.Create(Params.total_amount))
    .AddPair('transaction_date', DateToISO8601(Params.transaction_date, false))
    .AddPair('expiration_date', DateToISO8601(Params.expiration_date, false))
    .AddPair('sender_comment', Params.sender_comment)
    .AddPair('recipient_comment', Params.recipient_comment)
    .AddPair('origin_device',Params.origin_device);

  send := TStringStream.Create(jso.ToString);
  FreeAndNil(jso);
  if Assigned(response) then
    FreeAndNil(response);
  response:= TStringStream.Create;
  try
    _idhttp.Post(SRIBankParams.host + '/mediator/payment', send, response);
  except
  end;
  if  (_idhttp.Response.ResponseCode=455) then     // gerar pagamento com juros e multa e nova data limite
    begin
      FreeAndNil(response);
      FreeAndNil(send);
      FreeAndNil(jso);

      Params.addInterestFine(cJuros,cMulta);
      jso:= TJSONObject.Create;
      jso
        .AddPair('document', Params.document)
        .AddPair('amount', TJSONNumber.Create(Params.total_amount))
        .AddPair('transaction_date', DateToISO8601(Params.transaction_date, false))
        .AddPair('expiration_date', DateToISO8601(Params.expiration_date, false))
        .AddPair('sender_comment', Params.sender_comment)
        .AddPair('recipient_comment', Params.recipient_comment)
        .AddPair('origin_device',Params.origin_device);
      send := TStringStream.Create(jso.ToString);
      response := TStringStream.Create();
      _idhttp.Post(SRIBankParams.host + '/mediator/payment', send, response);
    end
  else
  if (_idhttp.Response.ResponseCode=459)  then  // gerar novo uuid
    begin
      FreeAndNil(response);
      FreeAndNil(send);
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Text:= 'select UUID_TO_CHAR(gen_uuid()) from rdb$database';
      qry.Open();
      strTemp:= qry.FieldByName('UUID_TO_CHAR').AsString;
      qry.Close;
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.add('update contas set UUID_SRIBANK=:newuuid');
      qry.SQL.add('where UUID_SRIBANK=:olduuid');
      qry.ParamByName('newuuid').AsString:= strTemp;
      qry.ParamByName('olduuid').AsString:= Params.document;
      qry.ExecSQL;
      Params.document:= strTemp;
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Text:= qryCons;
      qry.ParamByName('cnpj').AsString:=  Params.cnpj;
      qry.ParamByName('uuid').AsString:= Params.document;
      qry.Open();
      FreeAndNil(jso);
      Params.addInterestFine(cJuros,cMulta);
      jso:= TJSONObject.Create;
      jso
        .AddPair('document', Params.document)
        .AddPair('amount', TJSONNumber.Create(Params.total_amount))
        .AddPair('transaction_date', DateToISO8601(Params.transaction_date, false))
        .AddPair('expiration_date', DateToISO8601(Params.expiration_date, false))
        .AddPair('sender_comment', Params.sender_comment)
        .AddPair('recipient_comment', Params.recipient_comment)
        .AddPair('origin_device',Params.origin_device);
      send := TStringStream.Create(jso.ToString);
      response := TStringStream.Create();
      _idhttp.Post(SRIBankParams.host + '/mediator/payment', send, response);
    end;

  jso:= TJSONObject.Create();
  jso.Parse(response.Bytes, 0);
  sComantario:= jso.ToString;
  jsoData:= jso.GetValue('data') as TJSONObject;
  sComantario:= jsoData.ToString;
  Res.Status(200).Send<TJSONObject>(jsoData);
except
  on e: EIdHTTPProtocolException do
    begin
      if Assigned(jso) then
        FreeAndNil(jso);
      jso:= TJSONObject.Create();
      jso.AddPair(TJSONPair.Create('result', TJSONBool.Create(False)));
      jsoData:= TJSONObject.Create();
      jsoData.Parse(BytesOf(e.ErrorMessage), 0);
      var eMSG: string;
      eMSG:= EmptyStr;
      try
        eMSG:= jsoData.GetValue('erro').Value;
      except
      end;
      if eMSG=EmptyStr then
        jso.AddPair(TJSONPair.Create('error', jsoData))
      else
        jso.AddPair(TJSONPair.Create('error', eMSG));
      Res.Status(e.ErrorCode).Send<TJSONObject>(jso);
    end;
  on e: Exception do
    begin
      if Assigned(jso) then
        FreeAndNil(jso);
      jsoData:= TJSONObject.Create();
      jsoData.AddPair(TJSONPair.Create('result', TJSONBool.Create(False)));
      jsoData.AddPair(TJSONPair.Create('error', e.Message));
      Res.Status(400).Send<TJSONObject>(jsoData);
    end;
end;
  if Assigned(send) then
    FreeAndNil(send);
  if Assigned(response) then
    FreeAndNil(response);
  if Assigned(LInput) then
    FreeAndNil(LInput);
  if Assigned(LOutput) then
    FreeAndNil(LOutput);
  if Assigned(_idhttp) then
    FreeAndNil(_idhttp);
  if Assigned(JSonValue) then
    FreeAndNil(JSonValue);
  if Assigned(dbConn) then
    FreeAndNil(dbConn);
  if Assigned(qry) then
    FreeAndNil(qry);
end;

procedure queryPIXTransaction(Req: THorseRequest; Res: THorseResponse; Next: TProc);
const
  bodyLogin = '{"login":"{{login}}","password":"{{password}}"} ';
var
  sToken   : string;
  send     : TStringStream;
  response : TStringStream;
  _idhttp  : TIdHTTP;
  jso      : TJSONObject;
  jsoData  : TJSONObject;
  jsoPag   : TJSONObject;
  Params   : TParams;
  sqlCont     : TFDQuery;
  dbConn   : TFDConnection;
begin
 send     := nil;
 response := nil;
 _idhttp  := nil;
 jso      := nil;
 jsoData  := nil;

try
  if (SRIBankParams.access_token =EmptyStr)
    or (SRIBankParams.id_account=EmptyStr)
    or (SRIBankParams.access_token=EmptyStr) then
    begin
      raise Exception.Create('Não configurado.');
    end;
  try

    Params.cnpj    := Req.Params['cnpj'];
    Params.document:=  Req.Params['uuid'];
  except
    raise Exception.Create('Parâmetros não informados');
  end;

  if Params.document=EmptyStr then
    raise Exception.Create('Parâmetros ''uuid_document'' não informado');
  if Params.cnpj=EmptyStr then
    raise Exception.Create('CNPJ não informado');


  send     := nil;
  response := nil;
  jso      := nil;
  send     := TStringStream.Create(
                bodyLogin
                  .Replace('{{login}}',SRIBankParams.username,[])
                  .Replace('{{password}}',SRIBankParams.password,[])
              );
  response:= TStringStream.Create;
  _idhttp:= TIdHTTP.Create();
  _idhttp.Request.Clear;
  _idhttp.Request.Accept := 'application/json';
  _idhttp.Request.ContentType := 'application/json';
  _idhttp.ProtocolVersion := pv1_1;
  try
    _idhttp.Post(SRIBankParams.host + '/admin/transaction/login', send, response);
  except
     raise Exception.Create('Serviço não disponível.');
  end;
  jso:= TJSONObject.Create;
  jso.Parse(response.Bytes, 0);
  sToken:= jso.GetValue('token').Value;
  FreeAndNil(send);
  FreeAndNil(response);
  FreeAndNil(jso);
  //
  response:= TStringStream.Create;
  _idhttp.Request.CustomHeaders.Clear;
  _idhttp.Request.CustomHeaders.AddValue('x-access-token', sToken);

  _idhttp.Get(SRIBankParams.host + '/mediator/payment/' +  Params.document, response);
  jso:= TJSONObject.Create;
  jso.Parse(response.Bytes, 0);
  FreeAndNil(response);
  jsoData:= jso.GetValue('data') as TJSONObject;
  try
    jsoPag:= jsoData.GetValue('payerPayMediator') as TJSONObject;
    sqlCont   := TFDQuery.Create(nil);
    sqlCont.Connection:= dbConn;


    sqlCont.SQL.Clear;
    sqlCont.Close;
    sqlCont.SQL.Add('UPDATE CONTAS SET ');
    sqlCont.SQL.Add('JUROS = :JUROS,');
    sqlCont.SQL.Add('MULTA = :MULTA,');
    sqlCont.SQL.Add('DESCONTO = :DESCONTO,');
    sqlCont.SQL.Add('VALOR_PAGO = :VALOR_PAGO,');
    sqlCont.SQL.Add('TOTAL_PAGAR = :TOTAL_PAGAR,');
    sqlCont.SQL.Add('FORMA_PAGAMENTO = 0,');
    sqlCont.SQL.Add('DATA_PAGAMENTO = iif(cast(:TOTAL_PAGAR AS NUMERIC(12,2)) = 0, current_date, null)');
    sqlCont.SQL.Add('WHERE SEQ = :SEQ');
    sqlCont.Close;
    sqlCont.SQL.Clear;
    sqlCont.SQL.Add('INSERT INTO CONTAS_HISTORICO');
    sqlCont.SQL.Add('( COD_CONTA');
    sqlCont.SQL.Add(', DATA_EMISSAO');
    sqlCont.SQL.Add(', DATA_PAGAMENTO');
    sqlCont.SQL.Add(', VALOR');
    sqlCont.SQL.Add(', JUROS');
    sqlCont.SQL.Add(', MULTA');
    sqlCont.SQL.Add(', DESCONTO');
    sqlCont.SQL.Add(', COD_COLABORADOR_BAIXA');
    sqlCont.SQL.Add(', COD_FINALIZADORA');
    sqlCont.SQL.Add(', COD_BANCO');
    sqlCont.SQL.Add(', COD_CENTRO_CUSTO');
    sqlCont.SQL.Add(', NR_CHEQUE');
    sqlCont.SQL.Add(') VALUES (');
    sqlCont.SQL.Add('  :COD_CONTA');
    sqlCont.SQL.Add(', :DATA_EMISSAO');
    sqlCont.SQL.Add(', CURRENT_DATE');
    sqlCont.SQL.Add(', :VALOR');
    sqlCont.SQL.Add(', :JUROS');
    sqlCont.SQL.Add(', :MULTA');
    sqlCont.SQL.Add(', :DESCONTO');
    sqlCont.SQL.Add(', :COD_COLABORADOR_BAIXA');
    sqlCont.SQL.Add(', :COD_FINALIZADORA');
    sqlCont.SQL.Add(', :COD_BANCO');
    sqlCont.SQL.Add(', :COD_CENTRO_CUSTO');
    sqlCont.SQL.Add(', :NR_CHEQUE)');
    sqlCont.ParamByName('JUROS').AsCurrency      := cdsXML.FieldByName('JUROS').AsCurrency;
        sqlCont.ParamByName('MULTA').AsCurrency      := cdsXML.FieldByName('MULTA').AsCurrency;
        sqlCont.ParamByName('DESCONTO').AsCurrency   := cdsXML.FieldByName('DESCONTO').AsCurrency;
        sqlCont.ParamByName('SEQ').AsInteger         := cdsXML.FieldByName('SEQ').AsInteger;
        sqlCont.ParamByName('VALOR_PAGO').AsCurrency := cdsXML.FieldByName('VLR_PAGAMENTO').AsCurrency + cdsXML.FieldByName('VALOR_PAGO').AsCurrency;
        sqlCont.ParamByName('TOTAL_PAGAR').AsCurrency:= cdsXML.FieldByName('TOTAL_PAGAR').AsCurrency
                                                       + cdsXML.FieldByName('JUROS').AsCurrency
                                                       + cdsXML.FieldByName('MULTA').AsCurrency
                                                       - cdsXML.FieldByName('DESCONTO').AsCurrency
                                                       - cdsXML.FieldByName('VLR_PAGAMENTO').AsCurrency;
        //
        sqlContHist.ParamByName('COD_CONTA').AsInteger     := cdsXML.FieldByName('SEQ').AsInteger;
        sqlContHist.ParamByName('DATA_EMISSAO').AsDateTime := cdsXML.FieldByName('DATA_EMISSAO').AsDateTime;
        sqlContHist.ParamByName('VALOR').AsCurrency     := cdsXML.FieldByName('VLR_PAGAMENTO').AsCurrency;
        sqlContHist.ParamByName('JUROS').AsCurrency     := cdsXML.FieldByName('JUROS').AsCurrency;
        sqlContHist.ParamByName('MULTA').AsCurrency     := cdsXML.FieldByName('MULTA').AsCurrency;
        sqlContHist.ParamByName('DESCONTO').AsCurrency  := cdsXML.FieldByName('DESCONTO').AsCurrency;
        sqlContHist.ParamByName('COD_COLABORADOR_BAIXA').AsInteger := iCodColaborador;
        sqlContHist.ParamByName('COD_FINALIZADORA').AsInteger      := iCodFinalizadora;
        sqlContHist.ParamByName('COD_BANCO').AsInteger             := 0;
        sqlContHist.ParamByName('COD_CENTRO_CUSTO').AsInteger      := 0;
        sqlContHist.ParamByName('NR_CHEQUE').AsString              := '000000';
        sqlCont.ExecSQL();
        sqlContHist.ExecSQL();
  except
     raise Exception.Create('Nenhum pagamento');
  end;

  Res.Status(200).Send<TJSONObject>(jsoData);


except
  on e: EIdHTTPProtocolException do
    begin
      if Assigned(jso) then
        FreeAndNil(jso);

      jso:= TJSONObject.Create();
      jso.AddPair(TJSONPair.Create('result', TJSONBool.Create(False)));
      jsoData:= TJSONObject.Create();
      jsoData.Parse(BytesOf(e.ErrorMessage), 0);
      var eMSG: string;
      eMSG:= EmptyStr;
      try
        eMSG:= jsoData.GetValue('erro').Value;
      except
      end;
      if eMSG=EmptyStr then
        jso.AddPair(TJSONPair.Create('error', jsoData))
      else
        jso.AddPair(TJSONPair.Create('error', eMSG));
      Res.Status(e.ErrorCode).Send<TJSONObject>(jso);
    end;
  on e: Exception do
    begin

      if Assigned(jso) then
        FreeAndNil(jso);

      jso:= TJSONObject.Create();
      jso.AddPair(TJSONPair.Create('result', TJSONBool.Create(False)));
      jso.AddPair(TJSONPair.Create('error', e.Message));
      Res.Status(400).Send<TJSONObject>(jso);
    end;
end;
  if Assigned(send) then
    FreeAndNil(send);
  if Assigned(response) then
    FreeAndNil(response);
  if Assigned(_idhttp) then
    FreeAndNil(_idhttp);
end;


function connectDB(numDB: Integer): TFDConnection;
begin
  Result:=  configureDB( Api.DataBase, numDB=2 );
end;

{ TParams }

procedure TParams.addInterestFine(Interest, Fine: currency);
var
  fDays: integer;
begin
if (Self.document=EmptyStr) then
  raise Exception.Create('"document" não pode ser nulo');

Self.expiration_date:=  IncSecond(
                                    StrToDate(DateToStr( Now() ) )
                                    , 86399
                                  );
fDays:= DaysBetween(self.expiration_date, self.transaction_date);
Self.total_amount:= Self.amount +
                  (Self.amount * ((Interest/30)*fDays)/100) +
                  (Self.amount * (Fine/100));
Self.total_amount:=  Round(Self.total_amount*100)/100;

end;

end.
