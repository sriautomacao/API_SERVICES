unit ufrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,System.json,
  Vcl.ExtCtrls, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Imaging.pngimage,System.net.HttpClient,
  Vcl.Menus, ACBrBase, ACBrMail, ACBrBoleto,MidasLib,
  ACBrBoletoFCFortesFr, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.FB, FireDAC.Phys.FBDef;

type
  TfrmPrincipal = class(TForm)
    Image2: TImage;
    Label1: TLabel;
    Image1: TImage;
    DataSource1: TDataSource;
    cdsContas: TClientDataSet;
    cdsContasConta: TIntegerField;
    cdsContasDocumento: TStringField;
    cdsContasNossoNumero: TStringField;
    cdsContasRazao: TStringField;
    cdsContasValor: TCurrencyField;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    cdsContasemissao: TDateField;
    cdsContasvencimento: TDateField;
    PopupMenu1: TPopupMenu;
    ACBrMail1: TACBrMail;
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
    ACBrBoletoReport: TACBrBoletoFCFortes;
    ACBrBoleto: TACBrBoleto;
    Label2: TLabel;
    cdsContasdias: TStringField;
    cdsContasbanco: TIntegerField;
    Label3: TLabel;
    Label4: TLabel;
    IB_SRICASH: TFDConnection;
    IB_SRICASH2: TFDConnection;
    FDQuery1: TFDQuery;
    Panel3: TPanel;
    cdsContasuuidPIX: TStringField;
    procedure Image1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure listarContas(cnpj: String);
    procedure incluirNaLista;
    procedure iniciaTransacaoPIX;
    function verificaNet():Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
const
  {$IFDEF DEBUG}
    hostAPI = 'http://127.0.0.1:3100';
  {$ELSE}
    hostAPI = 'https://app.sriservicos.com/api/serverOSHorseIsapi.dll';
  {$ENDIF}

implementation

uses
  udm, ufrmPix, ufrmQRcodeSRIBank, IdHTTP, Soap.EncdDecd, System.DateUtils;

{$R *.dfm}

procedure TfrmPrincipal.DBGrid1CellClick(Column: TColumn);
begin
  try
    Panel3.Enabled:= cdsContasuuidPIX.AsString.Length>0;
    if not Panel3.Enabled then
      begin
        Panel3.Enabled:= false;
        Panel3.Color := clGray;
      end
    else
       Panel3.Color := clFuchsia;
  except
    Panel3.Enabled:= false;
    Panel3.Color := clGray;
  end;
end;

procedure TfrmPrincipal.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  try
    Panel3.Enabled:= cdsContasuuidPIX.AsString.Length>0;
    if not Panel3.Enabled then
      begin
        Panel3.Enabled:= false;
        Panel3.Color := clGray;
      end
    else
       Panel3.Color := clFuchsia;
  except
    Panel3.Enabled:= false;
    Panel3.Color := clGray;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var  sLinha, sAux, sPathSysAdm : String;
     ARQ_CABCUPOM, STATUS_SYS : TEXTFILE;
     LINHA : INTEGER;
     sLocal,sLocal2,sLocal3:string;

begin



  if verificaNet = false then
   begin
     ShowMessage('Sem conexão com a internet');
     Application.Terminate;
   end;

    sPathSysAdm := ExtractFilePath(Application.ExeName)+ 'sysadm.txt';
    if fileexists(sPathSysAdm) then
       begin


         AssignFile (STATUS_SYS, sPathSysAdm);
         Reset( STATUS_SYS );
         while not Eof (status_sys) do
           begin

             ReadLn ( STATUS_SYS, sLinha    );
             if Copy(sLinha, 1, 8) = 'PATHSVR1' then
                slocal := Copy(sLinha, 12, Length(sLinha) - 11);

             if Copy(sLinha, 1, 8) = 'PATHSVR2' then
                slocal2 := Copy(sLinha, 12, Length(sLinha) - 11);

             if Copy(sLinha, 1, 8) = 'PATHCOTA' then
                sLocal3 := Copy(sLinha, 12, Length(sLinha) - 11);


           end;

         CloseFile ( STATUS_SYS );
       end
    else
       begin
         ShowMessage('Arquivo de Configuração do Sistema não encontrado');
         Application.terminate;
       end;


    try
      IB_SRICASH.Connected   := False;
      IB_SRICASH.LoginPrompt := False;
      ib_Sricash.params.UserName    := 'SYSDBA';
      ib_Sricash.params.Password    := 'masterkey';
      IB_SRICASH.params.Database    :=sLocal;
      IB_SRICASH.Connected   := True;
    except
      ShowMessage('Falha ao conectar ao banco banco 1!');
      Application.Terminate;
      Exit;
    end;


    try

      IB_SRICASH2.Connected        := False;
      IB_SRICASH2.LoginPrompt      := False;
      ib_Sricash2.params.Username  := 'SYSDBA';
      ib_Sricash2.params.Password  := 'masterkey';
      IB_SRICASH2.params.Database  := sLocal2;
      IB_SRICASH2.Connected        := True;

    except
      ShowMessage('Falha ao conectar ao banco banco 2!');
      Application.Terminate;
      Exit;
    end;





