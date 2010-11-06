unit PrincipalFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, LoginFrm, FechaFrm, SeleccionButacaFrm, uDatos,
  CSala, AnularReservaFrm, DatosReservaFrm, CEstadoLocalidad, CReserva,
  AnularCompraFrm, VerListaEsperaFrm, DatosEspera, CEspera;

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
      GroupBox1: TGroupBox;
      Label1: TLabel;
      Label2: TLabel;
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
      procedure btnReservaClick(Sender: TObject);
      procedure btnSalirClick(Sender: TObject);
      procedure Button1Click(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure lbAdminClick(Sender: TObject);
  private
    { private declarations }
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
                    uDatos.Guardar(frmFecha.Fecha);
                end;
                uDatos.LiberarDatos;
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
                uDatos.Guardar(frmFecha.Fecha);
            end;
            uDatos.LiberarDatos;
      end;
  finally
         frmFecha.Free;
  end;
end;

procedure TfrmPrincipal.btnCompraClick(Sender: TObject);
var
    frmDatosEspera : TfrmDatosEspera;
    frmFecha : TfrmFecha;
    frmSeleccionButaca : TFrmSeleccionButacas;
    frmDatos : TfrmDatosReserva;
    Reserva : TReserva;
    i       : integer;
    botonsel : Integer;
    Espera: TEspera;
begin
    frmFecha := TFrmFecha.Create(Self);
    try
        frmFecha.EsReserva := False;
        frmFecha.ShowModal;
        if frmFecha.FechaMarcada then
        begin
            uDatos.Cargar(frmFecha.Fecha);
            if uDatos.Sala.EstaCompleto then
            begin
                botonsel := MessageDlg('La sala se encuentra completa, ¿desea pasar a la lista de espera?', mtConfirmation, [mbYes,mbNo], 0);
            	if (botonsel = mrYes) then
            	begin
                    frmDatosEspera := TfrmDatosEspera.Create(Self);
                    frmDatosEspera.ShowModal;
                    Espera := TEspera.Create;
                    Espera.Nombre := frmDatosEspera.Nombre;
                    Espera.Telefono:= frmDatosEspera.Telefono;
                    Espera.TipoLocalidad:= frmDatosEspera.Tipo;
                    Espera.Numero:= frmDatosEspera.Cantidad;
                    Espera.Email:= frmDatosEspera.Email;
                    Esperas.Add(Espera);
                    uDatos.Guardar(frmFecha.Fecha);
                end
                else
                    Self.Close;
            end
            else
            begin
                frmSeleccionButaca := TFrmSeleccionButacas.Create(Self);
                try
                    frmSeleccionButaca.ShowModal;
                    if frmSeleccionButaca.NumDeMarcadas > 0 then
                    begin
                        for i:=1 to 4 do
                        begin
                            if frmSeleccionButaca.Marcadas[i] then
                            begin
                                frmSeleccionButaca.Localidades[i].Estado := Comprada;
                                uDatos.Sala.Cambiar(frmSeleccionButaca.Localidades[i]);
                            end;
                        end;
                        uDatos.Guardar(frmFecha.Fecha);
                        ShowMessage('Operación realizada con éxito');
                    end;
                finally
                    frmSeleccionButaca.Free;
                end;
            uDatos.LiberarDatos;
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
        uDatos.LiberarDatos;
    except
    end;
end;

procedure TfrmPrincipal.btnReservaClick(Sender: TObject);
var
    frmFecha : TfrmFecha;
    frmSeleccionButaca : TFrmSeleccionButacas;
    frmDatos : TfrmDatosReserva;
    Reserva  : TReserva;
    i       : integer;
    frmDatosEspera : TfrmDatosEspera;
    botonsel : Integer;
    Espera : TEspera;
begin
    frmFecha := TFrmFecha.Create(Self);
    try
        frmFecha.EsReserva := True;
        frmFecha.ShowModal;
        if frmFecha.FechaMarcada then
        begin
            uDatos.Cargar(frmFecha.Fecha);
            if uDatos.Sala.EstaCompleto then
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
                            Esperas.Add(Espera);
                            uDatos.Guardar(frmFecha.Fecha);
                        end;
                    finally
                        frmDatosEspera.Free;
                    end;
                end;
            end
            else
            begin
            frmSeleccionButaca := TFrmSeleccionButacas.Create(Self);
            try
                frmSeleccionButaca.ShowModal;
                if frmSeleccionButaca.NumDeMarcadas > 0 then
                begin
                    frmDatos := TfrmDatosReserva.Create(Self);
                    try
                        frmDatos.ShowModal;
                        if frmDatos.DatosIntroducidos then
                        begin
                            Reserva := TReserva.Create;
                            Reserva.Nombre := frmDatos.Nombre;
                            Reserva.Dni := frmDatos.Dni;
                            Reserva.Telefono := frmDatos.Telefono;
                            Reserva.Email := frmDatos.Email;
                            for i:= 1 to 4 do
                            begin
                                if frmSeleccionButaca.Marcadas[i] then
                                begin
                                    frmSeleccionButaca.Localidades[i].Estado := Reservada;
                                    Reserva.AddLocalidad(frmSeleccionButaca.Localidades[i]);
                                    uDatos.Sala.Cambiar(frmSeleccionButaca.Localidades[i]);
                                end;
                            end;
                            uDatos.Reservas.Add(Reserva);
                            uDatos.Guardar(frmFecha.Fecha);
                            uDatos.LogearReservas;
                            ShowMessage('Operación realizada con éxito');
                        end;
                    finally
                        frmDatos.Free;
                    end;
                end;
            finally
                frmSeleccionButaca.Free;
            end;
            end;
            //TODO: Liberar memoria
            //uDatos.LiberarDatos;
        end
        else
            // TODO: Adapta esto
            ShowMessage ('No hay fecha. Cancelar proceso');
    finally
        frmFecha.Free;
    end;
end;

procedure TfrmPrincipal.btnSalirClick(Sender: TObject);
begin
    Application.Terminate;
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
    Self.Autenticado := False;
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
        btnVisualizarEstado.Visible := False;
        lbAdmin.Caption := 'Acceso administración';
        Autenticado := False;
    end;
end;

initialization
  {$I principalfrm.lrs}

end.

