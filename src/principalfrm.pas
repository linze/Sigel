{    This file is part of Sigel.

    Sigel is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Sigel is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Sigel.  If not, see <http://www.gnu.org/licenses/>. }
unit PrincipalFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, LoginFrm, FechaFrm, SeleccionButacaFrm, uDatos,
  CSala, AnularReservaFrm, DatosReservaFrm, CEstadoLocalidad, CReserva,
  AnularCompraFrm, VerListaEsperaFrm, DatosEspera, CEspera, VerEstadoSalaFrm,
  VerListaReservas, CLocalidad, uFuncionesComunes, PagarFrm, CreditosFrm;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
      btnCompra: TButton;
      btnReserva: TButton;
      btnAnularReserva: TButton;
      btnAnularCompra: TButton;
      btnLEspera: TButton;
      btnVisualizarEstado: TButton;
      btnSalir: TButton;
      btnLReservas: TButton;
      GroupBox1: TGroupBox;
      Image1: TImage;
      Image2: TImage;
      lbAdmin: TLabel;
      lbDescripcion: TLabel;
      Panel1: TPanel;
      Panel2: TPanel;
      Panel3: TPanel;
      Panel4: TPanel;
      procedure BotonMouseLeave(Sender: TObject);
      procedure BotonMouseEnter(Sender: TObject);
      procedure btnAnularCompraClick(Sender: TObject);
      procedure btnAnularReservaClick(Sender: TObject);
      procedure btnCompraClick(Sender: TObject);
      procedure btnLEsperaClick(Sender: TObject);
      procedure btnLEsperaMouseEnter(Sender: TObject);
      procedure btnLReservasClick(Sender: TObject);
      procedure btnReservaClick(Sender: TObject);
      procedure btnSalirClick(Sender: TObject);
      procedure btnVisualizarEstadoClick(Sender: TObject);
      procedure Button1Click(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure Image1DblClick(Sender: TObject);
      procedure lbAdminClick(Sender: TObject);
      procedure Panel2Click(Sender: TObject);
      function PedirPago(Cantidad: integer) : boolean;
  private
    procedure ProcesarListaEspera;
    procedure PasarAListaDeEspera (Fecha : TDateTime);
  public
    // Indica si se esta autenticado como administrador o no
    Autenticado : boolean;
  end; 

var
  frmPrincipal: TfrmPrincipal;

implementation

{ TfrmPrincipal }


procedure TfrmPrincipal.BotonMouseLeave(Sender: TObject);
begin
    lbDescripcion.Visible := False;
end;

procedure TfrmPrincipal.BotonMouseEnter(Sender: TObject);
begin
    lbDescripcion.Caption := (Sender as TButton).Hint;
    lbDescripcion.Visible := True;
end;

procedure TfrmPrincipal.btnAnularCompraClick(Sender: TObject);
var
   frmFecha :TfrmFecha;
   frmAnularCompra : TfrmAnularCompra;
begin
  frmFecha := TFrmFecha.Create(Self);
  try
      frmFecha.ShowModal;
      if frmFecha.FechaMarcada then
      begin
            uDatos.Cargar(frmFecha.Fecha);
            frmAnularCompra := TfrmAnularCompra.Create(Self);
            try
                frmAnularCompra.ShowModal;
                if frmAnularCompra.LocalidadAnulada then
                begin
                    ProcesarListaEspera;
                    uDatos.Guardar(frmFecha.Fecha);
                end;
            finally
                frmAnularCompra.Free;
            end;
      end;
  finally
         frmFecha.Free;
  end;
end;

procedure TfrmPrincipal.btnAnularReservaClick(Sender: TObject);
var
   frmFecha :TfrmFecha;
   frmAnular : TfrmAnularReserva;
begin
  frmFecha := TFrmFecha.Create(Self);
  try
      frmFecha.ShowModal;
      if frmFecha.FechaMarcada then
      begin
            uDatos.Cargar(frmFecha.Fecha);
            uDatos.LogearReservas;
            frmAnular := TfrmAnularReserva.Create(Self);
            frmAnular.ShowModal;
            if frmAnular.IntroducidoDni then
            begin
                ProcesarListaEspera;
                uDatos.Guardar(frmFecha.Fecha);
            end;
      end;
  finally
         frmFecha.Free;
  end;
end;

procedure TfrmPrincipal.btnCompraClick(Sender: TObject);
var
    frmFecha : TfrmFecha;
    frmSeleccionButaca : TFrmSeleccionButacas;
    i       : integer;
begin
    // Creamos el formulario de fechas
    frmFecha := TFrmFecha.Create(Self);
    try
        // Lo abrimos en modo compra
        frmFecha.EsReserva := False;
        // Mostramos la ventana
        frmFecha.ShowModal;
        // Si la fecha está marcada y se ha pulsado aceptar
        if frmFecha.FechaMarcada then
        begin
            // Cargamos el fichero de datos para la fecha indicada
            uDatos.Cargar(frmFecha.Fecha);
            // Si la sala está completa...
            if uDatos.Sala.EstaCompleto then
                // Invocamos el procedimiento de introducción en la lista
                // de espera.
                PasarAListaDeEspera(frmFecha.Fecha)
            else
            begin
                // Creamos la ventana de selección de butacas
                frmSeleccionButaca := TFrmSeleccionButacas.Create(Self);
                // ... en modo compra
                frmSeleccionButaca.Modo := ModoCompra;
                try
                    // Mostramos la ventana
                    frmSeleccionButaca.ShowModal;
                    // Si se ha marcado alguna butaca y se ha pulsado aceptar
                    if (frmSeleccionButaca.NumDeMarcadas > 0) and (frmSeleccionButaca.Aceptado) then
                    begin
                        // Se muestra la ventana de pago
                        if PedirPago(frmSeleccionButaca.GastoTotal) then
                        begin
                            // Se establecen las localidades del array que estén marcadas
                            // como compradas.
                            for i:=1 to 4 do
                            begin
                                if frmSeleccionButaca.Marcadas[i] then
                                begin
                                    frmSeleccionButaca.Localidades[i].Estado := Comprada;
                                    uDatos.Sala.Cambiar(frmSeleccionButaca.Localidades[i]);
                                end;
                            end;
                            // Guardamos el estado de todo para la fecha indicada
                            uDatos.Guardar(frmFecha.Fecha);
                            ShowMessage('Operación realizada con éxito');
                        end;
                    end;
                finally
                    frmSeleccionButaca.Free;
                end;
            end;
        end;
    finally
        frmFecha.Free;
    end;
end;

procedure TfrmPrincipal.btnLEsperaClick(Sender: TObject);
var
    frmFecha : TFrmFecha;
    frmVerListaEspera : TfrmVerListaEspera;
begin
    try
        frmFecha := TfrmFecha.Create(Self);
        try
            frmFecha.ShowModal;
            if frmFecha.FechaMarcada then
            begin
                uDatos.Cargar(frmFecha.Fecha);
                frmVerListaEspera := TfrmVerListaEspera.Create(Self);
                try
                    frmVerListaEspera.ShowModal;
                finally
                    frmVerListaEspera.Free;
                end;
            end;
        finally
            frmFecha.Free;
        end;
    except
    end;
end;

procedure TfrmPrincipal.btnLEsperaMouseEnter(Sender: TObject);
begin

end;

procedure TfrmPrincipal.btnLReservasClick(Sender: TObject);
var
    frmFecha : TfrmFecha;
    frmVerListaReservas : TfrmVerListaReservas;
begin
    frmFecha := TFrmFecha.Create(Self);
    try
        frmFecha.ShowModal;
        if frmFecha.FechaMarcada then
        begin
            uDatos.Cargar(frmFecha.Fecha);
            frmVerListaReservas := TFrmVerListaReservas.Create(Self);
            try
                frmVerListaReservas.ShowModal;
            finally
                frmVerListaReservas.Free;
            end;
        end;
    finally
        frmFecha.Free;
    end;
end;

procedure TfrmPrincipal.btnReservaClick(Sender: TObject);
    function HayReservaPrevia (Dni : string): boolean;
    var
        i       : integer;
        Found   : boolean;
    begin
        Found := False;
        i := 0;
        while (not Found) and (i < Reservas.Count) do
        begin
            if TReserva(Reservas.Items[i]).Dni = Dni then
                Found := True
            else
                i := i + 1;
        end;
        result := Found;
    end;

var
    frmFecha : TfrmFecha;
    frmSeleccionButaca : TFrmSeleccionButacas;
    frmDatos : TfrmDatosReserva;
    Reserva  : TReserva;
    i       : integer;
begin
    // Creamos la ventana de fechas
    frmFecha := TFrmFecha.Create(Self);
    try
        // ... en modo reservas
        frmFecha.EsReserva := True;
        // La mostramos
        frmFecha.ShowModal;
        // Si se ha marcado una fecha y se ha pulsado aceptar...
        if frmFecha.FechaMarcada then
        begin
            // Se carga el fichero de datos correspondiente
            uDatos.Cargar(frmFecha.Fecha);
            // Si la sala está completa...
            if uDatos.Sala.EstaCompleto then
                // ... se invoca el proceso de introducción en la lista
                // de espera
                PasarAListaDeEspera(frmFecha.Fecha)
            else
            // Si quedan huecos vacíos
            begin
                // Creamos la ventana de selección de ventana
                frmSeleccionButaca := TFrmSeleccionButacas.Create(Self);
                // La cargamos en modo reserva
                frmSeleccionButaca.Modo := ModoReserva;
                try
                    // Mostramos la pantalla
                    frmSeleccionButaca.ShowModal;
                    // Si se ha aceptado y se ha seleccionado alguna butaca
                    if (frmSeleccionButaca.Aceptado) and (frmSeleccionButaca.NumDeMarcadas > 0) then
                    begin
                        // Creamos la ventana de introducción de datos de reservas
                        frmDatos := TfrmDatosReserva.Create(Self);
                        try
                            // Se muestra la ventana de petición de datos
                            frmDatos.ShowModal;
                            // Si se ha introducido datos...
                            if frmDatos.DatosIntroducidos then
                            begin
                                // Comprobamos que no se ha realizado una reserva anterior
                                // con el mismo DNI para esa fecha
                                if HayReservaPrevia(frmDatos.DNI) then
                                    ShowMessage('No se puede realizar más de una reserva por persona')
                                else
                                // En caso contrario...
                                begin
                                    // Mostramos la pantalla de petición de pago
                                    if PedirPago(frmSeleccionButaca.GastoTotal) = True then
                                    begin
                                        // Si paga, creamos una reserva
                                        Reserva := TReserva.Create;
                                        // Rellenamos los campos
                                        Reserva.Nombre := frmDatos.Nombre;
                                        Reserva.Dni := frmDatos.Dni;
                                        Reserva.Telefono := frmDatos.Telefono;
                                        Reserva.Email := frmDatos.Email;
                                        // Para cada una de los huecos de las localidades
                                        // en el formulario de selección
                                        for i:=1 to 4 do
                                        begin
                                            // Si está marcada
                                            if frmSeleccionButaca.Marcadas[i] then
                                            begin
                                                //... añadimos la localidad
                                                frmSeleccionButaca.Localidades[i].Estado := Reservada;
                                                Reserva.AddLocalidad(frmSeleccionButaca.Localidades[i]);
                                                // Cambiamos el estado de la butaca
                                                uDatos.Sala.Cambiar(frmSeleccionButaca.Localidades[i]);
                                            end;
                                        end;
                                        // Añadimos la reserva a la lista de reservas
                                        uDatos.Reservas.Add(Reserva);
                                        // Guardamos los cambios
                                        uDatos.Guardar(frmFecha.Fecha);
                                        ShowMessage('Operación realizada con éxito');
                                    end;
                                end;
                            end;
                        finally
                            frmDatos.Free;
                        end;
                    end;
                finally
                    frmSeleccionButaca.Free;
                end;
            end;
        end;
    finally
        frmFecha.Free;
    end;
end;

procedure TfrmPrincipal.btnSalirClick(Sender: TObject);
begin
    Application.Terminate;
end;

procedure TfrmPrincipal.btnVisualizarEstadoClick(Sender: TObject);
var
    frmFecha : TfrmFecha;
    frmVerEstadoSala : TfrmVerEstadoSala;
begin
    frmFecha := TFrmFecha.Create(Self);
    try
        frmFecha.ShowModal;
        if frmFecha.FechaMarcada then
        begin
            uDatos.Cargar(frmFecha.Fecha);
            frmVerEstadoSala := TfrmVerEstadoSala.Create(Self);
            try
                frmVerEstadoSala.ShowModal;
            finally
                frmVerEstadoSala.Free;
            end;
        end;
    finally
        frmFecha.Free;
    end;
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
    // Establecemos el usuario como no autenticado
    Self.Autenticado := False;
end;

procedure TfrmPrincipal.Image1DblClick(Sender: TObject);
var
    frmCreditos : TFrmCreditos;
begin
    frmCreditos := TFrmCreditos.Create(Self);
    try
        frmCreditos.ShowModal;
    finally
        frmCreditos.Free;
    end;
end;

procedure TfrmPrincipal.lbAdminClick(Sender: TObject);
var
    frmLogin : TFrmLogin;
begin
    if not Autenticado then
    begin
        frmLogin := TFrmLogin.Create(Self);
        try
            frmLogin.ShowModal;
            if frmLogin.ValidPassword then
            begin
                btnAnularCompra.Visible := True;
                btnLEspera.Visible := True;
                btnLReservas.Visible := True;
                btnVisualizarEstado.Visible := True;
                lbAdmin.Caption := 'Cerrar administración';
                Autenticado := True;
            end;
        finally
            frmLogin.Free;
        end;
    end
    else
    begin
        btnAnularCompra.Visible := False;
        btnLEspera.Visible := False;
        btnLReservas.Visible := False;
        btnVisualizarEstado.Visible := False;
        lbAdmin.Caption := 'Acceso administración';
        Autenticado := False;
    end;
end;

procedure TfrmPrincipal.Panel2Click(Sender: TObject);
begin

end;

function TfrmPrincipal.PedirPago(Cantidad: integer): boolean;
var
    frmPagar : TFrmPagar;
    Pagado   : boolean;
begin
    frmPagar := TFrmPagar.Create(Self);
    try
        frmPagar.Cantidad := Cantidad;
        frmPagar.ShowModal;
        Pagado := frmPagar.PagoAceptado;
    finally
        frmPagar.Free;
    end;
    result := Pagado;
end;

procedure TfrmPrincipal.ProcesarListaEspera;
var
    SalaLlena, FinDeLaLista : boolean;
    i, j : integer;
    Localidad: TLocalidad;
    Espera : TEspera;
begin
    i := 0;
    SalaLlena := Sala.EstaCompleto;
    FinDeLaLista := (i = Esperas.Count);
    while (not SalaLlena) and (not FinDeLaLista) do
    begin
        Espera := TEspera(Esperas.Items[i]);
        if Espera.Asignada = False then
        begin
            if (Sala.NumeroLibres(Espera.TipoLocalidad) >= Espera.Numero) then
            begin
                for j:=1 to Espera.Numero do
                begin
                    Localidad := Sala.ObtenerLibre(Espera.TipoLocalidad);
                    Localidad.Estado := Comprada;
                    Sala.Cambiar(Localidad);
                    Espera.Asignada := True;
                    Espera.LocalidadesAsignadas := Espera.LocalidadesAsignadas + uFuncionesComunes.LocalidadToString(Localidad);
                end;
                Esperas.Items[i] := Espera;
            end;
        end;
        i := i + 1;
        FinDeLaLista := (i = Esperas.Count);
        SalaLlena := Sala.EstaCompleto;
    end;
end;

procedure TfrmPrincipal.PasarAListaDeEspera (Fecha: TDateTime);
var
    botonsel : integer;
    frmDatosEspera :TfrmDatosEspera;
    Espera : TEspera;
begin
    botonsel := MessageDlg('La sala se encuentra completa, ¿desea pasar a la lista de espera?', mtConfirmation, [mbYes,mbNo], 0);
    if (botonsel = mrYes) then
    begin
        frmDatosEspera := TfrmDatosEspera.Create(Self);
        try
            frmDatosEspera.ShowModal;
            if frmDatosEspera.DatosIntroducidos then
            begin
                Espera := TEspera.Create;
                Espera.Nombre := frmDatosEspera.Nombre;
                Espera.Telefono:= frmDatosEspera.Telefono;
                Espera.TipoLocalidad:= frmDatosEspera.Tipo;
                Espera.Numero:= frmDatosEspera.Cantidad;
                Espera.Email:= frmDatosEspera.Email;
                Espera.Asignada := False;
                Espera.LocalidadesAsignadas := '';
                Esperas.Add(Espera);
                uDatos.Guardar(Fecha);
            end;
        finally
            frmDatosEspera.Free;
        end;
    end;
end;

initialization
  {$I principalfrm.lrs}

end.

