unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  uDWAbout, uRESTDWServerEvents,uDWDatamodule,uDWJSONObject, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.VCLUI.Wait,System.JSON,Soap.EncdDecd, Datasnap.DBClient, ACBrBoleto,
  ACBrBase, ACBrBoletoFCFortesFr;

type
  TDM = class(TServerMethodDataModule)
    DWevents: TDWServerEvents;
    Conn: TFDConnection;
    FD: TFDQuery;
    Conn2: TFDConnection;
    FD2: TFDQuery;
    ClientDataSet1: TClientDataSet;
    cdsContas: TClientDataSet;
    cdsContasConta: TIntegerField;
    cdsContasDocumento: TStringField;
    cdsContasNossoNumero: TStringField;
    cdsContasRazao: TStringField;
    cdsContasValor: TCurrencyField;
    cdsContasemissao: TDateField;
    cdsContasvencimento: TDateField;
    cdsContasnosso_numero: TStringField;
    cdsContascnpjSacado: TStringField;
    cdsContasenderecoSacado: TStringField;
    cdsContasnrSacado: TStringField;
    cdsContasbairroSacado: TStringField;
    cdsContascidadeSacado: TStringField;
    cdsContasrazaoSacado: TStringField;
    cdsContasufSacado: TStringField;
    cdsContasnumConta: TStringField;
    cdsContasnumCarteira: TStringField;
    cdsContasnumAgencia: TStringField;
    cdsContasdigitoConta: TStringField;
    cdsContasdigitoAgencia: TStringField;
    cdsContaslocalPagamento: TStringField;
    cdsContascepSacado: TStringField;
    cdsContasdias: TStringField;
    cdsContasbanco: TIntegerField;
    cdsContasemail: TStringField;
    cdsContastelefone: TStringField;
    procedure DWeventsEventsValidaLoginReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWeventsEventsListarServicosReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWeventsEventsDetalharServicoReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWeventsEventsFecharServicoReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWeventsEventsInserirServicosReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWeventsEventsBuscaServicosFechadosReplyEvent(
      var Params: TDWParams; var Result: string);
    procedure DWeventsEventsServicosFechadosReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWeventsEventscontasAbertasReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWeventsEventsemailCobrancaReplyEvent(var Params: TDWParams;
      var Result: string);
    function IncluirNalista():Boolean;
  private

    { Private declarations }
  public
    { Public declarations }
    imgBase64:string;
  end;

var
  DM: TDM;

implementation

uses
  uDWConsts, FMX.Graphics, FMX.Dialogs, uFrmPrincipal;



{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}


procedure TDM.DWeventsEventsBuscaServicosFechadosReplyEvent(
  var Params: TDWParams; var Result: string);
  var fdCarga:TFDQuery;
  json:uDWJSONObject.TJSONValue;

begin

   try

       FDCarga := TFDQuery.Create(nil);
       FDCarga.Connection := dm.Conn;

       Json := uDWJSONObject.TJSONValue.Create;

       FDCarga.Active := False;
       FDCarga.SQL.Clear;
       FDCarga.SQL.Add('SELECT S.seq,H.retorno,H.data');
       FDCarga.SQL.Add('FROM SERVICO s,servico_historico H');
       FDCarga.SQL.Add('WHERE S.seq = H.id_servico');
       FDCarga.SQL.Add('AND SINC = 0');
       FDCarga.Active := True;

       Json.LoadFromDataset('',FDCarga,False,jmPureJson);

       Result := json.ToJSON;

       FDCarga.Active := False;
       FDCarga.SQL.Clear;
       FDCarga.SQL.Add('UPDATE SERVICO SET SINC = 1 WHERE SINC = 0');
       FDCarga.ExecSQL;


   finally
        Json.DisposeOf;
        FDCarga.DisposeOf;
   end;


end;

procedure TDM.DWeventsEventscontasAbertasReplyEvent(var Params: TDWParams;
  var Result: string);
var FDCarga:TFDQuery;
    Json:UDWjsonObject.TJSONValue;
    iCOD:Integer;
    sCnpj:String;
