unit CListaReservas;

{$mode objfpc}{$H+}

interface

    uses
        CReserva, CEstadoLocalidad, Classes, CObjectList, SysUtils, DateUtils;

    type
        {TListaReservas}
        TListaReservas = class (TObjectList)
        private
            { Atributos }
            FFecha : TDateTime;

        public
            { Constructores y destructores }
            constructor Create();

            { Propiedades }
            property Fecha: TDateTime read FFecha write FFecha;

            { Operaciones propias de la clase }
            function BuscarReserva(Telefono : string; Nombre : String):TReserva;
            procedure AnularReserva(Telefono : string; Nombre : String);
            function ExisteReserva(Telefono : string; Nombre : String):boolean;

            { Para guardar los que no sean antiguos }
            procedure AddReaded(Objeto: TPersistent); override;

            { Para guardar la fecha }
            procedure LeerDatos (Lector : TReader); override;
            procedure EscribirDatos (Escritor: TWriter); override;
        end;

implementation

{Constructor}

constructor TListaReservas.Create();
begin

end;
 { Operaciones propias de la clase }

{BuscarReserva}
// NOTICE: Al devolver una clase se devuelve un puntero. En caso de que tras
// modificar una reserva buscada de esta manera no se modificase el original,
// ojito a esto.
function TListaReservas.BuscarReserva(Telefono : string; Nombre : String):TReserva;
var
    encontrado  : boolean;
    i           : integer;
begin
    Encontrado := false;
    i := 0;
    while not (Encontrado) and (i < Count - 1) do
    begin
        if (TReserva(Items[i]).Telefono = Telefono) and
            (TReserva(Items[i]).Nombre = Nombre) then
            Encontrado := True
        else
            i := i + 1;
    end;

    if Encontrado then
        Result := TReserva(Items[i])
    else
        Result := nil;
end;

{AnularReserva}
// TODO: Chequear método.
// No se si este metodo está correcto.
// No entiendo bien la implementacion de TReserva
// Creo que este método debería implementarse en TReserva
procedure TListaReservas.AnularReserva(Telefono : string; Nombre : String);
var
    index : 1..4;
    i :integer;
begin
    if Self.ExisteReserva(Telefono,Nombre) then
    begin
        index := BuscarReserva(Telefono,Nombre).Cantidad;
        for i := 1 to index do
        begin
              BuscarReserva(Telefono,Nombre).GetLocalidad(index).Estado := Libre;
        end;
    end;
end;

{ExisteReserva}
function TListaReservas.ExisteReserva(Telefono : string; Nombre : String):boolean;
begin
    if (BuscarReserva(Telefono,Nombre) <> nil) then
        ExisteReserva := true
    else
        ExisteReserva := false;
end;

procedure TListaReservas.AddReaded(Objeto: TPersistent);
begin
    // NOTICE: Añadimos únicamente los días actuales o futuros
    if CompareDate((Objeto as TReserva).Fecha, DateOf(Now)) <> -1 then
        Self.Add(Objeto);
end;

procedure TListaReservas.LeerDatos(Lector: TReader);
begin
    Self.FFecha := Lector.ReadDate;
end;

procedure TListaReservas.EscribirDatos(Escritor: TWriter);
begin
    Escritor.WriteDate(Self.FFecha);
end;
end.