end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
var pr:String;
begin



  with FDQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('select CGC from empresa');
      Open();
    end;

    pr:=FDQuery1.FieldByName('CGC').AsString;
   /// pr:= '36685893000101';
   if pr = '' then
    begin
      ShowMessage('você precisa de executar atraver do SRICASH');
      Application.Terminate;
    end
   else
    begin
      cdsContas.CreateDataSet;
      {$IFDEF DEBUG}
         dm.RESTClient.BaseURL := 'http://127.0.0.1:3100';
      {$ELSE}
         dm.RESTClient.BaseURL := 'http://186.218.69.22:3100';
      {$ENDIF}


      listarContas(pr);
      try
        Panel3.Enabled:= cdsContasuuidPIX.AsString.Length>0;
        if not Panel3.Enabled then
          begin
            Panel3.Enabled:= false;
            Panel3.Color := clGray;
          end
        else
           Panel3.Color := clFuchsia;
      except
        Panel3.Enabled:= false;
        Panel3.Color := clGray;
      end;
    end;

end;

procedure TfrmPrincipal.Image1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmPrincipal.listarContas(cnpj: String);
var jsonArray :TJSONArray;
    erro:string;
  I,dias: Integer;
     vencimento,
     sdias,emissao:String;


begin
  try

    cdsContas.EmptyDataSet;
    if not dm.ListarServicos(cnpj,jsonArray,erro) then
      begin
       ShowMessage(erro);
       Exit;
      end;

   for I := 0 to jsonArray.Size -1 do
     begin
        vencimento := copy(jsonArray.Get(i).GetValue<String>('VENC'),9,2)+'/'+copy(jsonArray.Get(i).GetValue<String>('VENC'),6,2)+'/'+copy(jsonArray.Get(i).GetValue<String>('VENC'),1,4);
        emissao    := copy(jsonArray.Get(i).GetValue<String>('EMISSAO'),9,2)+'/'+copy(jsonArray.Get(i).GetValue<String>('EMISSAO'),6,2)+'/'+copy(jsonArray.Get(i).GetValue<String>('EMISSAO'),1,4);

        cdsContas.Append;
        cdsContasConta.AsString           := jsonArray.Get(i).GetValue<string>('SEQ');
        cdsContasDocumento.AsString       := jsonArray.Get(i).GetValue<string>('DOCUMENTO');
        cdsContasNossoNumero.AsString     := jsonArray.Get(i).GetValue<string>('NOSSO_NUMERO');
        cdsContasRazao.AsString           := jsonArray.Get(i).GetValue<String>('RAZAO');
        cdsContasEmissao.AsDateTime       := strtodate(emissao);
        cdsContasVencimento.Asdatetime    := Strtodate(vencimento);
        cdsContasValor.AsCurrency         := jsonArray.Get(i).GetValue<Real>(  'TOTAL_PAGAR');
        cdsContascnpjSacado.AsString      := jsonArray.Get(i).GetValue<String>('CGC');
        cdsContasenderecoSacado.AsString  := jsonArray.Get(i).GetValue<String>('ENDERECO');
        cdsContasnrSacado.AsString        := jsonArray.Get(i).GetValue<String>('NR');
        cdsContasbairroSacado.AsString    := jsonArray.Get(i).GetValue<String>('BAIRRO');
        cdsContascidadeSacado.AsString    := jsonArray.Get(i).GetValue<String>('CIDADE');
        cdsContasrazaoSacado.AsString     := jsonArray.Get(i).GetValue<String>('CEDENTE');
        cdsContasufSacado.AsString        := jsonArray.Get(i).GetValue<String>('UF');
        cdsContasnumConta.AsString        := jsonArray.Get(i).GetValue<String>('NUM_CONTA');
        cdsContasnumCarteira.AsString     := jsonArray.Get(i).GetValue<String>('NUM_CARTEIRA');
        cdsContasnumAgencia.AsString      := jsonArray.Get(i).GetValue<String>('NUM_AGENCIA');
        cdsContasdigitoConta.AsString     := jsonArray.Get(i).GetValue<String>('DIGITO_CONTA');
        cdsContasdigitoAgencia.AsString   := jsonArray.Get(i).GetValue<String>('DIGITO_AGENCIA');
        cdsContaslocalPagamento.AsString  := jsonArray.Get(i).GetValue<String>('LOCALPAGAMENTO');
        cdsContascepSacado.AsString       := jsonArray.Get(i).GetValue<String>('CEP');
        cdsContasbanco.AsInteger          := jsonArray.Get(i).GetValue<Integer>('BANCO');
        sdias:= formatFloat('0',(now - strtodate(vencimento)));
        dias := strtoint(sdias);
        if dias < 1 then
          cdsContasdias.AsString          := formatfloat('0',0) +' dias em atraso'
        else
          cdsContasdias.AsString          := formatfloat('0',dias) +' dias em atraso';
        try
          cdsContasuuidPIX.AsString       :=  jsonArray.Get(i).GetValue<String>('UUID_SRIBANK');
        except
          cdsContasuuidPIX.AsString       :=  EmptyStr;
        end;


        cdsContas.Post;
     end;
     cdsContas.IndexFieldNames := 'VENCIMENTO';

     if cdsContas.IsEmpty then
       Application.Terminate;



  finally
     jsonArray.DisposeOf;
  end;