begin

    try
      sCnpj := Params.ItemsString['cnpj'].AsString;

       FDCarga := TFDQuery.Create(nil);
       FDCarga.Connection := dm.Conn;

       Json := uDWJSONObject.TJSONValue.Create;

       FDCarga.Active := False;
       FDCarga.SQL.Clear;
       FDCarga.SQL.Add('SELECT COD_CADASTRO');
       FDCarga.SQL.Add('FROM CADASTRO');
       FDCarga.SQL.Add('WHERE CNPJ = :PCOD');
       FDCarga.ParamByName('PCOD').AsString := sCnpj;
       FDCarga.Active := True;


       iCOD := FDCarga.FieldByName('COD_CADASTRO').AsInteger;



       FDCarga.Active := False;
       FDCarga.SQL.Clear;
       FDCarga.SQL.Add('select');
       FDCarga.SQL.Add('a.seq');
       FDCarga.SQL.Add(',b.razao');
       FDCarga.SQL.Add(',d.endereco');
       FDCarga.SQL.Add(',d.cgc');
       FDCarga.SQL.Add(',d.bairro');
       FDCarga.SQL.Add(',d.cep');
       FDCarga.SQL.Add(',d.cidade');
       FDCarga.SQL.Add(',d.uf');
       FDCarga.SQL.Add(',a.nosso_numero');
       FDCarga.SQL.Add(',a.documento');
       FDCarga.SQL.Add(',a.juros');
       FDCarga.SQL.Add(',a.multa');
       FDCarga.SQL.Add(',a.desconto');
       FDCarga.SQL.Add(',a.responsavel');
       FDCarga.SQL.Add(',cast(a.data_emissao as varchar(11)) as emissao');
       FDCarga.SQL.Add(',cast(a.data_venc as varchar(11)) as venc');
       FDCarga.SQL.Add(',a.total_pagar');
       FDCarga.SQL.Add(',d.nr');
       FDCarga.SQL.Add(',d.razao_social as cedente');
       FDCarga.SQL.Add(',c.localpagamento');
       FDCarga.SQL.Add(',c.num_carteira');
       FDCarga.SQL.Add(',c.num_conta');
       FDCarga.SQL.Add(',c.digito_conta');
       FDCarga.SQL.Add(',c.num_agencia');
       FDCarga.SQL.Add(',c.digito_agencia');
       FDCarga.SQL.Add(',a.seq_banco as banco');
       FDCarga.SQL.Add(',c.descricao');
       FDCarga.SQL.Add(',b.e_mail as email');
       FDCarga.SQL.Add(',b.telefone');
       FDCarga.SQL.Add('from contas a , cadastro b, banco c ,empresa d');
       FDCarga.SQL.Add('where a.responsavel = b.cod_cadastro');
       FDCarga.SQL.Add('  and a.tipo_conta = ''R''');
       FDCarga.SQL.Add('  and a.cancelado  = ''F''');
       FDCarga.SQL.Add('  and a.seq_banco  = c.seq_banco');
       FDCarga.SQL.Add('  and d.empresa = 0');
       FDCarga.SQL.Add('and a.responsavel   = :PCOD');
       FDCarga.SQL.Add('and a.total_pagar   > 0');
       FDCarga.SQL.Add('and a.data_venc     > :Pdata');


       FDCarga.ParamByName('PCOD').AsInteger := iCOD;
       FDCarga.ParamByName('pdata').AsDate   := strtodate('01/08/2021');
       FDCarga.Active := True;


      { FDCarga.Active := False;
       FDCarga.SQL.Clear;
       FDCarga.SQL.Add('SELECT');
       FDCarga.SQL.Add('a.seq');
       FDCarga.SQL.Add(',b.razao');
       FDCarga.SQL.Add(',a.nosso_numero');
       FDCarga.SQL.Add(',a.documento');
       FDCarga.SQL.Add(',a.responsavel');
       FDCarga.SQL.Add(',a.data_emissao');
       FDCarga.SQL.Add(',cast(a.data_emissao as varchar(11)) as emissao');
       FDCarga.SQL.Add(',cast(a.data_venc as varchar(11)) as venc');
       FDCarga.SQL.Add(',a.total_pagar');
       FDCarga.SQL.Add('from contas a , cadastro b');
       FDCarga.SQL.Add('where a.responsavel = b.cod_cadastro');
       FDCarga.SQL.Add('and a.tipo_conta    = '+chr(39)+'R'+chr(39));
       FDCarga.SQL.Add('and a.cancelado     = '+chr(39)+'F'+chr(39));
       FDCarga.SQL.Add('and a.responsavel   = :PCOD');
       FDCarga.SQL.Add('and a.total_pagar   > 0');

       FDCarga.ParamByName('PCOD').AsInteger := iCOD;
       FDCarga.Active := True;     }


       Json.LoadFromDataset('',FDCarga,False,jmPureJson);

       Result := json.ToJSON;

    finally
        Json.DisposeOf;
        FDCarga.DisposeOf;
    end;


