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
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'conta'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'email'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'emailCobranca'
        EventName = 'emailCobranca'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWeventsEventsemailCobrancaReplyEvent
      end>
    Left = 40
    Top = 95
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
  object cdsContas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 343
    Top = 292
    object cdsContasConta: TIntegerField
      FieldName = 'Conta'
    end
    object cdsContasDocumento: TStringField
      FieldName = 'Documento'
      Size = 15
    end
    object cdsContasNossoNumero: TStringField
      FieldName = 'NossoNumero'
      Size = 15
    end
    object cdsContasRazao: TStringField
      FieldName = 'Razao'
      Visible = False
      Size = 40
    end
    object cdsContasValor: TCurrencyField
      Alignment = taLeftJustify
      FieldName = 'Valor'
    end
    object cdsContasemissao: TDateField
      FieldName = 'emissao'
      Visible = False
    end
    object cdsContasvencimento: TDateField
      Alignment = taCenter
      FieldName = 'vencimento'
    end
    object cdsContasnosso_numero: TStringField
      FieldName = 'nosso_numero'
      Visible = False
    end
    object cdsContascnpjSacado: TStringField
      DisplayLabel = 'cnpj'
      FieldName = 'cnpjSacado'
      Visible = False
      Size = 14
    end
    object cdsContasenderecoSacado: TStringField
      FieldName = 'enderecoSacado'
      Visible = False
      Size = 200
    end
    object cdsContasnrSacado: TStringField
      FieldName = 'nrSacado'
      Visible = False
      Size = 5
    end
    object cdsContasbairroSacado: TStringField
      FieldName = 'bairroSacado'
      Visible = False
      Size = 100
    end
    object cdsContascidadeSacado: TStringField
      FieldName = 'cidadeSacado'
      Visible = False
      Size = 100
    end
    object cdsContasrazaoSacado: TStringField
      FieldName = 'razaoSacado'
      Visible = False
      Size = 60
    end
    object cdsContasufSacado: TStringField
      FieldName = 'ufSacado'
      Visible = False
      Size = 2
    end
    object cdsContasnumConta: TStringField
      FieldName = 'numConta'
      Visible = False
      Size = 10
    end
    object cdsContasnumCarteira: TStringField
      FieldName = 'numCarteira'
      Visible = False
      Size = 10
    end
    object cdsContasnumAgencia: TStringField
      FieldName = 'numAgencia'
      Visible = False
      Size = 10
    end
    object cdsContasdigitoConta: TStringField
      FieldName = 'digitoConta'
      Visible = False
      Size = 5
    end
    object cdsContasdigitoAgencia: TStringField
      FieldName = 'digitoAgencia'
      Visible = False
      Size = 5
    end
    object cdsContaslocalPagamento: TStringField
      FieldName = 'localPagamento'
      Visible = False
      Size = 100
    end
    object cdsContascepSacado: TStringField
      FieldName = 'cepSacado'
      Visible = False
      Size = 15
    end
    object cdsContasdias: TStringField
      Alignment = taRightJustify
      FieldName = 'dias'
    end
    object cdsContasbanco: TIntegerField
      FieldName = 'banco'
      Visible = False
    end
    object cdsContasemail: TStringField
      FieldName = 'email'
      Size = 200
    end
    object cdsContastelefone: TStringField
      FieldName = 'telefone'
      Size = 30
    end
  end
end
