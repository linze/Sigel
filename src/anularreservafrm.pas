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
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
  private
    { private declarations }
  public
    ValidDNI : boolean;
    DNIrecibido : TEdit;
  end; 

var
  frmAnularReserva: TfrmAnularReserva;

implementation

procedure TfrmAnularReserva.FormCreate(Sender: TObject);
begin
    ValidDNI := False;
end;

procedure TfrmAnularReserva.DNIChange(Sender: TObject);
begin

end;

procedure TfrmAnularReserva.btnCancelarClick(Sender: TObject);
begin
    Self.Close;
end;

procedure TfrmAnularReserva.btnAceptarClick(Sender: TObject);
begin
    // TODO validar comprobar si el DNI es válido
    ValidDNI := True;
    DNIrecibido := numDNI;
    Close;
end;


{ TfrmAnularReserva }


initialization
  {$I anularreservafrm.lrs}

end.

