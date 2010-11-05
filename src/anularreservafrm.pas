unit AnularReservaFrm; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, uDatos, CReserva, CEstadoLocalidad;

type

  { TfrmAnularReserva }

  TfrmAnularReserva = class(TForm)
    btnAceptar: TButton;
    btnCancelar: TButton;
    eDNI: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure eDNIChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
  private
    procedure Anular(sDni : String);
  public
    IntroducidoDni : boolean;
    DNI : String;
  end; 

var
  frmAnularReserva: TfrmAnularReserva;

implementation

procedure TfrmAnularReserva.FormCreate(Sender: TObject);
begin
    IntroducidoDni := False;
end;

procedure TfrmAnularReserva.eDNIChange(Sender: TObject);
begin

end;

procedure TfrmAnularReserva.btnCancelarClick(Sender: TObject);
begin
    Self.Close;
end;

procedure TfrmAnularReserva.btnAceptarClick(Sender: TObject);
begin
    if (eDNI.Text <> '') and (Length(eDNI.Text) = 9) then
    begin
        eDNI.Text := UpperCase(eDNI.Text);
        IntroducidoDNI := True;
        DNI := eDNI.Text;
        Anular(DNI);
        Self.Close;
    end;
end;

procedure TfrmAnularReserva.Anular(sDni : String);
var
    existeReserva : boolean;
    seguirBuscando : boolean;
    i,j, cantidad : integer;
begin
    existeReserva := False;
    seguirBuscando := True;
    i := 0;
    uDatos.LogearReservas;
    while seguirBuscando do
    begin
        ShowMessage('i= ' + IntToStr(i) + '/' + IntToStr(Reservas.Count));
        ShowMessage('"' + TReserva(Reservas.Items[i]).Dni + '" = "' + sDni + '"');
        if TReserva(Reservas.Items[i]).Dni = sDni then
        begin
            existeReserva := True;
            seguirBuscando := False;
            Reservas.Delete(i);
            cantidad := TReserva(Reservas.Items[i]).Cantidad;
            for j := 0 to cantidad do
            begin
                TReserva(Reservas.Items[i]).GetLocalidad(j).Estado := Libre;
                ShowMessage('j= ' + IntToStr(j) + '/' + IntToStr(cantidad));
            end;
        end
        else
        begin
            // NOTICE : limite del count
            if i = uDatos.Reservas.Count then
                seguirBuscando := False
            else
                i := i + 1;
        end;
    end;
    if not existeReserva then
        ShowMessage('No hay ninguna reserva que corresponda con ese DNI');
end;

{ TfrmAnularReserva }


initialization
  {$I anularreservafrm.lrs}

end.

