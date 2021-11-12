object DM: TDM
  OldCreateOrder = False
  Encoding = esUtf8
  Height = 609
  Width = 595
  object DWevents: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'USUARIO'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'SENHA'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'ValidaLogin'
        EventName = 'ValidaLogin'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWeventsEventsValidaLoginReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'TECNICO'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'ListarServicos'
        EventName = 'ListarServicos'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWeventsEventsListarServicosReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'SEQ'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'STATUS'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'DEFEITO_RECLAMADO'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'ENCAMINHADO_POR'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'CLIENTE'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'ENDERECO'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'TELEFONE'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'InserirServicos'
        EventName = 'InserirServicos'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWeventsEventsInserirServicosReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'ID_SERVICO'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'DetalharServico'
        EventName = 'DetalharServico'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWeventsEventsDetalharServicoReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'ID_SERVICO'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'RETORNO'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'ASSINATURA'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'FecharServico'
        EventName = 'FecharServico'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWeventsEventsFecharServicoReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'BuscaServicosFechados'
        EventName = 'BuscaServicosFechados'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWeventsEventsBuscaServicosFechadosReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'TECNICO'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'ServicosFechados'
        EventName = 'ServicosFechados'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWeventsEventsServicosFechadosReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'cnpj'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'contasAbertas'
        EventName = 'contasAbertas'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWeventsEventscontasAbertasReplyEvent
      end>
    Left = 40
    Top = 96
  end
  object Conn: TFDConnection
    Params.Strings = (
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Database=C:\Sriautomacao\DADOSVR\SRICASH.FDB'
      'DriverID=FB')
    LoginPrompt = False
    Left = 40
    Top = 32
  end
  object FD: TFDQuery
    Connection = Conn
    Left = 104
    Top = 88
  end
  object Conn2: TFDConnection
    Params.Strings = (
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Database=C:\Sriautomacao\DADOSVR\SRICASH2.FDB'
      'DriverID=FB')
    LoginPrompt = False
    Left = 32
    Top = 176
  end
  object FD2: TFDQuery
    Connection = Conn2
    Left = 96
    Top = 208
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 488
    Top = 384
  end
end
