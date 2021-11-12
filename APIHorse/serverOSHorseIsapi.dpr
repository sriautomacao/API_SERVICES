library serverOSHorseIsapi;


{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  uFunctions in 'uFunctions.pas',
  uMain in 'uMain.pas',
  uClasses in 'uClasses.pas',
  Schema.Erro in 'schemas\Schema.Erro.pas',
  Schema.Error in 'schemas\Schema.Error.pas',
  Schema.Name in 'schemas\Schema.Name.pas',
  Schema.Report.AllTicket in 'schemas\Schema.Report.AllTicket.pas',
  Schema.Report.Cancel in 'schemas\Schema.Report.Cancel.pas',
  Schema.Report.ItemsServicesSold in 'schemas\Schema.Report.ItemsServicesSold.pas',
  Schema.Report.ItemsSold in 'schemas\Schema.Report.ItemsSold.pas',
  Schema.Report.ItemsSoldV2 in 'schemas\Schema.Report.ItemsSoldV2.pas',
  Schema.Report.Payment in 'schemas\Schema.Report.Payment.pas',
  Schema.Report.POSList in 'schemas\Schema.Report.POSList.pas',
  Schema.Report.SaleGroup in 'schemas\Schema.Report.SaleGroup.pas',
  Schema.Report.SalesTime in 'schemas\Schema.Report.SalesTime.pas',
  Schema.Ticket in 'schemas\Schema.Ticket.pas',
  uSwagger in 'uSwagger.pas',
  uConstants in 'uConstants.pas',
  uConfigDataBase in 'uConfigDataBase.pas';

{$R *.res}


begin
  TApi.Initialize();
  Api.Listen();
end.