end;

procedure TDM.DWeventsEventsDetalharServicoReplyEvent(var Params: TDWParams;
  var Result: string);
 var FDCarga:TFDQuery;
    Json:UDWjsonObject.TJSONValue;
    iFunc:Integer;
begin

    try
      iFunc := Params.ItemsString['ID_SERVICO'].AsInteger;

       FDCarga := TFDQuery.Create(nil);
       FDCarga.Connection := dm.Conn;

       Json := uDWJSONObject.TJSONValue.Create;

       FDCarga.Active := False;
       FDCarga.SQL.Clear;
       FDCarga.SQL.Add('SELECT *');
       FDCarga.SQL.Add('FROM VSERVICO');
       FDCarga.SQL.Add('WHERE SEQ = :FUNC');
       FDCarga.ParamByName('FUNC').AsInteger := iFunc;
       FDCarga.Active := True;

       Json.LoadFromDataset('',FDCarga,False,jmPureJson);

       Result := json.ToJSON;

    finally
        Json.DisposeOf;
        FDCarga.DisposeOf;
    end;


end;

procedure TDM.DWeventsEventsemailCobrancaReplyEvent(var Params: TDWParams;
  var Result: string);
var json:TjsonObject;
begin
   try
     if (Params.ItemsString['CONTA'].AsString  = '')   then
      BEGIN
        Result := '{"retorno":"Falta de Paramentros"}';
        Exit
      END;

     if (Params.ItemsString['EMAIL'].AsString  = '')   then
      BEGIN
        Result := '{"retorno":"Falta o email krai"}';
        Exit
      END;


       Result := '{"retorno":"OK"}';








   except;



   end;


end;

procedure TDM.DWeventsEventsFecharServicoReplyEvent(var Params: TDWParams;
  var Result: string);
var json:TjsonObject;
begin
   try
     if ((Params.ItemsString['ID_SERVICO'].AsString = '')
     or (Params.ItemsString['RETORNO'].AsString  = '')
     or (Params.ItemsString['ASSINATURA'].AsString  = ''))   then
      BEGIN
        Result := '{"retorno":"Falta de Paramentros"}';
        Exit
      END;

    try

      FD:= TFDQuery.Create(self);
      FD.Connection := Conn;

      try
        // incluii historico ...

        FD.Active := False;
        FD.sql.Clear;
        FD.sql.Add('UPDATE SERVICO SET RETORNO_TECNICO = :RETORNO');
        FD.sql.Add(',ATENDIDO_POR = ENCAMINHADO_POR');
        FD.sql.Add(',DATA_ATENDIMENTO = CURRENT_DATE');
        FD.sql.Add(',STATUS = 1');
        FD.sql.Add(',ASSINATURA = :ASS');
        FD.sql.Add('WHERE SEQ = :SEQ');
        FD.ParamByName('SEQ').AsInteger    := Params.ItemsString['ID_SERVICO'].AsInteger;
        FD.ParamByName('RETORNO').AsString := Params.ItemsString['RETORNO'].AsString;
       // FD.ParamByName('AT').AsInteger     := Params.ItemsString['ASSINATURA'].AsString;
        FD.ParamByName('ASS').AsString     := Params.ItemsString['ASSINATURA'].AsString;
        FD.ExecSQL;

        Result := '{"retorno":"OK"}';

      except on E:Exception do
        Result := '{"retorno":"'+E.Message+'"}';
      end;

    except on E:Exception do
      Result := '{"retorno":"'+E.Message+'"}';
    end;


   finally
    FD.DisposeOf;
   end;


