unit ufrmPix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

type
  TfrmPix = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Image2: TImage;
    procedure Image1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPix: TfrmPix;

implementation

{$R *.dfm}

procedure TfrmPix.FormShow(Sender: TObject);
begin
    Panel1.Left := (frmPix.ClientWidth div 2) - (Panel1.Width div 2);
    Panel1.Top :=  (Frmpix.ClientHeight div 2) - (Panel1.Height div 2);
end;

procedure TfrmPix.Image1Click(Sender: TObject);
begin
  close;
end;

end.
