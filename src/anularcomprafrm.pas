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
      Label1: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      seFila: TSpinEdit;
      seNumero: TSpinEdit;
      procedure Button1Click(Sender: TObject);
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
        Localidad.Estado := Libre;
        LocalidadAnulada := True;
        ShowMessage ('Localidad anulada');
        Self.Close;
    end
    else
        ShowMessage ('Localidad no encontrada');
end;

initialization
  {$I anularcomprafrm.lrs}

end.