end;

procedure TDM.DWeventsEventsInserirServicosReplyEvent(var Params: TDWParams;
  var Result: string);
var json:TjsonObject;

begin
   try
     if ((Params.ItemsString['SEQ'].AsString = '')
     or (Params.ItemsString['STATUS'].AsString  = '')
     or (Params.ItemsString['DEFEITO_RECLAMADO'].AsString  = '')
     or (Params.ItemsString['ENCAMINHADO_POR'].AsString  = '')
     or (Params.ItemsString['CLIENTE'].AsString  = '')
     or (Params.ItemsString['ENDERECO'].AsString  = '')
     or (Params.ItemsString['TELEFONE'].AsString  = '')) then
      BEGIN
        Result := '{"retorno":"Falta de Paramentros"}';
        Exit
      END;

    try

      FD:= TFDQuery.Create(self);
      FD.Connection := Conn;

      try
        // incluir
        //criar validação se já existe

        FD.Active := False;
        FD.sql.Clear;
        FD.sql.Add('INSERT INTO servico(');
        FD.sql.Add('SEQ');
        FD.sql.Add(',STATUS');
        FD.sql.Add(',DEFEITO_RECLAMADO');
        FD.sql.Add(',ENCAMINHADO_POR');
        FD.sql.Add(',CLIENTE');
        FD.sql.Add(',ENDERECO');
        FD.sql.Add(',TELEFONE)');
        FD.sql.Add('values(');
        FD.sql.Add(':SEQ');
        FD.sql.Add(',:STATUS');
        FD.sql.Add(',:DEFEITO_RECLAMADO');
        FD.sql.Add(',:ENCAMINHADO_POR');
        FD.sql.Add(',:CLIENTE');
        FD.sql.Add(',:ENDERECO');
        FD.sql.Add(',:TELEFONE)');
        FD.ParamByName('SEQ').AsInteger              := Params.ItemsString['SEQ'].AsInteger;
        FD.ParamByName('STATUS').AsInteger           := Params.ItemsString['STATUS'].AsInteger;
        FD.ParamByName('DEFEITO_RECLAMADO').AsString := Params.ItemsString['DEFEITO_RECLAMADO'].AsString;
        FD.ParamByName('ENCAMINHADO_POR').AsInteger  := Params.ItemsString['ENCAMINHADO_POR'].AsInteger;
        FD.ParamByName('CLIENTE').AsString           := Params.ItemsString['CLIENTE'].AsString;
        FD.ParamByName('ENDERECO').AsString          := Params.ItemsString['ENDERECO'].AsString;
        FD.ParamByName('TELEFONE').AsString          := Params.ItemsString['TELEFONE'].AsString;
        FD.ExecSQL;

        Result := '{"retorno":"OK"}';

      except on E:Exception do
        Result := '{"retorno":"'+E.Message+'"}';
      end;

    except on E:Exception do
      Result := '{"retorno":"'+E.Message+'"}';
    end;


   finally
     FD.DisposeOf;
   end;



end;

procedure TDM.DWeventsEventsListarServicosReplyEvent(var Params: TDWParams;
  var Result: string);
var FDCarga:TFDQuery;
    Json:UDWjsonObject.TJSONValue;
    iFunc:Integer;
    cdsTemp:TClientDataSet;
begin



  { cdsTemp := TClientDataSet.Create(Self);
   cdsTemp.Close;
   cdsTemp.FieldDefs.Clear;
   cdsTemp.FieldDefs.add('DATA',ftString,20);
   cdsTemp.FieldDefs.add('RAZAO',ftString,50);
   cdsTemp.CreateDataSet;
   }


    try
      iFunc := Params.ItemsString['TECNICO'].AsInteger;

       FDCarga := TFDQuery.Create(nil);
       FDCarga.Connection := dm.Conn;

       Json := uDWJSONObject.TJSONValue.Create;

       FDCarga.Active := False;
       FDCarga.SQL.Clear;
       FDCarga.SQL.Add('SELECT *');
       FDCarga.SQL.Add('FROM VSERVICO');
       FDCarga.SQL.Add('WHERE ENCAMINHADO_POR = :FUNC');
       FDCarga.SQL.Add('  AND STATUS = 4');
       FDCarga.ParamByName('FUNC').AsInteger := iFunc;
       FDCarga.Active := True;

      { while not FDCarga.eof do
         begin
           cdsTemp.Append;
           cdsTemp.FieldByName('DATA').AsString := FDCarga.FieldByName('DATA_CHAMADA').AsString;
           cdsTemp.Post;
           FDCarga.Next;
         end;}



       Json.LoadFromDataset('',FDCarga,False,jmPureJson);

       Result := json.ToJSON;

    finally
        Json.DisposeOf;
        FDCarga.DisposeOf;
    end;


