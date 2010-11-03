unit PrincipalFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Spin, LoginFrm, FechaFrm, SeleccionButacaFrm, uDatos,
  CSala;

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
      Button1: TButton;
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

procedure TfrmPrincipal.btnCompraClick(Sender: TObject);
var
    frmFecha : TfrmFecha;
begin
    frmFecha := TFrmFecha.Create(Self);
    try
        frmFecha.EsReserva := False;
        frmFecha.ShowModal;
        if frmFecha.FechaMarcada then
        begin
            // TODO: Adapta esto. Seguir proceso
            ShowMessage ('Fecha marcada correctamente');
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
begin
    frmFecha := TFrmFecha.Create(Self);
    try
        frmFecha.EsReserva := True;
        frmFecha.ShowModal;
        if frmFecha.FechaMarcada then
        begin
            // TODO: Adapta esto. Seguir proceso
            ShowMessage ('Fecha marcada correctamente');
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
var
    frmSB : TFrmSeleccionButacas;
begin
    frmSB := TFrmSeleccionButacas.Create(Self);
    frmSeleccionButacas.ShowModal;
    frmSB.Free;
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

