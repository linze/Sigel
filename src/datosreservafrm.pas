unit DatosReservaFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, uFuncionesComunes;

type

  { TfrmDatosReserva }

  TfrmDatosReserva = class(TForm)
    btnAceptar: TButton;
    btnCancelar: TButton;
    eEmail: TEdit;
    eNombre: TEdit;
    eDNI: TEdit;
    eTelefono: TEdit;
    Intro: TLabel;
    Label1: TLabel;
    NombreCompleto: TLabel;
    lbDNI: TLabel;
    lbContacto: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure eTelefonoKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    DatosIntroducidos : boolean;
    Nombre : String;
    DNI : String;
    Telefono : String;
    Email : String;
  end; 

var
  frmDatosReserva: TfrmDatosReserva;

implementation

{ TfrmDatosReserva }


procedure TfrmDatosReserva.btnCancelarClick(Sender: TObject);
begin
    Self.Close;
end;

procedure TfrmDatosReserva.eTelefonoKeyPress(Sender: TObject; var Key: char);
begin
end;

procedure TfrmDatosReserva.FormCreate(Sender: TObject);
begin
    Self.DatosIntroducidos := False;
end;

procedure TfrmDatosReserva.btnAceptarClick(Sender: TObject);
begin
    if (eNombre.Text <> '') and (DNIValido(eDNI.Text)) and ((eTelefono.Text <> '') or (not EsEmail(eEmail.Text))) then
    begin
        Self.DatosIntroducidos := True;
        Nombre := eNombre.Text;
        DNI := UpperCase(eDni.Text);
        Telefono := eTelefono.Text;
        Email := eEmail.Text;
        Self.Close;
    end
    else
        ShowMessage ('Se han de introducir todos los datos');
end;

initialization
  {$I datosreservafrm.lrs}

end.

