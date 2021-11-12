unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  uDWAbout, uRESTDWServerEvents,uDWDatamodule,uDWJSONObject, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.VCLUI.Wait,System.JSON,Soap.EncdDecd, Datasnap.DBClient;

type
  TDM = class(TServerMethodDataModule)
    DWevents: TDWServerEvents;
    Conn: TFDConnection;
    FD: TFDQuery;
    Conn2: TFDConnection;
    FD2: TFDQuery;
    ClientDataSet1: TClientDataSet;
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


end.
