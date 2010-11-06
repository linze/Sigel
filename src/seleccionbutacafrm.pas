unit SeleccionButacaFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, CLocalidad, CTipoLocalidad, uDatos, CSala;

type

  TColorButaca = (Libre, Ocupada, Seleccionada);
  TModoSeleccion = (Reserva, Compra);

  { TfrmSeleccionButacas }

  TfrmSeleccionButacas = class(TForm)
      Bevel1: TBevel;
      Bevel2: TBevel;
      Bevel3: TBevel;
      Bevel4: TBevel;
      Bevel5: TBevel;
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
      btnCancelar: TButton;
      GroupBox2: TGroupBox;
      Image1: TImage;
      Image2: TImage;
      Image3: TImage;
      ilButacas: TImageList;
      ilPalco: TImageList;
      Label10: TLabel;
      Label4: TLabel;
      Label5: TLabel;
      Label9: TLabel;
      palco1: TImage;
      palco2: TImage;
      palco3: TImage;
      palco4: TImage;
      Panel2: TPanel;
      pplanta11: TImage;
      btnAceptar: TButton;
      GroupBox1: TGroupBox;
      butaca11: TImage;
      Label1: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      lbImportePatio: TLabel;
      lbImportePPlanta: TLabel;
      lbImportePalco: TLabel;
      Label7: TLabel;
      Label8: TLabel;
      Panel1: TPanel;
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
      procedure btnAceptarClick(Sender: TObject);
      procedure btnCancelarClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure OnClickButaca(Sender :TObject);
      function NumDeMarcadas: integer;
  private
    procedure CambiarSegunEstado (var Imagen : TImage; Localidad: TLocalidad);
    procedure CargarEstado;
    procedure ChangeColor(var Imagen: TImage; ColorButaca :TColorButaca);
    function ObtenerTipoByHint (Imagen : TImage): TTipoLocalidad;
    function ObtenerHuecoVacio: integer;
    function EstaSeleccionada (Tipo: TTipoLocalidad; Fila, Numero: integer): Integer;
    function CalcularPrecio (Tipo: TTipoLocalidad): integer;
  public
    Localidades : array [1..4] of TLocalidad;
    Marcadas    : array [1..4] of boolean;
    NumeroVirtual : integer;
    Fecha       : TDateTime;
    Modo        : TModoSeleccion;
    Aceptado    : boolean;

    GastoTotal  : integer;
  end; 

var
  frmSeleccionButacas: TfrmSeleccionButacas;

implementation

{ TfrmSeleccionButacas }

procedure TfrmSeleccionButacas.btnCancelarClick(Sender: TObject);
begin
    Self.Close;
end;

procedure TfrmSeleccionButacas.btnAceptarClick(Sender: TObject);
begin
    if NumDeMarcadas = 0 then
        ShowMessage('Ha de seleccionarse al menos una localidad')
    else
    begin
        Aceptado := True;
        Self.Close;
    end;
end;

procedure TfrmSeleccionButacas.FormCreate(Sender: TObject);
var
    i: integer;
begin
    for i:=1 to 4 do
        Self.Marcadas[i] := False;
    NumeroVirtual := 0;
    Aceptado := False;
    CargarEstado;
end;

function TfrmSeleccionButacas.NumDeMarcadas: integer;
var
    i, count : integer;
begin
    count := 0;
    for i:=1 to 4 do
    begin
        if Self.Marcadas[i] = true then
            count := count + 1;
    end;
    Result := count;
end;

procedure TfrmSeleccionButacas.CambiarSegunEstado (var Imagen : TImage; Localidad: TLocalidad);
begin
    if Localidad.EstaOcupado then
    begin
        ChangeColor(Imagen, Ocupada)
    end
    else
    begin
        ChangeColor(Imagen, Libre);
    end;
end;

procedure TfrmSeleccionButacas.CargarEstado;
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

procedure TfrmSeleccionButacas.ChangeColor(var Imagen: TImage; ColorButaca :TColorButaca);
var
    ImagenLista : TBitmap;
    Tipo : TTipoLocalidad;
