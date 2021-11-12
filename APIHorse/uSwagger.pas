unit uSwagger;

interface

uses
    Horse, System.SysUtils, System.Classes,
    GBSwagger.Model.Interfaces;

procedure loadswagger( var LSwagger: IGBSwagger; apiBase: string);

{$IFDEF HORSE_ISAPI}
procedure configSwagger(var LSwagger: IGBSwagger; host, module: string; Protocols_HTTP_and_HTTPS: Array of Boolean);
{$ENDIF}
{$IFDEF HORSE_CONSOLE}
procedure configSwagger(var LSwagger: IGBSwagger);
{$ENDIF}

implementation

procedure loadswagger( var LSwagger: IGBSwagger; apiBase: string);
begin
 //
end;

{$IFDEF HORSE_ISAPI}
procedure configSwagger(var LSwagger: IGBSwagger;host, module: string; Protocols_HTTP_and_HTTPS: Array of Boolean);
begin
  LSwagger
    .Config
      .ModuleName(module)
    .&End
    .Host(host)
    .Info
      .Title('Resultado de Venda')
      .Description('API de Resultado de Venda')
      .Contact
        .Name('Milton Junior')
        .Email('milton@sriautomacao.com.br')
      .&End
    .&End;
if Protocols_HTTP_and_HTTPS[0] then
  LSwagger.AddProtocol(TGBSwaggerProtocol.gbHttp);
if Protocols_HTTP_and_HTTPS[1] then
  LSwagger.AddProtocol(TGBSwaggerProtocol.gbHttps);
end;
{$ENDIF}
{$IFDEF HORSE_CONSOLE}
procedure configSwagger(var LSwagger: IGBSwagger);
begin
  LSwagger
    .Info
      .Title('Resultado de Venda')
      .Description('API de Resultado de Venda')
      .Contact
        .Name('Milton Junior')
        .Email('milton@sriautomacao.com.br')
      .&End
    .&End;
end;
{$ENDIF}

end.
