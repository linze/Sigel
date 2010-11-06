unit uDatos;

{$mode objfpc}{$H+}

interface
    uses
        CSala, CListaObjetos, SysUtils, DateUtils, CReserva;

    procedure Cargar(Fecha : TDateTime);
    procedure Guardar(Fecha : TDateTime);
    procedure LiberarDatos;
    procedure CrearVacio;
    procedure LogearReservas;

    var
        Sala     : TSala;
        Reservas : TListaObjetos;
        Esperas  : TListaObjetos;

implementation

procedure Cargar(Fecha : TDateTime);
var
    ListaSala     : TListaObjetos;
    NombreFichero : String;
begin
    NombreFichero := DateToStr(Fecha);

    if FileExists(NombreFichero + '.sala') then
    begin
        ListaSala := TListaObjetos.Create;
        ListaSala.LoadFromFile(NombreFichero + '.sala');
        Sala := TSala(ListaSala.Items[ListaSala.Count - 1]);

        Reservas := TListaObjetos.Create;
        Reservas.LoadFromFile(NombreFichero + '.reservas');

        Esperas := TListaObjetos.Create;
        Esperas.LoadFromFile(NombreFichero + '.esperas');
    end
    else
        CrearVacio;
end;

procedure Guardar(Fecha : TDateTime);
var
    ListaSala     : TListaObjetos;
    NombreFichero : String;
begin
    NombreFichero := DateToStr(Fecha);

    ListaSala := TListaObjetos.Create;
    ListaSala.Add(Sala);
    ListaSala.SaveToFile(NombreFichero + '.sala');

    Reservas.SaveToFile(NombreFichero + '.reservas');

    Esperas.SaveToFile(NombreFichero + '.esperas');
end;

procedure LiberarDatos;
begin
    Sala.Free;
    Reservas.Free;
    Esperas.Free;
end;

procedure CrearVacio;
begin
    Sala  := TSala.Create;
    Reservas := TListaObjetos.Create;
    Esperas := TListaObjetos.Create;
end;

procedure LogearReservas;
var
    i: integer;
begin
    for i:=0 to Reservas.Count-1 do
        TReserva(Reservas.Items[i]).LogEnFichero;
end;

end.

