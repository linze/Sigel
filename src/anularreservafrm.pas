unit AnularReservaFrm; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, uDatos, CReserva, CEstadoLocalidad, CLocalidad, CEspera,
  uFuncionesComunes;

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
    if eDni.Text = '' then
        ShowMessage('Ha de indicar un DNI')
    else if not uFuncionesComunes.DNIValido(eDni.Text) then
        ShowMessage('DNI inválido')
    else
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
    i,j,k, cantidad : integer;
    numEsperas      : integer;
    Localidad : TLocalidad;
    completo  : boolean;
    esperado : boolean;
    asignadas : string;
begin
    existeReserva := False;
    seguirBuscando := True;
    esperado := False;
    i := 0;
    uDatos.LogearReservas;
    completo := uDatos.Sala.EstaCompleto;
    while (seguirBuscando) and (i < uDatos.Reservas.Count) do
    begin
        if TReserva(Reservas.Items[i]).Dni = sDni then
        begin
            existeReserva := True;
            seguirBuscando := False;
            asignadas := '';
            cantidad := TReserva(Reservas.Items[i]).Cantidad;
            if completo then
            begin
                 numEsperas := uDatos.Esperas.Count;
                 k := 0;
                 while not esperado do
                 begin
                     if (TEspera(uDatos.Esperas.Items[i]).Numero) < (cantidad + 1) then
                     begin
                          TEspera(uDatos.Esperas.Items[i]).Asignada := True;
                          for j := 0 to cantidad do
                          begin
                               Localidad := TReserva(Reservas.Items[i]).GetLocalidad(j);
                               Localidad.Estado := Comprada;
                               Sala.Cambiar(Localidad);
                               asignadas := asignadas + ' Tipo: ' + IntToStr(Ord(Localidad.Tipo)) + ' Fila: ' + IntToStr(Localidad.Fila) + ' Numero: ' + IntToStr(Localidad.Numero) + ' || ';
                          end;
                          TEspera(uDatos.Esperas.Items[i]).LocalidadesAsignadas := asignadas;
                          esperado := True;
                     end;
                     if k = numEsperas then
                        esperado := True
                     else
                         k := k + 1;
                 end;
            end
            else
            begin
            for j := 0 to cantidad do
            begin
                Localidad := TReserva(Reservas.Items[i]).GetLocalidad(j);
                Localidad.Estado := Libre;
                Sala.Cambiar(Localidad);
            end;
            end;
            Reservas.Delete(i);
        end
        else
        begin
            i := i + 1;
        end;
    end;
    if not existeReserva then
        ShowMessage('No hay ninguna reserva que corresponda con ese DNI')
    else
        ShowMessage('Reserva anulada con éxito');
end;

{ TfrmAnularReserva }


initialization
  {$I anularreservafrm.lrs}

end.

