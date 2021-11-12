unit uServicesFunctions;

interface
uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client,
  FireDAC.Stan.Option, uConfigDataBase, System.IniFiles,
  ThreadFileLog, DM.POO.picpay;

type
  TServicesFunction= class
    strict private
      FDBConfig: TDBConfig;
      F_ThreadFileLog: TThreadFileLog;
    private
      procedure SetDBConfig(const Value: TDBConfig);
    public
      property  DBConfig: TDBConfig read FDBConfig write SetDBConfig;
      procedure doSavelog(Msg: String);
      procedure Build;
      procedure teste();
      destructor Destroy; override;
    published
      constructor Create();

  end;
var
  ServicesFunction: TServicesFunction;

implementation

{ TServicesFunction }
uses
  system.JSON, uConstants, uClasses;



procedure TServicesFunction.build;
var
  jso: TJSONObject;
  tJso: TJSONObject;
  list: TStringList;
  I, X, Z,
  iCont: integer;
  bPulaEnvioCancelados: Boolean;
  nomeArq: string;
  stringStream: TStringStream;
  stringList  : TStringList;
  dbConn: TFDConnection;
  qry: TFDQuery;
  idEmpresa: integer;
  oldFile, newFile: string;
  dirList : TStringList;
begin
jso         := nil;
qry         := nil;
dbConn      := nil;
stringList  := nil;
stringStream:= nil;

dirList := TStringList.Create;

