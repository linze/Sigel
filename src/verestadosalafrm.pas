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
unit VerEstadoSalaFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, CSala, CEstadoLocalidad, CLocalidad, CTipoLocalidad,
  uDatos;

type

  { TfrmVerEstadoSala }

  TfrmVerEstadoSala = class(TForm)
      Bevel2: TBevel;
      Bevel3: TBevel;
      Bevel4: TBevel;
      Bevel5: TBevel;
      btnCancelar: TButton;
      butaca11: TImage;
      butaca12: TImage;
      butaca13: TImage;
      butaca14: TImage;
      butaca15: TImage;
      butaca16: TImage;
      butaca17: TImage;
      butaca18: TImage;
      butaca21: TImage;
      butaca22: TImage;
      butaca23: TImage;
      butaca24: TImage;
      butaca25: TImage;
      butaca26: TImage;
      butaca27: TImage;
      butaca28: TImage;
      butaca32: TImage;
      butaca33: TImage;
      butaca34: TImage;
      butaca35: TImage;
      butaca36: TImage;
      butaca37: TImage;
      butaca43: TImage;
      butaca44: TImage;
      butaca45: TImage;
      butaca46: TImage;
      GroupBox2: TGroupBox;
      ilButacas: TImageList;
      ilPalco: TImageList;
      Image1: TImage;
      Image2: TImage;
      Image3: TImage;
      Label10: TLabel;
      Label4: TLabel;
      Label5: TLabel;
      Label9: TLabel;
      palco1: TImage;
      palco2: TImage;
      palco3: TImage;
      palco4: TImage;
      Panel1: TPanel;
      Panel2: TPanel;
      pplanta11: TImage;
      pplanta12: TImage;
      pplanta13: TImage;
      pplanta14: TImage;
      pplanta15: TImage;
      pplanta16: TImage;
      pplanta17: TImage;
      pplanta18: TImage;
      pplanta21: TImage;
      pplanta22: TImage;
      pplanta23: TImage;
      pplanta24: TImage;
      pplanta25: TImage;
      pplanta26: TImage;
      pplanta27: TImage;
      pplanta28: TImage;
      procedure btnCancelarClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
  private
    procedure CargarEstado;
    function ObtenerTipoByHint (Imagen: TImage): TTipoLocalidad;
    procedure CambiarSegunEstado (var Imagen: TImage; Localidad: TLocalidad);
  public
    { public declarations }
  end; 

var
  frmVerEstadoSala: TfrmVerEstadoSala;

implementation

procedure TfrmVerEstadoSala.FormCreate(Sender: TObject);
begin
    CargarEstado;
end;

procedure TfrmVerEstadoSala.btnCancelarClick(Sender: TObject);
begin
    Self.Close;
end;