begin
    try
        ImagenLista := TBitmap.Create;
        Tipo := ObtenerTipoByHint(Imagen);
        case ColorButaca of
            Libre:
                begin
                    if Tipo <> Palco then
                        ilButacas.GetBitmap(0, ImagenLista)
                    else
                        ilPalco.GetBitmap(0, ImagenLista);
                end;
            Ocupada:
                begin
                    if Tipo <> Palco then
                        ilButacas.GetBitmap(2, ImagenLista)
                    else
                        ilPalco.GetBitmap(2, ImagenLista);
                end;
            Seleccionada:
                begin
                    if Tipo <> Palco then
                        ilButacas.GetBitmap(3, ImagenLista)
                    else
                        ilPalco.GetBitmap(3, ImagenLista);
                end;
        end;
        Imagen.Picture.Bitmap := ImagenLista;
    except
        ShowMessage ('Error al cambiar la localidad de color');
    end;
end;

// Devuelve -1 si no se encuentra seleccionada, y el índice si se encuentra
function TfrmSeleccionButacas.EstaSeleccionada (Tipo: TTipoLocalidad;
                                                Fila, Numero: integer): integer;
var
    i       : integer;
    found   : boolean;
begin
    try
        i := 0;
        Found := false;
        while not Found and (i <= 4) do
        begin
            if Marcadas[i] then
                if (Localidades[i].Tipo = Tipo) and (Localidades[i].Numero = Numero) then
                begin
                    if Tipo = Palco then
                    begin
                        found := true;
                    end
                    else
                    begin
                        if Localidades[i].Fila = Fila then
                            found := true;
                    end;
                end;
            if not Found then i := i + 1;
        end;
        if found then
            result := i
        else
            result := -1;
    except
        ShowMessage('Error al encontrar el estado de la localidad');
    end;
end;

function TfrmSeleccionButacas.CalcularPrecio(Tipo: TTipoLocalidad): integer;
begin
    if Self.Modo = Reserva then
        case Tipo of
        Patio: Result := 5;
        PrimeraPlanta: Result := 2;
        Palco: Result := 15;
        end
    else
        case Tipo of
        Patio: Result := 50;
        PrimeraPlanta: Result := 20;
        Palco: Result := 150;
        end;
end;

function TfrmSeleccionButacas.ObtenerHuecoVacio: integer;
var
    Found : boolean;
    i     : integer;
begin
    Found := False;
    i := 1;
    while (not Found) and (i <= 4) do
    begin
        if Self.Marcadas[i] = True then
            i := i + 1
        else
            Found := True;
    end;
    if Found then
        result := i
    else
        result := -1;
end;

function TfrmSeleccionButacas.ObtenerTipoByHint (Imagen : TImage): TTipoLocalidad;
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

procedure TfrmSeleccionButacas.OnClickButaca(Sender :TObject);
var
    Tipo       : TTipoLocalidad;
    Fila       : Integer;
    Numero     : Integer;
    Localidad  : TLocalidad;
    hueco      : integer;
begin
    Tipo := ObtenerTipoByHint (Sender as TImage);
    if Tipo = Palco then
    begin
        Numero := StrToInt((Sender as TImage).Hint[2]);
        Fila := Numero;
    end
    else
    begin
        Fila := StrToInt((Sender as TImage).Hint[2]);
        Numero := StrToInt((Sender as TImage).Hint[3]);
    end;

    // Obtenemos el estado actual de la localidad
    Localidad := Sala.Buscar(Tipo, Fila, Numero);
    if not Localidad.EstaOcupado then
    begin
        hueco := EstaSeleccionada(Tipo, Fila, Numero);
        if hueco <> -1 then
        begin
            Self.Marcadas[hueco] := False;
            Self.ChangeColor(TImage(Sender), Libre);
            case Tipo of
            Patio : Self.NumeroVirtual := Self.NumeroVirtual - 1;
            PrimeraPlanta : Self.NumeroVirtual := Self.NumeroVirtual - 1;
            Palco : Self.NumeroVirtual := Self.NumeroVirtual - 4;
            end;
        end
        else
        begin
            hueco := ObtenerHuecoVacio;
            if hueco = -1 then
                ShowMessage('No se puede seleccionar más de cuatro localidades o un palco.')
            else
            begin
                if (NumeroVirtual >= 4) or ((Tipo = palco) and (NumDeMarcadas > 0)) then
                    ShowMessage ('No se puede seleccionar más de cuatro localidades o un palco')
                else
                begin
                    Self.Marcadas[hueco] := True;
                    Self.Localidades[hueco] := Localidad;
                    if Localidad.Tipo = Palco then
                        NumeroVirtual := 4
                    else
                        NumeroVirtual := NumeroVirtual + 1;
                    Self.ChangeColor(TImage(Sender), Seleccionada);
                end;
            end;
        end;
    end;
end;

initialization
  {$I seleccionbutacafrm.lrs}

end.