end;

procedure TDM.DWeventsEventsServicosFechadosReplyEvent(var Params: TDWParams;
  var Result: string);
var FDCarga:TFDQuery;
    Json:UDWjsonObject.TJSONValue;
    iFunc:Integer;
    iData:TDate;
begin

    try
       iFunc := Params.ItemsString['TECNICO'].AsInteger;

       if Params.ItemsString['DATA'].AsString <> '0' then
         iData := strtodate(Params.ItemsString['DATA'].AsString);


       FDCarga := TFDQuery.Create(nil);
       FDCarga.Connection := dm.Conn;

       Json := uDWJSONObject.TJSONValue.Create;

       FDCarga.Active := False;
       FDCarga.SQL.Clear;
       FDCarga.SQL.Add('SELECT *');
       FDCarga.SQL.Add('FROM VSERVICO');
       FDCarga.SQL.Add('WHERE STATUS = 1');

       if iFunc <> 0 then
          FDCarga.SQL.Add('  AND ATENDIDO_POR = :FUNC');

       if Params.ItemsString['DATA'].AsString <> '0' then
          FDCarga.SQL.add('  AND DATA_ATENDIMENTO = :PDATE');

       if iFunc <> 0 then
          FDCarga.ParamByName('FUNC').AsInteger := iFunc;

       if Params.ItemsString['DATA'].AsString <> '0' then
          FDCarga.ParamByName('PDATE').AsDate   := iData;


       FDCarga.Active := True;

       Json.LoadFromDataset('',FDCarga,False,jmPureJson);

       Result := json.ToJSON;

    finally
        Json.DisposeOf;
        FDCarga.DisposeOf;
    end;

end;

procedure TDM.DWeventsEventsValidaLoginReplyEvent(var Params: TDWParams;
  var Result: string);
  var json:TjsonObject;
begin

   try


     frmPrincipal.conectaBanco;


    json := TJSONObject.Create;

     if ((Params.ItemsString['USUARIO'].AsString = '')
     or (Params.ItemsString['SENHA'].AsString  = ''))   then
      BEGIN
        json.AddPair('retorno','Usuario inválido');
        Result := json.ToString;
        Exit
      END;



      FD2.Active := False;
      FD2.sql.Clear;
      FD2.sql.Add('select * from colaborador where nome = :nome and senha = :senha');
      FD2.ParamByName('nome').AsString := Params.ItemsString['USUARIO'].AsString;
      FD2.ParamByName('senha').AsString := Params.ItemsString['SENHA'].AsString;
      FD2.Active := True;


     if not FD2.IsEmpty then
       begin
        json.AddPair('retorno','OK');
        json.AddPair('usuario',FD2.FieldByName('COD_COLABORADOR').AsString);
        Result := json.ToString;
       end
     else
        Result := '{"retorno":"usuário invalido"}';


   finally
     json.DisposeOf;
   end;



end;
function TDM.IncluirNalista: Boolean;
var
  Titulo : TACBrTitulo;
  VQtdeCarcA, VQtdeCarcB, VQtdeCarcC :Integer;
  VLinha, logo : string;
  tb,infBanco:TFDquery;
  i,seqBanco: Integer;
  slocalPagamento:string;
  ibanco : integer;
  sAgencia, sDigAgencia, sConta, sBanco, sCarteira, sCedente, saux : string;
  sDigConta : Char;
  tipoJ,tipoM :Real;
  aux1,aux2,aux3,aux4, sNomeBoleto, sMSG2, sMSG1, sMSG3, sMSG4, sCodigoCedente:string;
  teste:Integer;
  DIAS:String;
  instrucao: string;
