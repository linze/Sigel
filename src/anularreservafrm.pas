unit AnularReservaFrm; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TfrmAnularReserva }

  TfrmAnularReserva = class(TForm)
    btnAceptar: TButton;
    btnCancelar: TButton;
    numDNI: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure DNIChange(Sender: TObject);
  private
    { private declarations }
  public
    ValidDNI : boolean;
  end; 

var
  frmAnularReserva: TfrmAnularReserva;

implementation

procedure TfrmAnularReserva.FormCreate(Sender: TObject);
begin
    ValidDNI := False;
end;

procedure TfrmAnularReserva.btnCancelarClick(Sender: TObject);
begin
    Self.Close;
end;

procedure TfrmAnularReserva.btnAceptarClick(Sender: TObject);
begin
    if numDNI.Text = 'a' then
    begin
        ValidDNI := True;
        Close;
    end
    else
        ShowMessage ('DNI no válido.');
end;


{ TfrmAnularReserva }

procedure TfrmAnularReserva.DNIChange(Sender: TObject);
begin

end;

initialization
  {$I anularreservafrm.lrs}

end.

