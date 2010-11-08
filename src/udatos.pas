unit uDatos;

{$mode objfpc}{$H+}

interface
    uses
        CSala, CListaObjetos, SysUtils, DateUtils, CReserva;

    // Carga los datos de la fecha dada
    procedure Cargar(Fecha : TDateTime);
    // Guarda los datos en la fecha dada
    procedure Guardar(Fecha : TDateTime);

    // Construye cada uno de los contenedores usados
    // (Sala, Reservas y Esperas)
    procedure CrearVacio;

    // Para debuggear: Escribe en un fichero el contenido
    // de la lista de reservas
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
    // Obtenemos la fecha en formato string
    NombreFichero := DateToStr(Fecha);

    // Comprobamos si existe la sala
    // (no debe de darse el caso en el cual exista el fichero de
    // sala y no ninguno de los demás, ya que se construyen los tres
    // a la vez)
    // Si existe...
    if FileExists(NombreFichero + '.sala') then
    begin
        // Creamos una lista auxiliar
        ListaSala := TListaObjetos.Create;
        // Cargamos la lista dese un fichero con la fecha.sala
        ListaSala.LoadFromFile(NombreFichero + '.sala');
        // Obtenemos el primer y único elemento de la lista. El TSala.
        Sala := TSala(ListaSala.Items[ListaSala.Count - 1]);

        // Cargamos las reservas desde el fichero fecha.reservas
        Reservas := TListaObjetos.Create;
        Reservas.LoadFromFile(NombreFichero + '.reservas');

        // Cargamos las esperas desde el fichero fecha.reservas
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
    // Obtenemos el string correspondiente a la fecha
    NombreFichero := DateToStr(Fecha);

    // Crea una lista auxiliar para guardar la sala
    ListaSala := TListaObjetos.Create;
    // Se introduce únicamente la sala
    ListaSala.Add(Sala);
    // Se escribe el fichero fecha.sala
    ListaSala.SaveToFile(NombreFichero + '.sala');

    // Se escribe el fichero fecha.reservas
    Reservas.SaveToFile(NombreFichero + '.reservas');

    // Se escribe el fichero fecha.esperas
    Esperas.SaveToFile(NombreFichero + '.esperas');
end;

procedure CrearVacio;
begin
    // Construimos las tres salas
    Sala  := TSala.Create;
    Reservas := TListaObjetos.Create;
    Esperas := TListaObjetos.Create;
end;

// Procedimiento para depurar el software
procedure LogearReservas;
var
    i: integer;
begin
    for i:=0 to Reservas.Count-1 do
        TReserva(Reservas.Items[i]).LogEnFichero;
end;

end.

