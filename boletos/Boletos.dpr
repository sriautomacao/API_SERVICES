program Boletos;

uses
  Vcl.Forms,
  ufrmPrincipal in 'ufrmPrincipal.pas' {frmPrincipal},
  udm in 'udm.pas' {dm: TDataModule},
  ufrmPix in 'ufrmPix.pas' {frmPix},
  ufrmRecibo in 'ufrmRecibo.pas' {frmRecibo},
  ufrmQRcodeSRIBank in 'ufrmQRcodeSRIBank.pas' {frmQRcodeSRIBank};

{$R *.res}

begin

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmRecibo, frmRecibo);
  Application.Run;
end.