begin

   tb := TFDQuery.Create(Self);
   tb.Connection := FDConnection1;

    with tb do
     begin
       Close;
       sql.Clear;
       SQL.Add('SELECT * FROM EMPRESA');
       Open;
     end;

   infBanco := TFDQuery.Create(Self);
   infBanco.Connection := FDConnection1;


     with infBanco do
      begin
        close;
        sql.Clear;
        sql.Add('SELECT * FROM CONTAS WHERE SEQ = :SEQ');
        ParamByName('SEQ').AsInteger := cdsContascodigo.AsInteger;
        open;

        seqBanco := FieldByName('SEQ_BANCO').AsInteger;
      end;

      with infBanco do
        begin
          close;
          sql.Clear;
          sql.Add('SELECT * FROM BANCO WHERE SEQ_BANCO = :SEQ');
          ParamByName('SEQ').AsInteger := seqBanco;
          open;
        end;


      slocalPagamento := infBanco.FieldByname('LOCALPAGAMENTO').asstring;

    if infBanco.FieldByName('TPJUROS').AsString = '$' then
      begin
      tipoJ := infBanco.fieldByName('JUROSCOB').AsFloat;
      aux2 := Copy(infBanco.fieldByName('INSCOB01').AsString,37,18);
      aux1:= Copy(infBanco.fieldByName('INSCOB01').AsString,1,32);

      sMSG1 := aux1 + ' ' +FormatFloat('0.00',tipoJ) + ' ' + aux2;
      end;

   if infBanco.FieldByName('TPJUROS').AsString = '%' then
      begin
      tipoJ := (cdsContasvalor.AsFloat*infbanco.fieldByName('JUROSCOB').AsInteger)/100;
      aux2 := ' por cento ao dia.';
      aux1:= Copy(infBanco.fieldByName('INSCOB01').AsString,1,29);
      sMSG1 := aux1 + ' ' +FormatFloat('0.00',tipoJ) + ' ' + aux2;

      end;


   if infBanco.FieldByName('TPMULTA').AsString = '$' then
      begin
        tipoM := infBanco.fieldByName('MULTACOB').AsFloat;
        aux3 := Copy(infbanco.fieldByName('INSCOB02').AsString,1,32);
        sMSG2 := aux3 + ' ' +FormatFloat('0.00',tipoM) + ' ' + aux4;
      end;

   if infBanco.FieldByName('TPMULTA').AsString = '%' then
      begin
      aux3 := infBanco.fieldByName('INSCOB02').AsString;
      sMSG2 := aux3;
      end;

   //MENSAGEM 3
   instrucao:=infBanco.FieldByName('INSTRUCAO_COBRANCA').AsString;
   if copy(instrucao,0,2) <> '00'
   then sMSG3:=copy(infBanco.FieldByName('INSTRUCAO_COBRANCA').AsString,6,54);


  dm.ACBrBoleto.Cedente.FantasiaCedente := tb.FieldBYName('FANTASIA').asstring;
  dm.ACBrBoleto.Cedente.Nome       := tb.FieldBYName('RAZAO_SOCIAL').asstring;;
  dm.ACBrBoleto.Cedente.Logradouro := tb.FieldBYName('ENDERECO').asstring;
  dm.ACBrBoleto.Cedente.Bairro     := tb.FieldBYName('BAIRRO').asstring;
  dm.ACBrBoleto.Cedente.Cidade     := tb.FieldBYName('CIDADE').asstring;
  dm.ACBrBoleto.Cedente.CEP        := tb.FieldBYName('CEP').asstring;
  dm.ACBrBoleto.Cedente.Telefone   := tb.FieldBYName('TELEFONE').asstring;
  dm.ACBrBoleto.Cedente.CNPJCPF    := tb.FieldBYName('CGC').asstring;

  dm.ACBrBoleto.Cedente.Agencia       := infBanco.FieldByName('NUM_AGENCIA').AsString;
  dm.ACBrBoleto.Cedente.AgenciaDigito := infBanco.FieldByName('DIGITO_AGENCIA').AsString;
  dm.ACBrBoleto.Cedente.Conta         := infBanco.FieldByName('NUM_CONTA').AsString;
  dm.ACBrBoleto.Cedente.ContaDigito   := infBanco.FieldByName('DIGITO_CONTA').AsString;

  Titulo := dm.ACBrBoleto.CriarTituloNaLista;

  with Titulo do
  begin
    Vencimento        := cdsContasvencimento.AsDateTime;
    DataDocumento     := cdsContasemissao.AsDateTime;
    NumeroDocumento   := cdsContasnosso_numero.AsString;
    EspecieDoc        := 'DP';
    //if cbxAceite.ItemIndex = 0 then
    //   Aceite := atSim
    //else
    //   Aceite := atNao;
    DataProcessamento := Now;
    Carteira          := infBanco.FieldByName('NUM_CARTEIRA').AsString;
    NossoNumero       := cdsContasnosso_numero.AsString;
    ValorDocumento    := cdsContasvalor.AsCurrency;
    Sacado.NomeSacado := cdsContasrazao.AsString;
    Sacado.CNPJCPF    := cdsContascnpj.Asstring;
    Sacado.Logradouro := cdsContasendereco.asstring;
    Sacado.Numero     := '0';
    Sacado.Bairro     := cdsContasbairro.AsString;
    Sacado.Cidade     := cdsContascidade.AsString;
    Sacado.UF         := cdsContasestado.AsString;
    Sacado.CEP        := cdsContascep.AsString;
    ValorAbatimento   := 0;
    LocalPagamento    := slocalPagamento;
    ValorMoraJuros    := cdsContasjuros.AsCurrency;
    ValorDesconto     := cdsContasdesconto.AsCurrency;
    ValorAbatimento   := 0;
    DataMoraJuros     := 0;
