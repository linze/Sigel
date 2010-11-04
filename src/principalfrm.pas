unit PrincipalFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, LoginFrm, FechaFrm, SeleccionButacaFrm, uDatos,
  CSala, AnularReservaFrm, DatosReservaFrm, CEstadoLocalidad, CReserva;

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
      procedure btnAnularReservaClick(Sender: TObject);
      procedure btnCompraClick(Sender: TObject);
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
           frmAnular := TfrmAnularReserva.Create(Self);
           frmAnular.ShowModal;
      end;
  finally
         frmFecha.Free;
  end;
end;

procedure TfrmPrincipal.btnCompraClick(Sender: TObject);
var
    frmFecha : TfrmFecha;
    frmSeleccionButaca : TFrmSeleccionButacas;
    frmDatos : TfrmDatosReserva;
    Reserva : TReserva;
    i       : integer;
begin
    frmFecha := TFrmFecha.Create(Self);
    try
        frmFecha.EsReserva := True;
        frmFecha.ShowModal;
        if frmFecha.FechaMarcada then
        begin
            uDatos.Cargar(frmFecha.Fecha);
            frmSeleccionButaca := TFrmSeleccionButacas.Create(Self);
            try
                frmSeleccionButaca.ShowModal;
                if frmSeleccionButaca.NumDeMarcadas > 0 then
                begin
                    begin
                        for i:=1 to 4 do
                        begin
                            if frmSeleccionButaca.Marcadas[i] then
                            begin
                                frmSeleccionButaca.Localidades[i].Estado := Comprada;
                                uDatos.Sala.Cambiar(frmSeleccionButaca.Localidades[1]);
                            end;
                        end;
                        uDatos.Guardar(frmFecha.Fecha);
                        ShowMessage('Operación realizada con éxito');
                    end;
                end;
            finally
                frmSeleccionButaca.Free;
            end;
            uDatos.LiberarDatos;
        end
        else
            // TODO: Adapta esto
            ShowMessage ('No hay fecha. Cancelar proceso');
    finally
        frmFecha.Free;
    end;
end;

procedure TfrmPrincipal.btnReservaClick(Sender: TObject);
var
    frmFecha : TfrmFecha;
    frmSeleccionButaca : TFrmSeleccionButacas;
    frmDatos : TfrmDatosReserva;
    Reserva  : TReserva;
    i       : integer;
begin
    frmFecha := TFrmFecha.Create(Self);
    try
        frmFecha.EsReserva := True;
        frmFecha.ShowModal;
        if frmFecha.FechaMarcada then
        begin
            uDatos.Cargar(frmFecha.Fecha);
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
                            for i:= 1 to 4 do
                            begin
                                if frmSeleccionButaca.Marcadas[i] then
                                begin
                                    frmSeleccionButaca.Localidades[i].Estado := Reservada;
                                    Reserva := TReserva.Create;
                                    Reserva.Nombre := frmDatos.Nombre;
                                    Reserva.Dni := frmDatos.Dni;
                                    Reserva.Telefono := frmDatos.Telefono;
                                    Reserva.Email := frmDatos.Email;
                                    Reserva.AddLocalidad(frmSeleccionButaca.Localidades[i]);
                                    uDatos.Reservas.Add(Reserva);
                                    uDatos.Sala.Cambiar(frmSeleccionButaca.Localidades[1]);
                                end;
                            end;
                            uDatos.Guardar(frmFecha.Fecha);
                            ShowMessage('Operación realizada con éxito');
                        end;
                    finally
                        frmDatos.Free;
                    end;
                end;
            finally
                frmSeleccionButaca.Free;
            end;
            uDatos.LiberarDatos;
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