end;

procedure TfrmPrincipal.Panel2Click(Sender: TObject);
begin

       ACBrBoleto.ListadeBoletos.Clear;
       incluirNaLista;


end;

procedure TfrmPrincipal.Panel3Click(Sender: TObject);
begin
iniciaTransacaoPIX();
end;

function TfrmPrincipal.verificaNet: Boolean;
var http:THttpClient;
  MyClass: TComponent;
begin
   Result := false;


   try
       http := THTTPClient.Create;

       Result := http.Head('https://google.com').StatusCode < 400;
   finally
     FreeAndNil(http);
   end;




end;

procedure TfrmPrincipal.incluirNaLista;
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

  ACBrBoleto.Banco.Nome := 'BANCO ITAU SA';


  tb := TFDQuery.Create(self);
  tb.Connection := IB_SRICASH;


  with tb do
   begin
     close;
     sql.Clear;
     sql.Add('select * from empresa');
     Open();
   end;



  ACBrBoleto.Cedente.FantasiaCedente := cdsContasrazaoSacado.asstring;
  ACBrBoleto.Cedente.Nome            := cdsContasrazaoSacado.asstring;
  ACBrBoleto.Cedente.Logradouro      := cdsContasenderecoSacado.asstring;
  ACBrBoleto.Cedente.Bairro          := cdsContasbairroSacado.asstring;
  ACBrBoleto.Cedente.Cidade          := cdsContascidadeSacado.asstring;
  ACBrBoleto.Cedente.CEP             := cdsContascepSacado.asstring;
  ACBrBoleto.Cedente.CNPJCPF         := cdsContascnpjSacado.asstring;
//  ACBrBoleto.Cedente.Telefone        := '34862500';

  ACBrBoleto.Cedente.Agencia         := cdsContasnumAgencia.asstring;
  ACBrBoleto.Cedente.AgenciaDigito   := cdsContasdigitoAgencia.asstring;
  ACBrBoleto.Cedente.Conta           := cdsContasnumConta.asstring;
  ACBrBoleto.Cedente.ContaDigito     := cdsContasdigitoConta.asstring;

  Titulo := ACBrBoleto.CriarTituloNaLista;

  with Titulo do
  begin
    Vencimento        := cdsContasvencimento.AsDateTime;
    DataDocumento     := cdsContasemissao.AsDateTime;
    NumeroDocumento   := cdsContasnossonumero.AsString;
    EspecieDoc        := 'DP';
    //if cbxAceite.ItemIndex = 0 then
    //   Aceite := atSim
    //else
    //   Aceite := atNao;
    DataProcessamento := Now;
    Carteira          := cdsContasnumCarteira.AsString;
    NossoNumero       := cdsContasnossonumero.AsString;
    ValorDocumento    := cdsContasvalor.AsCurrency;
    Sacado.NomeSacado := cdsContasRazao.asstring;
    Sacado.CNPJCPF    := tb.FieldBYName('CGC').asstring;
    Sacado.Logradouro := tb.FieldBYName('ENDERECO').asstring;
    Sacado.Numero     := tb.FieldBYName('NR').asstring;
    Sacado.Bairro     := tb.FieldBYName('BAIRRO').asstring;
    Sacado.Cidade     := tb.FieldBYName('CIDADE').asstring;
    Sacado.UF         := tb.FieldBYName('UF').asstring;
    Sacado.CEP        := tb.FieldBYName('CEP').asstring;
    ValorAbatimento   := 0;
    LocalPagamento    := cdsContaslocalPagamento.AsString;
    ValorMoraJuros    := 0;
    ValorDesconto     := 0;
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

 // ACBrBoleto.GerarPDF;
  ACBrBoleto.Imprimir;


  if Assigned(tb) then
    FreeAndNil(tb);

  if Assigned(infBanco) then
    FreeAndNil(infBanco);


