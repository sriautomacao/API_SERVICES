# Mobile
<b>Mobile</b> Api que fornece funções do resultado das vendas de produtos e serviços originados pelos aplicativos fiscais. 


## ⚙️ Instalando dependências
A instalação é feita usando o [`boss install`]:
``` sh
$ boss install
```

## ✔️ Compatibilidade
Este projeto é compatível com:
- [X] Delphi
- [ ] Lazarus

## ⚡️ Descrição do grupo de Projeto
=================
<!--ts-->
   * [ResultadoVenda] - Projeto de console com as funcionalidades da API para facilitar o desenvolvimento.
   * [mobile] - Projeto de DLL ISAPI. Deve ser instalado e configurado no IIS ou APACHE.
   * [ServicesResultadoVenda] - Microserviço que processa os arquivos JSONs enviados de forma não sincrônica.
   * [ServicesResultadoVendaTests] - Aplicação para teste unitários das funcionalidades do microserviço.
<!--te-->

## Configuração
Execute a aplicação console, pela primeira vez para gerar o arquivo [C:\SRI_SERVICES\ResultadoVendaHorse\ResultadoVenda.ini] e edite conforme o caso.
