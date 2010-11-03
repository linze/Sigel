unit SeleccionButacaFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, CLocalidad, CTipoLocalidad, uDatos;

type

  TColorButaca = (Libre, Ocupada, Seleccionada);

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
      Label6: TLabel;
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
      procedure btnCancelarClick(Sender: TObject);
      procedure OnClickButaca(Sender :TObject);
  private
    procedure ChangeColor(var Imagen: TImage; ColorButaca :TColorButaca);
  public
    // TODO: Hacer TList
    Localidades : array [1..4] of TLocalidad;
    Marcadas    : array [1..4] of boolean;
    Fecha       : TDateTime;
  end; 

var
  frmSeleccionButacas: TfrmSeleccionButacas;

implementation

{ TfrmSeleccionButacas }

procedure TfrmSeleccionButacas.btnCancelarClick(Sender: TObject);
begin
    Self.Close;
end;

procedure TfrmSeleccionButacas.ChangeColor(var Imagen: TImage; ColorButaca :TColorButaca);
var
    ImagenLista : TBitmap;
begin
    ImagenLista := TBitmap.Create;
    case ColorButaca of
        Libre:
            begin
                ilButacas.GetBitmap(0, ImagenLista);
                Imagen.Picture.Bitmap := ImagenLista;
            end;
        Ocupada:
            begin
                ilButacas.GetBitmap(2, ImagenLista);
                Imagen.Picture.Bitmap := ImagenLista;
            end;
        Seleccionada:
            begin
                ilButacas.GetBitmap(3, ImagenLista);
                Imagen.Picture.Bitmap := ImagenLista;
            end;
    end;
end;

procedure TfrmSeleccionButacas.OnClickButaca(Sender :TObject);
    function EstaSeleccionada (Tipo: TTipoLocalidad; Numero, Fila: integer): boolean;
    var
        i       : integer;
        found   : boolean;
    begin
        i := 0;
        Found := false;
        while not Found and (i < 4) do
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
        result := found;
    end;
var
    Tipo       : TTipoLocalidad;
    Fila       : Integer;
    Numero     : Integer;
    TmpStr     : String;
    Localidad  : TLocalidad;
begin
    // Obtenemos del Hint la información de la localidad
    TmpStr := (Sender as TImage).Hint[1];

    // Parseamos la información
    if (TmpStr = 'B') then
        Tipo := Patio
    else if (TmpStr = 'P') then
        Tipo := PrimeraPlanta
    else
        Tipo := Palco;

    Fila := StrToInt((Sender as TImage).Hint[2]);
    if Tipo <> Palco then Numero := StrToInt((Sender as TImage).Hint[3]);

    // Obtenemos el estado actual de la localidad
    Localidad := ListaSalas.BuscarSala(Fecha).Buscar(Tipo, Numero, Fila);
    if not Localidad.EstaOcupado then
    begin
        if EstaSeleccionada(Tipo, Numero, Fila) then
            Self.ChangeColor(TImage(Sender), Libre)
        else
            Self.ChangeColor(TImage(Sender), Seleccionada)
    end;
end;

initialization
  {$I seleccionbutacafrm.lrs}

end.

