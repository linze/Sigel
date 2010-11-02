unit CListaReservas;

{$mode objfpc}{$H+}

interface

    uses
        CReserva, CEstadoLocalidad, Classes, SysUtils;

    type
        {TListaReservas}

        // TODO: Implementar como clase hija de TFileObjectList
        TListaReservas = class (TList)
        private
            { Atributos }
            FFecha : TDateTime;

        public
            { Constructores y destructores }
            constructor Create();

            { Propiedades }
            property Fecha: TDateTime read FFecha write FFecha;

            { Operaciones propias de la clase }
            function BuscarReserva(Telefono : integer; Nombre : String):TReserva;
            procedure AnularReserva(Telefono : integer; Nombre : String);
            function ExisteReserva(Telefono : integer; Nombre : String):boolean;


        end;

implementation

{Constructor}

constructor TListaReservas.Create();
begin

end;
 { Operaciones propias de la clase }

{BuscarReserva}
// TODO: Revisar si este método funciona.
// TODO: He reformateado el código por un begin-end roto. Revisar que mantenga
// coherencia.
function TListaReservas.BuscarReserva(Telefono : integer; Nombre : String):TReserva;
var
    encontrado : boolean;
begin
    encontrado := false;
    // TODO: Implementar
end;

{AnularReserva}
// TODO: Chequear método.
// No se si este metodo está correcto.
// No entiendo bien la implementacion de TReserva
// Creo que este método debería implementarse en TReserva
procedure TListaReservas.AnularReserva(Telefono : integer; Nombre : String);
var
    index : 1..4;
    i :integer;
begin
    if Self.ExisteReserva(Telefono,Nombre) then
    begin
        index := Self.BuscarReserva(Telefono,Nombre).Cantidad;
        for i := 1 to index do
        begin
              Self.BuscarReserva(Telefono,Nombre).GetLocalidad(index).Estado := Libre;
        end;
    end;
end;

{ExisteReserva}
function TListaReservas.ExisteReserva(Telefono : integer; Nombre : String):boolean;
begin
    if (Self.BuscarReserva(Telefono,Nombre) <> NIL) then
        ExisteReserva := true
    else
        ExisteReserva := false;
end;
end.

