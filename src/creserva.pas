unit CReserva;

{$mode objfpc}{$H+}

interface

    uses
        CLocalidad, CFecha;
    type

        { PTReserva }
        PTReserva = ^TReserva;
        { TReserva }

        TReserva = class
        private
            FFecha:       TFecha;
            FNombre:      String;
            FDNI:         String;
            FTelefono:    Integer;
            FEmail:       String;
            FLocalidades: array [1..4] of TLocalidad;
            FCantidad:    1..4;
            FSiguiente:   PTReserva;
        public
           { Constructores y destructores }
            constructor Create;

            { Métodos Set }
            procedure SetFecha(Fecha: TFecha);
            procedure SetNombre(Nombre: String);
            procedure SetDNI(DNI: String);
            procedure SetTelefono(Telefono: Integer);
            procedure SetEmail(Email: String);
            procedure SetSiguiente(Reserva: PTReserva);

            { Método para añadir una localidad a la reserva }
            procedure AddLocalidad(Localidad: TLocalidad);

            { Métodos Get }
            function GetFecha: TFecha;
            function GetNombre: String;
            function GetDNI: String;
            function GetTelefono: Integer;
            function GetEmail: String;
            // TODO: Esto debería de ser un 1..4, pero ¿no se permite?
            function GetCantidad: Integer;
            function GetSiguiente: PTReserva ;
            // TODO: Esto debería de admitir como parámetro 1..4, pero no
            function GetLocalidad(Indice: Integer): TLocalidad;
        end;



implementation
{ TReserva }

constructor TReserva.Create();
begin
    Self.FCantidad := 0;
end;

procedure TReserva.SetFecha(Fecha: TFecha);
begin
    Self.FFecha := Fecha;
end;

procedure TReserva.SetNombre(Nombre: String);
begin
    Self.FNombre := Nombre;
end;

procedure TReserva.SetDNI(DNI: String);
begin
    Self.FDNI := DNI;
end;

procedure TReserva.SetTelefono(Telefono: Integer);
begin
    Self.FTelefono := Telefono;
end;

procedure TReserva.SetEmail(Email: String);
begin
    Self.FEmail := Email;
end;

procedure TReserva.SetSiguiente(Reserva: PTReserva);
begin
    Self.FSiguiente := Reserva;
end;

procedure TReserva.AddLocalidad(Localidad: TLocalidad);
var
    i: Integer;
    salir: boolean;
begin
    salir := false;
    i := 1;
    while (i <= 4) and (not salir) do
    begin
        if Self.FLocalidades[i].EstaOcupado then
        begin
            //Si la cuarta plaza está ocupada no hay huecos para más reservas
            if (i = 4) then
            begin
                //TODO Excepcion, 4 plazas ocupadas ya, nos e puede añadir
            end;
            i := i + 1;
        end
        //Si no está ocupada una plaza de la reserva, la asignamos a la
        //deseada, incrementamos la cantidad de la reserva y salimos.
        else
        begin
            Self.FLocalidades[i] := Localidad;
            Self.FCantidad := Self.FCantidad + 1;
            salir := true;
        end;
    end;
end;

function TReserva.GetFecha: TFecha;
begin
    GetFecha := Self.FFecha;
end;

function TReserva.GetNombre: String;
begin
    GetNombre := Self.FNombre;
end;

function TReserva.GetDNI: String;
begin
    GetDNI := Self.FDNI;
end;

function TReserva.GetTelefono: Integer;
begin
    GetTelefono := Self.FTelefono;
end;

function TReserva.GetEmail: String;
begin
    GetEmail := Self.FEmail;
end;

function TReserva.GetCantidad: Integer;
begin
    GetCantidad := Self.FCantidad;
end;

function TReserva.GetSiguiente: PTReserva;
begin
    GetSiguiente := Self.FSiguiente;
end;

function TReserva.GetLocalidad(Indice: Integer): TLocalidad;
begin
    GetLocalidad := FLocalidades[Indice];
end;
end.