//    DataDesconto      := StrToDateDef(edtDataDesconto.Text, 0);
//    DataAbatimento    := StrToDateDef(edtDataAbatimento.Text, 0);
//    DataProtesto      := StrToDateDef(edtDataProtesto.Text, 0);
//    PercentualMulta   := StrToCurrDef(edtMulta.Text,0);
    //Mensagem.Text     := memMensagem.Text;
    OcorrenciaOriginal.Tipo := toRemessaBaixar;
    Instrucao1        := sMSG1 + #13+ sMSG2 + #13+ sMSG3 + #13+ sMSG4;
    Instrucao2        := '';

    QtdePagamentoParcial:= 1;
  //  TipoPagamento:= tpNao_Aceita_Valor_Divergente;
    PercentualMinPagamento:= 0;
    PercentualMaxPagamento:= 0;
    ValorMinPagamento:= 0;
    ValorMaxPagamento:= 0;

   // dm.ACBrBoleto.AdicionarMensagensPadroes(Titulo,Mensagem);

  {  if cbxLayOut.ItemIndex = 6 then
    begin
      for i:=0 to 3 do
      begin
        VLinha := '.';

        VQtdeCarcA := length('Descrição Produto/Serviço ' + IntToStr(I));
        VQtdeCarcB := Length('Valor:');
        VQtdeCarcC := 85 - (VQtdeCarcA + VQtdeCarcB);

        VLinha := PadLeft(VLinha,VQtdeCarcC,'.');

        Detalhamento.Add('Descrição Produto/Serviço ' + IntToStr(I) + ' '+ VLinha + ' Valor:   '+  PadRight(FormatCurr('R$ ###,##0.00', StrToCurr(edtValorDoc.Text) * 0.25),18,' ') );
      end;
      Detalhamento.Add('');
      Detalhamento.Add('');
      Detalhamento.Add('');
      Detalhamento.Add('');
      Detalhamento.Add('Desconto ........................................................................... Valor: R$ 0,00' );
    end;
          }
    logo:= ExtractFileDir(ParamStr(0)) + '\LOGO.bmp';

    ArquivoLogoEmp := logo;  // logo da empresa
    //ShowMessage(logo);

   // Verso := ((cbxImprimirVersoFatura.Checked) and ( cbxImprimirVersoFatura.Enabled = true ));
  end;

  dm.ACBrBoleto.GerarPDF;


  if Assigned(tb) then
    FreeAndNil(tb);

  if Assigned(infBanco) then
    FreeAndNil(infBanco);


end;

end.