try
  GetDirList(pathImport, dirList);
  for Z := 0 to dirList.Count -1 do
    begin
      list:= TStringList.Create;
      findFile(dirList[Z] ,'*C.Json', list);
      if list.Count > 10 then
        begin
          iCont:= 10;
          bPulaEnvioCancelados:= True;
        end
      else
        begin
          iCont:= list.Count;
        end;
      for I := 0 to iCont -1 do
        begin

          stringList   := TStringList.Create;
          stringList.LoadFromFile(list[I]);
          stringStream := TStringStream.Create(stringList.Text, TEncoding.UTF8);
          FreeAndNil(stringList);
          try

            jso:= TJSONObject.Create;
            jso.Parse(StringStream.Bytes, 0);
            FreeAndNil(StringStream);
            if not (jso.GetValue('Cnpj').Value.Length=14) then
              raise Exception.Create('CNPJ nao informado.');

            dbConn := configureDB(jso.GetValue('Cnpj').Value, Self.FDBConfig);
            if (dbConn = nil) then
              raise Exception.Create('Nao foi possivel configurar o banco de dados');
            qry  := TFDQuery.Create(nil);
            qry.Connection := dbConn;
            qry.FetchOptions.RecsMax:= -1;
            qry.FetchOptions.Mode:= fmAll;
            qry.Close;
            qry.SQL.Clear;
            qry.SQL.Add('insert into empresa (cnpj,razao)values(:cnpj,:razao)');
            qry.SQL.Add('ON CONFLICT ON CONSTRAINT unq_cnpj');
            qry.SQL.Add('do UPDATE SET cnpj = :cnpj');
            qry.SQL.Add('returning id');
            qry.ParamByName('cnpj').AsString := jso.GetValue('Cnpj').Value;
            qry.ParamByName('razao').AsString:= jso.GetValue('Razao').Value;
            qry.OpenOrExecute;
            idEmpresa:= qry.FieldByName('id').AsInteger;
            if idEmpresa=0 then
              raise Exception.Create('Numero de empresa invalida');
            qry.Close;
            qry.SQL.Clear;
            qry.SQL.Text:=  'INSERT INTO VENDA ('             +
                            'EMPRESA,          DATA, '        +
                            'DOCUMENTO,        CAIXA, '       +
                            'COD_COLABORADOR, '               +
                            'CANCELADO,        VALOR, '       +
                            'DESCONTO,         TOTAL, '       +
                            'HORA, '                          +
                            'NUMCCF,           CPFCNPJ) '     +
                            'VALUES ( '                       +
                            ':EMPRESA,         :DATA, '       +
                            ':DOCUMENTO,       :CAIXA, '      +
                            ':COD_COLABORADOR, '              +
                            ':CANCELADO,       :VALOR, '      +
                            ':DESCONTO,        :TOTAL, '      +
                            ':HORA, '                         +
                            ':NUMCCF,          :CPFCNPJ)'     +
                            'ON CONFLICT (EMPRESA, DATA, DOCUMENTO, CAIXA)' +
                            'DO UPDATE SET ' +
                            'CANCELADO = :CANCELADO ' +
                            'WHERE ' +
                            'VENDA.EMPRESA   = :EMPRESA   AND ' +
                            'VENDA.DATA      = :DATA      AND ' +
                            'VENDA.DOCUMENTO = :DOCUMENTO AND ' +
                            'VENDA.CAIXA     = :CAIXA     AND ' +
                            'VENDA.NUMCCF    = :NUMCCF';

            qry.ParamByName('EMPRESA').AsInteger           := idEmpresa;
            qry.ParamByName('DATA').AsDateTime             := StrToDate(StringReplace(jso.GetValue('Data').Value,'.','/',[rfReplaceAll]));
            qry.ParamByName('DOCUMENTO').AsString          := jso.GetValue('Documento').Value;
            qry.ParamByName('CAIXA').AsString              := jso.GetValue('Caixa').Value;
            qry.ParamByName('COD_COLABORADOR').AsInteger   := (jso.GetValue('CodColaborador') as TJSONNumber).AsInt;
            qry.ParamByName('CANCELADO').AsBoolean         := (jso.GetValue('Cancelado') as TJSONBool).AsBoolean;
            qry.ParamByName('VALOR').AsCurrency            := (jso.GetValue('Valor') as TJSONNumber).AsDouble;
            qry.ParamByName('DESCONTO').AsCurrency         := (jso.GetValue('Desconto') as TJSONNumber).AsDouble;
            qry.ParamByName('TOTAL').AsCurrency            := (jso.GetValue('SubTotal') as TJSONNumber).AsDouble;
            qry.ParamByName('HORA').AsDateTime             := StrToTime(jso.GetValue('Hora').Value);
            qry.ParamByName('NUMCCF').AsInteger            := (jso.GetValue('NumCCF') as TJSONNumber).AsInt;
            qry.ParamByName('CPFCNPJ').AsString            := jso.GetValue('DocCliente').Value;
            qry.ExecSQL();

            if ((jso.GetValue('Cancelado') as TJSONBool).AsBoolean) then
              begin
                qry.SQL.Clear;
                qry.SQL.Text:= 'DELETE FROM RECEBIMENTO WHERE ' +
                               'DOCUMENTO=:DOCUMENTO AND ' +
                               'CAIXA=:CAIXA AND '         +
                               'DATA=:DATA';
                qry.ParamByName('CAIXA').AsString               := jso.GetValue('Caixa').Value;
                qry.ParamByName('DOCUMENTO').AsString           := jso.GetValue('Documento').Value;
                qry.ParamByName('DATA').AsDate                  := StrToDate(StringReplace(jso.GetValue('Data').Value,'.','/',[rfReplaceAll]));
                qry.ExecSQL();

              end
            else
              begin
                for X := 0 to (jso.GetValue('Recebimento') as TJSONArray).Count -1 do
                  begin
                    tJso:= (jso.GetValue('Recebimento') as TJSONArray)[X] as TJSONObject;
                    qry.SQL.Clear;
                    qry.SQL.Text:=   'INSERT INTO RECEBIMENTO(  '                                +
                                            'EMPRESA,       CAIXA,            DOCUMENTO, '       +
                                            'DATA,          COD_FINALIZADORA, COD_COLABORADOR, ' +
                                            'NTEF,          VALOR, '                             +
                                            'FINALIZADORA,  TROCO, HORA) '                       +
                                            'VALUES ( '                                          +
                                            ':EMPRESA,      :CAIXA,           :DOCUMENTO, '      +
                                            ':DATA,         :COD_FINALIZADORA,:COD_COLABORADOR, '+
                                            ':NTEF,         :VALOR, '                            +
                                            ':FINALIZADORA, :TROCO, :HORA) '                     +
                                            'ON CONFLICT (EMPRESA, CAIXA, DOCUMENTO, DATA, NTEF )' +
                                                                'DO UPDATE SET ' +
                                                                'COD_FINALIZADORA = :COD_FINALIZADORA, ' +
                                                                'COD_COLABORADOR  = :COD_COLABORADOR, ' +
                                                                'VALOR            = :VALOR, ' +
                                                                'FINALIZADORA     = :FINALIZADORA, ' +
                                                                'TROCO            = :TROCO, ' +
                                                                'HORA             = :HORA  ' +
                                                                'WHERE ' +
                                                                'RECEBIMENTO.EMPRESA   = :EMPRESA   AND ' +
                                                                'RECEBIMENTO.DATA      = :DATA      AND ' +
                                                                'RECEBIMENTO.DOCUMENTO = :DOCUMENTO AND ' +
                                                                'RECEBIMENTO.CAIXA     = :CAIXA     AND ' +
                                                                'RECEBIMENTO.NTEF      = :NTEF';
                    qry.ParamByName('EMPRESA').AsInteger            := idEmpresa;
                    qry.ParamByName('CAIXA').AsString               := jso.GetValue('Caixa').Value;
                    qry.ParamByName('DOCUMENTO').AsString           := jso.GetValue('Documento').Value;
                    qry.ParamByName('DATA').AsDate                  := StrToDate(StringReplace(jso.GetValue('Data').Value,'.','/',[rfReplaceAll]));
                    qry.ParamByName('COD_FINALIZADORA').AsInteger   := (tJso.GetValue('CodFinalizadora') as TJSONNumber).AsInt;
                    qry.ParamByName('COD_COLABORADOR').AsInteger    := (jso.GetValue('CodColaborador') as TJSONNumber).AsInt;
                    qry.ParamByName('NTEF').AsString                := IntToStr(I+1);
                    qry.ParamByName('VALOR').AsCurrency             := (tJso.GetValue('Valor') as TJSONNumber).AsDouble;
                    qry.ParamByName('FINALIZADORA').AsString        := tJso.GetValue('Finalizadora').Value;
                    qry.ParamByName('TROCO').AsCurrency             := (tJso.GetValue('Troco') as TJSONNumber).AsDouble;
                    qry.ParamByName('HORA').AsTime                  := StrToTime(jso.GetValue('Hora').Value);
                    qry.ExecSQL();

                  end;
              end;
            for X := 0 to (jso.GetValue('Movimento') as TJSONArray).Count -1 do
              begin
                tJso:= (jso.GetValue('Movimento') as TJSONArray)[X] as TJSONObject;
                qry.SQL.Clear;
                qry.SQL.Add('INSERT INTO MOVIMENTO (');
                qry.SQL.Add('EMPRESA,');
                qry.SQL.Add('DATA,');
                qry.SQL.Add('DOCUMENTO,');
                qry.SQL.Add('CAIXA,');
                qry.SQL.Add('COD_PRODUTO,');
                qry.SQL.Add('QTD,');
                qry.SQL.Add('CFOP,');
                qry.SQL.Add('CANCELADO,');
                qry.SQL.Add('DESCONTO,');
                qry.SQL.Add('COMPRA,');
                qry.SQL.Add('VENDA,');
                qry.SQL.Add('ITEM,');
                qry.SQL.Add('TOTAL,');
                qry.SQL.Add('DESCRICAO,');
                qry.SQL.Add('UNIDADE,');
                qry.SQL.Add('COD_COLABORADOR,');
                qry.SQL.Add('HORA,');
                qry.SQL.Add('NUMCCF)');
                qry.SQL.Add('VALUES (');
                qry.SQL.Add(':EMPRESA,');
                qry.SQL.Add(':DATA,');
                qry.SQL.Add(':DOCUMENTO,');
                qry.SQL.Add(':CAIXA,');
                qry.SQL.Add(':COD_PRODUTO,');
                qry.SQL.Add(':QTD,');
                qry.SQL.Add(':CFOP,');
                qry.SQL.Add(':CANCELADO,');
                qry.SQL.Add(':DESCONTO,');
                qry.SQL.Add(':COMPRA,');
                qry.SQL.Add(':VENDA, ');
                qry.SQL.Add(':ITEM,');
                qry.SQL.Add(':TOTAL,');
                qry.SQL.Add(':DESCRICAO,');
                qry.SQL.Add(':UNIDADE,');
                qry.SQL.Add(':COD_COLABORADOR,');
                qry.SQL.Add(':HORA,');
                qry.SQL.Add(':NUMCCF)');
                qry.SQL.Add('ON CONFLICT (EMPRESA, DATA, DOCUMENTO, CAIXA, COD_PRODUTO, ITEM)');
                qry.SQL.Add('DO UPDATE SET');
                qry.SQL.Add('CANCELADO = false,');
                qry.SQL.Add('QTD       = case when :CANCELADO then MOVIMENTO.QTD-1 else 1+MOVIMENTO.QTD end,');
                qry.SQL.Add('COMPRA    = (:COMPRA + MOVIMENTO.COMPRA)/2,');
                qry.SQL.Add('VENDA     = (:VENDA  + MOVIMENTO.VENDA) /2,');
                qry.SQL.Add('TOTAL     = case when :CANCELADO then  MOVIMENTO.TOTAL-30.75 else 30.75+MOVIMENTO.TOTAL end,');
                qry.SQL.Add('DESCONTO  = case when :CANCELADO then MOVIMENTO.DESCONTO-0 else 0+MOVIMENTO.DESCONTO end');
                qry.SQL.Add('WHERE');
                qry.SQL.Add('MOVIMENTO.EMPRESA     = :EMPRESA   AND');
                qry.SQL.Add('MOVIMENTO.DATA        = :DATA      AND');
                qry.SQL.Add('MOVIMENTO.DOCUMENTO   = :DOCUMENTO AND');
                qry.SQL.Add('MOVIMENTO.CAIXA       = :CAIXA     AND');
                qry.SQL.Add('MOVIMENTO.COD_PRODUTO = :COD_PRODUTO AND');
                qry.SQL.Add('MOVIMENTO.ITEM        = :ITEM');
                qry.ParamByName('EMPRESA').AsInteger      := idEmpresa;
                qry.ParamByName('DATA').AsDate            := StrToDate(StringReplace(jso.GetValue('Data').Value,'.','/',[rfReplaceAll]));
                qry.ParamByName('DOCUMENTO').AsString     := '000000';//VendaClass.FDocumento;
                qry.ParamByName('CAIXA').AsString         := '000';//VendaClass.FCaixa;
                qry.ParamByName('COD_PRODUTO').AsString   := tJso.GetValue('CodProduto').Value;
                qry.ParamByName('QTD').AsFloat            := (tJso.GetValue('Quantidade') as TJSONNumber).AsDouble;
                qry.ParamByName('COMPRA').AsFloat         := (tJso.GetValue('Compra') as TJSONNumber).AsDouble;
                qry.ParamByName('VENDA').AsFloat          := (tJso.GetValue('Venda') as TJSONNumber).AsDouble;
                qry.ParamByName('ITEM').AsString          := '001';//VendaClass.FMovimento[I].FItem;
                qry.ParamByName('TOTAL').AsFloat          := (tJso.GetValue('Total') as TJSONNumber).AsDouble;
                qry.ParamByName('DESCONTO').AsFloat       := (tJso.GetValue('Desconto') as TJSONNumber).AsDouble;
                qry.ParamByName('DESCRICAO').AsString     := tJso.GetValue('Descricao').Value;
                qry.ParamByName('UNIDADE').AsString       := tJso.GetValue('Unidade').Value;
                if (tJso.GetValue('Cfop').Value=EmptyStr) then
                  qry.ParamByName('CFOP').AsString        := '5102'
                else
                  qry.ParamByName('CFOP').AsString        := tJso.GetValue('Cfop').Value;
                qry.ParamByName('COD_COLABORADOR').AsInteger := (jso.GetValue('CodColaborador') as TJSONNumber).AsInt;
                qry.ParamByName('HORA').AsDateTime        := StrToTime(jso.GetValue('Hora').Value);
                qry.ParamByName('NUMCCF').AsInteger       := 0;//VendaClass.FNumCCF;
                qry.ParamByName('CANCELADO').AsBoolean    := (jso.GetValue('Cancelado') as TJSONBool).AsBoolean or
                                                             ((tJso.GetValue('Cancelado') as TJSONBool).AsBoolean);
                qry.ExecSQL();
              end;
            oldFile:= list[I];
            newFile:= Copy(list[I],1,(Pos('_C.Json', list[I])-1))+'_P.Json';
            if FileExists(newFile) then
              DeleteFile(PWideChar(newFile));
            RenameFile(oldFile, newFile);
          except
            on e: Exception do
              begin
                doSavelog( e.Message );
                oldFile:= list[I];
                newFile:= Copy(list[I],1,(Pos('_C.Json', list[I])-1))+'_F.Json';
                doSavelog('Renomeando arquivo '+oldFile+' para ' + newFile);
                if FileExists(newFile) then
                  begin
                    doSavelog('Arquivo '+ newFile + ' já existe! Deletando...');
                    DeleteFile(PWideChar(newFile));
                    doSavelog('Arquivo '+ newFile + ' apagado com sucesso.');
                  end;
                RenameFile(oldFile, newFile);
                doSavelog('Arquivo '+oldFile+' renomeado para ' + newFile+' com sucesso.');
              end;
          end;
          if Assigned(StringStream) then
            FreeAndNil(StringStream);
          if Assigned(qry) then
            FreeAndNil(qry);
          if Assigned(dbConn) then
            FreeAndNil(dbConn);
          if Assigned(jso) then
            FreeAndNil(jso);
          tJso:= nil;
        end;
        FreeAndNil(list)
    end;
