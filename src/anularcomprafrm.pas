unit AnularCompraFrm; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  Spin, StdCtrls, uDatos, CLocalidad, CTipoLocalidad, CEstadoLocalidad;

type

  { TfrmAnularCompra }

  TfrmAnularCompra = class(TForm)
      Button1: TButton;
      Button2: TButton;
      cbTipo: TComboBox;
      lbFila: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      seFila: TSpinEdit;
      seNumero: TSpinEdit;
      procedure Button1Click(Sender: TObject);
      procedure Button2Click(Sender: TObject);
      procedure cbTipoChange(Sender: TObject);
  private
    { private declarations }
  public
    LocalidadAnulada : boolean;
  end; 

var
  frmAnularCompra: TfrmAnularCompra;

implementation

{ TfrmAnularCompra }

procedure TfrmAnularCompra.Button1Click(Sender: TObject);
var
    Localidad : TLocalidad;
    libresPatio : integer;
    libresPrimeraPlanta : integer;
    libresPalco : integer;
    libresTotal : integer;
begin
    LocalidadAnulada := False;
    if cbTipo.Text = 'Patio' then
        Localidad := Sala.Buscar(Patio, seFila.Value, seNumero.Value)
    else if cbTipo.Text = 'Primera Planta' then
        Localidad := Sala.Buscar(PrimeraPlanta, seFila.Value, seNumero.Value)
    else if cbTipo.Text = 'Palco' then
        Localidad := Sala.Buscar(Palco, seNumero.Value, seNumero.Value);

    if Localidad <> nil then
    begin
        if not Sala.LocalidadValida(Localidad) then
            ShowMessage('Localidad no válida')
        else
        begin
            if Localidad.Estado = Libre then
                ShowMessage('La localidad seleccionada ya está libre')
            else if Localidad.Estado = Reservada then
                ShowMessage('Esta localidad se encuentra reservada')
            else
            begin

            libresPatio := Sala.NumeroLibres(Patio);
            libresPrimeraPlanta := Sala.NumeroLibres(PrimeraPlanta);
            libresPalco := Sala.NumeroLibres(Palco);
            libresTotal := libresPatio + libresPrimeraPlanta + libresPalco;
            Localidad.Estado := Libre;
            LocalidadAnulada := True;
            // TODO: si existe lista de espera...
            if libresTotal > 0 then
               if libresPatio > 0 then
                  for i := 0 to Esperas.Count -1 do
                  begin
                  if (TEspera(uDatos.Esperas.Items[i].TipoLocalidad) = Patio) or TEspera(uDatos.Esperas.Items[i].TipoLocalidad) = Indiferente) then
                  begin
                       if Esperas.Items[i].Numero < libresPatio + 1 then
                       begin
                            Esperas.Items[i].Asignada := True;

                       end;
                  end;
               if libresPrimeraPlanta > 0 then

               if libresPatio > 0 then

                  end;


            ShowMessage ('Localidad anulada');
            Self.Close;
            end;
        end;
    end
    else
        ShowMessage ('Localidad no encontrada');
end;

procedure TfrmAnularCompra.Button2Click(Sender: TObject);
begin
    Self.Close;
end;

procedure TfrmAnularCompra.cbTipoChange(Sender: TObject);
begin
    if (Sender as TComboBox).Text = 'Palco' then
    begin
        lbFila.Visible := False;
        seFila.Visible := False;
    end
    else
    begin
        lbFila.Visible := True;
        seFila.Visible := True;
    end;
end;

initialization
  {$I anularcomprafrm.lrs}

end.

