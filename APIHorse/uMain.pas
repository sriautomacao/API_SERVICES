unit uMain;

interface

uses
  System.SysUtils, System.Classes,
  Horse, uFunctions, Horse.Jhonson,
  Horse.BasicAuthentication, Horse.CORS,
  Horse.OctetStream, Horse.HandleException,
  Horse.Logger, Horse.Logger.Provider.LogFile,
  Horse.GBSwagger, System.IniFiles, uConfigDataBase;

type
  TConsole = procedure(cmd: String);
  TFConsole = function(Req: THorseRequest; Res: THorseResponse; Next: TProc): THorseCallback;

  TApi = class
    strict private
      FModule: string;
      FHostName: string;
      FEnableHTTPS: Boolean;
      FEnableHTTP: Boolean;
      FDataBase: TDBConfig;
    private
      LLogFileConfig: THorseLoggerLogFileConfig;
      function BasicAuthentication(const AUsername, APassword: string): Boolean;
      procedure SetHostName(const Value: string);
      procedure SetModule(const Value: string);
      procedure SetEnableHTTP(const Value: Boolean);
      procedure SetEnableHTTPS(const Value: Boolean);
      procedure SetDataBase(const Value: TDBConfig);
    public
      class procedure Initialize();
      {$IFDEF HORSE_ISAPI}
        procedure Listen;
      {$ENDIF}
      {$IFDEF HORSE_CONSOLE}
        procedure Listen(CallBack: TConsole);
        procedure Log(CallBack: THorseCallback);
      {$ENDIF}
    published
      property DataBase: TDBConfig read FDataBase write SetDataBase;
      property HostName: string read FHostName write SetHostName;
      property Module: string read FModule write SetModule;
      property EnableHTTP: Boolean read FEnableHTTP default false;
      property EnableHTTPS: Boolean read FEnableHTTPS default true;
      constructor Create;
  end;
var
  Api: TApi = nil;


implementation

uses
  uSwagger, uConstants, SRIBANK.PARAMS;

{ TAPI }

function TApi.BasicAuthentication(const AUsername, APassword: string): Boolean;
begin
  Result := AUsername.Equals('sri') and APassword.Equals('wtgz135xy');
  if not (Result) then
    Result:= (AUsername.Length=14) and (APassword.Length=32);
end;

constructor TApi.Create();
begin
  FDataBase:= TDBConfig.Create;
end;

class procedure TApi.Initialize;

var ini: Tinifile;
begin

  ForceDirectories(path);
  ForceDirectories(pathLog);
  Api:= TApi.Create();
  ini:= Tinifile.Create(sPathSysAdm);
  if FileExists(sPathSysAdm) then
    begin
      Api.DataBase.SetHostName(ini.ReadString('DB','hostname', localhost));
      Api.DataBase.SetDBName(ini.ReadString('DB','dbname', '127.0.0.1:C:\SRI\DADOS\SRICASH.FDB'));
      Api.DataBase.SetDBName2(ini.ReadString('DB','dbname2', '127.0.0.1:C:\SRI\DADOS\SRICASH2.FDB'));
      Api.DataBase.SetUserName(ini.ReadString('DB','username', 'UserNameDB'));
      Api.DataBase.SetPassword(ini.ReadString('DB','password', 'PasswordDB'));
      Api.DataBase.SetPort(ini.ReadInteger('DB','port', 3050));
      Api.SetHostName(ini.ReadString('IIS','hostName','localhost/mobile.dll'));
      Api.SetModule(ini.ReadString('IIS','module', 'mobile.dll'));
      Api.SetEnableHTTP(ini.ReadBool('IIS','EnableHttpSwagger'  , False));
      Api.SetEnableHTTPS(ini.ReadBool('IIS','EnableHttpsSwagger'  , True));
    end
  else
    begin
      Api.DataBase.SetHostName(localhost);
      Api.DataBase.SetDBName('127.0.0.1:C:\SRI\DADOS\SRICASH.FDB');
      Api.DataBase.SetDBName2('127.0.0.1:C:\SRI\DADOS\SRICASH2.FDB');
      Api.DataBase.SetUserName('UserNameDB');
      Api.DataBase.SetPassword('PasswordDB');
      Api.DataBase.SetPort(3050);
      Api.SetHostName('localhost/mobile.dll');
      Api.SetModule('mobile.dll');
      Api.SetEnableHTTP(False);
      Api.SetEnableHTTPS(True);
      ini.WriteString('DB'  ,'hostname', Api.DataBase.HostName);
      ini.WriteString('DB'  ,'dbname'  , Api.DataBase.DBName);
      ini.WriteString('DB'  ,'dbname2'  , Api.DataBase.DBName2);
      ini.WriteString('DB'  ,'username', Api.DataBase.UserName);
      ini.WriteString('DB'  ,'password', Api.DataBase.Password);
      ini.WriteInteger('DB' ,'port'    , Api.DataBase.Port);
      ini.WriteString('IIS','hostName' , Api.HostName);
      ini.WriteString('IIS','module'   , Api.Module);
      ini.WriteBool('IIS','EnableHttpSwagger'   , Api.EnableHTTP);
      ini.WriteBool('IIS','EnableHttpsSwagger'  , Api.EnableHTTPS);
    end;
  FreeAndNil(ini);
  SRIBankParams:= TSRIBankParams.Create();


{$IFDEF HORSE_ISAPI}
  configSwagger(Swagger, Api.HostName, Api.Module, [Api.EnableHTTP, Api.EnableHTTPS]);
{$ENDIF}
{$IFDEF HORSE_CONSOLE}
  configSwagger(Swagger);
{$ENDIF}

  THorse
    .Use(Jhonson('ISO-8859-1'))
    .Use(CORS)
    .Use(OctetStream)
    .Use(THorseLoggerManager.HorseCallback())
    .Use(HandleException)
    .Use(HorseBasicAuthentication(Api.BasicAuthentication));
//V1  Versão 1.0 da API
  THorse
    .Post('/contasAbertas', listTicket)
    .Post('/pagamentopix', startPIXTransaction)
    .Get('/pagamentopix/:cnpj/:uuid', queryPIXTransaction);


end;

{$IFDEF HORSE_CONSOLE}
procedure TApi.Listen(CallBack: TConsole);
begin
  THorse.Listen(3100,
      procedure(HORSE: THorse)
      begin
         CallBack('Rodando na porta: ' + HORSE.Port.ToString);
      end);
end;

procedure TApi.Log(CallBack: THorseCallback);
begin
 THorse.Use(CallBack);
end;
{$ENDIF}

{$IFDEF HORSE_ISAPI}
procedure TApi.Listen;
begin
  THorse.Listen();
end;
{$ENDIF}

procedure TApi.SetDataBase(const Value: TDBConfig);
begin
  FDataBase := Value;
end;

procedure TApi.SetEnableHTTP(const Value: Boolean);
begin
  FEnableHTTP := Value;
end;

procedure TApi.SetEnableHTTPS(const Value: Boolean);
begin
  FEnableHTTPS := Value;
end;

procedure TApi.SetHostName(const Value: string);
begin
  FHostName := Value;
end;

procedure TApi.SetModule(const Value: string);
begin
  FModule := Value;
end;



end.