finally
  FreeAndNil(dirList);
end;

end;

constructor TServicesFunction.Create();
var
  ini: Tinifile;
begin
  FDBConfig:= TDBConfig.Create;
  ForceDirectories(path);
  ForceDirectories(pathLog);
  Self.F_ThreadFileLog   := TThreadFileLog.Create();
  ini:= Tinifile.Create(iniFileName);
  if FileExists(iniFileName) then
    begin
      FDBConfig.SetHostName(ini.ReadString('DB','hostname', localhost));
      FDBConfig.SetUserName(ini.ReadString('DB','username', 'UserNameDB'));
      FDBConfig.SetPassword(ini.ReadString('DB','password', 'PasswordDB'));
      FDBConfig.SetPort(ini.ReadInteger('DB','port', 5432));
    end
  else
    begin
      FDBConfig.SetHostName(localhost);
      FDBConfig.SetUserName('UserNameDB');
      FDBConfig.SetPassword('PasswordDB');
      FDBConfig.SetPort(5432);
      ini.WriteString('DB'  ,'hostname', FDBConfig.HostName);
      ini.WriteString('DB'  ,'username', FDBConfig.UserName);
      ini.WriteString('DB'  ,'password', FDBConfig.Password);
      ini.WriteInteger('DB' ,'port'    , FDBConfig.Port);
    end;
  FreeAndNil(ini)

end;

destructor TServicesFunction.Destroy;
begin
  FreeAndNil(F_ThreadFileLog);
  FreeAndNil(FDBConfig);
  inherited;
end;

procedure TServicesFunction.doSavelog(Msg: String);
begin
try
  Self.F_ThreadFileLog.Log(TimeToStr(now) + ' : ' + Msg);
except
end;

end;

procedure TServicesFunction.SetDBConfig(const Value: TDBConfig);
begin
  FDBConfig := Value;
end;



procedure TServicesFunction.teste;
var
produto: DM.POO.picpay;
begin
produto:= TPRODUTODictionary.Create;
produto.
end;

end.
