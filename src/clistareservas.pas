unit CListaReservas;

{$mode objfpc}{$H+}

interface

    uses
        CFecha, CReserva, CEstadoLocalidad;

    type
        {PTListaReservas}

        PTListaReservas = ^TListaReservas;

        {TListaReservas}

        TListaReservas = class
        private
            { Atributos }

            FFecha : TFecha;
            FReservas : PTReserva;
            FSiguienteLista : PTListaReservas;

        public
            { Constructores y destructores }
            constructor Create();

            { Métodos de asignación de atributos }
            procedure SetFecha(Fecha: TFecha);
            procedure SetSiguiente(ListaReservas : TListaReservas);

            { Métodos de obtención de atributos }
            function GetFecha: TFecha;
            function GetSiguiente: PTListaReservas;

            { Operaciones propias de la clase }
            procedure AddReserva(Reserva : PTReserva);
            function BuscarReserva(Telefono : integer; Nombre : String):TReserva;
            procedure AnularReserva(Telefono : integer; Nombre : String);
            function ExisteReserva(Telefono : integer; Nombre : String):boolean;


        end;

implementation

{Constructor}

constructor TListaReservas.Create();
begin
    Self.FReservas := NIL;
    Self.FSiguienteLista := NIL;
end;

{ Métodos de asignación de atributos }

procedure TListaReservas.SetFecha(Fecha: TFecha);
begin
    Self.FFecha.Dia := Fecha.Dia;
    Self.FFecha.Mes := Fecha.Mes;
end;

procedure TListaReservas.SetSiguiente(ListaReservas : TListaReservas);
begin
    Self.FSiguienteLista^ :=  ListaReservas;
end;

{ Métodos de obtención de atributos }

function TListaReservas.GetFecha: TFecha;
begin
    GetFecha:=Self.FFecha;
end;

function TListaReservas.GetSiguiente: PTListaReservas;
begin
    GetSiguiente := Self.FSiguienteLista;
end;

{ Operaciones propias de la clase }

{AddReserva}
procedure TListaReservas.AddReserva(Reserva : PTReserva);
begin
    Reserva^.SetSiguiente(Self.FReservas);
    // TODO: ¿Es esto lo que se pretende hacer?
    Self.FReservas := Reserva;
end;

{BuscarReserva}
// TODO: Revisar si este método funciona.
// TODO: He reformateado el código por un begin-end roto. Revisar que mantenga
// coherencia.
function TListaReservas.BuscarReserva(Telefono : integer; Nombre : String):TReserva;
var
    encontrado : boolean;
    auxFecha : PTListaReservas;
    auxRes : PTReserva;
begin
    encontrado := false;
    // Empieza a buscar por el principio
    auxFecha^ := Self;
    auxRes := auxFecha^.FReservas;
    while not encontrado do
    begin
        // Si encuentra la reserva o llega al final de la lista
        // devuelve el puntero que corresponda
        if ((auxRes^.GetNombre() = Nombre) and (auxRes^.GetTelefono() = Telefono)) then
        begin
            encontrado := true;
            BuscarReserva := auxRes^;
        end
        // Si no la encuentra continua por el siguiente
        // hasta que lo haga o llegue al final de la lista de reservas
        else
        begin
            auxRes := FReservas^.GetSiguiente;
            if  (auxRes = NIL) then
            begin
                // TODO: ¿Es esto lo que se pretende?
                auxFecha^ := Self.FSiguienteLista^;
                if (auxFecha = NIL) then
                begin
                    encontrado := true;
                    BuscarReserva := auxRes^;
                end
                else
                    auxRes := auxFecha^.FReservas;
            end; // if
        end; // sentencia else
    end; // while
end; // BuscarReserva

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
        index := Self.BuscarReserva(Telefono,Nombre).GetCantidad();
        for i := 1 to index do
        begin
              Self.BuscarReserva(Telefono,Nombre).GetLocalidad(index).SetEstado (Libre);
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

