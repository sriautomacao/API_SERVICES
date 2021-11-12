object dm: Tdm
  OldCreateOrder = False
  Height = 425
  Width = 517
  object RESTClient: TRESTClient
    Authenticator = HTTPBasicAuthenticator
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://186.218.69.22:3100'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 48
    Top = 80
  end
  object HTTPBasicAuthenticator: THTTPBasicAuthenticator
    Username = 'sri'
    Password = 'wtgz135xy'
    Left = 168
    Top = 80
  end
  object RequestListarContas: TRESTRequest
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'CNPJ'
      end>
    Resource = 'contasAbertas'
    SynchronizedEvents = False
    Left = 168
    Top = 152
  end
end