end;

procedure TfrmPrincipal.iniciaTransacaoPIX;

var
  req,
  resp: TStringStream;
  jso: TJSONObject;
  LInput : TStringStream;
  LOutput: TBytesStream;
  qrcode : string;

begin
  if cdsContasuuidPIX.AsString=EmptyStr then
    begin
      ShowMessage('Não disponível para pagamento com PIX');
      Exit;
    end;
  frmQRcodeSRIBank:= TfrmQRcodeSRIBank.Create(Self);
  frmQRcodeSRIBank.IdHTTP1.Request.CustomHeaders.Clear;
  frmQRcodeSRIBank.IdHTTP1.Request.Accept  := 'text/javascript';
  frmQRcodeSRIBank.IdHTTP1.ProtocolVersion := pv1_1;
  frmQRcodeSRIBank.IdHTTP1.Request.ContentType := 'application/json';
  frmQRcodeSRIBank.IdHTTP1.ConnectTimeout:= 15000;
  frmQRcodeSRIBank.IdHTTP1.Request.BasicAuthentication:= true;
  frmQRcodeSRIBank.IdHTTP1.Request.Username := 'sri';
  frmQRcodeSRIBank.IdHTTP1.Request.Password := 'wtgz135xy';
  jso:= TJSONObject.Create;
  jso
    .AddPair('cnpj', FDQuery1.FieldByName('CGC').AsString)
    .AddPair('uuid_document', cdsContasuuidPIX.AsString);
  req  := TStringStream.Create(jso.ToString);
  resp := TStringStream.Create;
  frmQRcodeSRIBank.IdHTTP1.Post(hostAPI + '/pagamentopix', req, resp);
  FreeAndNil(req);
  FreeAndNil(jso);
  jso:= TJSONObject.Create();
  jso.Parse(resp.Bytes, 0);
  FreeAndNil(resp);
  cdsContas.Edit;
  cdsContasuuidPIX.AsString:= jso.GetValue('uuid').Value;
  cdsContas.Post;
  qrcode:=  (((jso.GetValue('instant_payment') as TJSONObject)
            .GetValue('generateImage') as TJSONObject)
            .GetValue('imageContent') as TJSONString).Value;
  LInput := TStringStream.Create(qrcode, TEncoding.ASCII);

  LOutput := TBytesStream.Create;

  Soap.EncdDecd.DecodeStream(LInput, LOutput);
  LOutput.Position:= 0;
  frmQRcodeSRIBank
    .cnpj:= FDQuery1.FieldByName('CGC').AsString;
  frmQRcodeSRIBank
    .textContent:= (jso.GetValue('instant_payment') as TJSONObject).GetValue('textContent').Value;
  frmQRcodeSRIBank
    .Image.Picture.LoadFromStream(LOutput);
  frmQRcodeSRIBank
    .status     := jso.GetValue('financial_statement').Value;
  frmQRcodeSRIBank
    .totalAmount:= (jso.GetValue('total_amount') as TJSONNumber).AsDouble;
  frmQRcodeSRIBank
    .paidAmount := (jso.GetValue('amount') as TJSONNumber).AsDouble;
  frmQRcodeSRIBank
    .textContent:= (jso.GetValue('instant_payment') as TJSONObject).GetValue('textContent').Value;
  frmQRcodeSRIBank
    .reference  := (jso.GetValue('instant_payment') as TJSONObject).GetValue('reference').Value;
  frmQRcodeSRIBank
    .qrcodeURL  := (jso.GetValue('instant_payment') as TJSONObject).GetValue('qrcodeURL').Value;
  frmQRcodeSRIBank
    .transactionId:= (jso.GetValue('transaction_id') as TJSONString).Value;
  frmQRcodeSRIBank
    .transactionDate:= ISO8601ToDate((jso.GetValue('transaction_date') as TJSONString).Value, False);
  frmQRcodeSRIBank
    .externalIdentifier:= jso.GetValue('uuid').Value;
  FreeAndNil(jso);
  if (cdsContasvencimento.AsDateTime < Yesterday()) then
    begin
      frmQRcodeSRIBank.Label1.Caption:=
        cdsContasdias.AsString + #13 +
        'Valor Corrigido: R$ ' + FormatCurr('######0.00', frmQRcodeSRIBank.totalAmount);
    end
  else
    begin
      frmQRcodeSRIBank.Label1.Caption:=
        'Valor do Título: R$ ' + FormatCurr('######0.00', frmQRcodeSRIBank.totalAmount);

    end;
  frmQRcodeSRIBank.ShowModal;
  FreeAndNil(frmQRcodeSRIBank);

end;

end.
