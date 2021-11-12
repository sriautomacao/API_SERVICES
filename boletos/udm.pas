unit udm;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,System.Json,
  REST.Authenticator.Basic, Data.Bind.Components, Data.Bind.ObjectScope;

type
  Tdm = class(TDataModule)
    RESTClient: TRESTClient;
    HTTPBasicAuthenticator: THTTPBasicAuthenticator;
    RequestListarContas: TRESTRequest;
    function ListarServicos(CNPJ: String; out jsonArray: TJSONArray;
  out erro: String): Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ Tdm }

function Tdm.ListarServicos(CNPJ: String; out jsonArray: TJSONArray;
  out erro: String): Boolean;
var json:string;
begin
   erro := '';
   try
      with RequestListarContas do
       begin
         Params.Clear;
         AddParameter('CNPJ',CNPJ,TRESTRequestParameterKind.pkgetorpost);
         Execute;
       end;
   except on ex:Exception do
     begin
       Result := False;
       erro := 'Erro ao listar Servicos :'+ex.Message;
       Exit
     end;
   end;

   if RequestListarContas.Response.StatusCode <> 200 then
     begin
       Result := False;
       erro   := 'Error ao listar Produto :'+RequestListarContas.Response.StatusCode.ToString;
     end
   else
     begin
       json      := RequestListarContas.Response.JSONValue.ToString;
       jsonArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json),0) as TjsonArray;
       Result    := True;
     end;


end;

end.