procedure TfrmVerEstadoSala.CargarEstado;
begin
    // Butacas
    CambiarSegunEstado(butaca11, Sala.Buscar(Patio, 1, 1));
    CambiarSegunEstado(butaca12, Sala.Buscar(Patio, 1, 2));
    CambiarSegunEstado(butaca13, Sala.Buscar(Patio, 1, 3));
    CambiarSegunEstado(butaca14, Sala.Buscar(Patio, 1, 4));
    CambiarSegunEstado(butaca15, Sala.Buscar(Patio, 1, 5));
    CambiarSegunEstado(butaca16, Sala.Buscar(Patio, 1, 6));
    CambiarSegunEstado(butaca17, Sala.Buscar(Patio, 1, 7));
    CambiarSegunEstado(butaca18, Sala.Buscar(Patio, 1, 8));
    CambiarSegunEstado(butaca21, Sala.Buscar(Patio, 2, 1));
    CambiarSegunEstado(butaca22, Sala.Buscar(Patio, 2, 2));
    CambiarSegunEstado(butaca23, Sala.Buscar(Patio, 2, 3));
    CambiarSegunEstado(butaca24, Sala.Buscar(Patio, 2, 4));
    CambiarSegunEstado(butaca25, Sala.Buscar(Patio, 2, 5));
    CambiarSegunEstado(butaca26, Sala.Buscar(Patio, 2, 6));
    CambiarSegunEstado(butaca27, Sala.Buscar(Patio, 2, 7));
    CambiarSegunEstado(butaca28, Sala.Buscar(Patio, 2, 8));
    CambiarSegunEstado(butaca32, Sala.Buscar(Patio, 3, 2));
    CambiarSegunEstado(butaca33, Sala.Buscar(Patio, 3, 3));
    CambiarSegunEstado(butaca34, Sala.Buscar(Patio, 3, 4));
    CambiarSegunEstado(butaca35, Sala.Buscar(Patio, 3, 5));
    CambiarSegunEstado(butaca36, Sala.Buscar(Patio, 3, 6));
    CambiarSegunEstado(butaca37, Sala.Buscar(Patio, 3, 7));
    CambiarSegunEstado(butaca43, Sala.Buscar(Patio, 4, 3));
    CambiarSegunEstado(butaca44, Sala.Buscar(Patio, 4, 4));
    CambiarSegunEstado(butaca45, Sala.Buscar(Patio, 4, 5));
    CambiarSegunEstado(butaca46, Sala.Buscar(Patio, 4, 6));

    // Primera planta
    CambiarSegunEstado(pplanta11, Sala.Buscar(PrimeraPlanta, 1, 1));
    CambiarSegunEstado(pplanta12, Sala.Buscar(PrimeraPlanta, 1, 2));
    CambiarSegunEstado(pplanta13, Sala.Buscar(PrimeraPlanta, 1, 3));
    CambiarSegunEstado(pplanta14, Sala.Buscar(PrimeraPlanta, 1, 4));
    CambiarSegunEstado(pplanta15, Sala.Buscar(PrimeraPlanta, 1, 5));
    CambiarSegunEstado(pplanta16, Sala.Buscar(PrimeraPlanta, 1, 6));
    CambiarSegunEstado(pplanta17, Sala.Buscar(PrimeraPlanta, 1, 7));
    CambiarSegunEstado(pplanta18, Sala.Buscar(PrimeraPlanta, 1, 8));
    CambiarSegunEstado(pplanta21, Sala.Buscar(PrimeraPlanta, 2, 1));
    CambiarSegunEstado(pplanta22, Sala.Buscar(PrimeraPlanta, 2, 2));
    CambiarSegunEstado(pplanta23, Sala.Buscar(PrimeraPlanta, 2, 3));
    CambiarSegunEstado(pplanta24, Sala.Buscar(PrimeraPlanta, 2, 4));
    CambiarSegunEstado(pplanta25, Sala.Buscar(PrimeraPlanta, 2, 5));
    CambiarSegunEstado(pplanta26, Sala.Buscar(PrimeraPlanta, 2, 6));
    CambiarSegunEstado(pplanta27, Sala.Buscar(PrimeraPlanta, 2, 7));
    CambiarSegunEstado(pplanta28, Sala.Buscar(PrimeraPlanta, 2, 8));

    CambiarSegunEstado(palco1, Sala.Buscar(Palco, 1, 1));
    CambiarSegunEstado(palco2, Sala.Buscar(Palco, 2, 2));
    CambiarSegunEstado(palco3, Sala.Buscar(Palco, 3, 3));
    CambiarSegunEstado(palco4, Sala.Buscar(Palco, 4, 4));
end;

function TfrmVerEstadoSala.ObtenerTipoByHint(Imagen: TImage): TTipoLocalidad;
var
    TmpStr : String;
    Tipo   : TTipoLocalidad;
begin
    // Obtenemos del Hint la información de la localidad
    TmpStr := Imagen.Hint[1];
    // Parseamos la información
    if (TmpStr = 'B') then
        Tipo := Patio
    else if (TmpStr = 'P') then
        Tipo := PrimeraPlanta
    else
        Tipo := Palco;

    Result := Tipo;
end;

procedure TfrmVerEstadoSala.CambiarSegunEstado(var Imagen: TImage;
    Localidad: TLocalidad);
var
    ImagenLista : TBitmap;
    Tipo : TTipoLocalidad;
begin
    try
        ImagenLista := TBitmap.Create;
        Tipo := ObtenerTipoByHint(Imagen);
        case Localidad.Estado of
            Libre:
                begin
                    if Tipo <> Palco then
                        ilButacas.GetBitmap(0, ImagenLista)
                    else
                        ilPalco.GetBitmap(0, ImagenLista);
                end;
            Reservada:
                begin
                    if Tipo <> Palco then
                        ilButacas.GetBitmap(1, ImagenLista)
                    else
                        ilPalco.GetBitmap(1, ImagenLista);
                end;
            Comprada:
                begin
                    if Tipo <> Palco then
                        ilButacas.GetBitmap(2, ImagenLista)
                    else
                        ilPalco.GetBitmap(2, ImagenLista);
                end;
        end;
        Imagen.Picture.Bitmap := ImagenLista;
    except
        ShowMessage ('Error al cambiar la localidad de color');
    end;
end;

initialization
  {$I verestadosalafrm.lrs}

end.

