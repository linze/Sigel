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
begin
    LocalidadAnulada := False;
    if cbTipo.Text <> '' then
    begin
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
                    Localidad.Estado := Libre;
                    LocalidadAnulada := True;
                    ShowMessage ('Localidad anulada');
                    Self.Close;
                end;
            end;
        end
        else
            ShowMessage ('Localidad no encontrada');
    end
    else
        ShowMessage('Es necesario indicar el tipo de localidad');
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

