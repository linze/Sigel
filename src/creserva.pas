unit CReserva;

{$mode objfpc}{$H+}

interface

    uses
        CLocalidad, Classes, CObjectListItem;
    type
        { TReserva }

        TReserva = class (TObjectListItem)
        private
            FFecha:       TDateTime;
            FNombre:      String;
            FDni:         String;
            FTelefono:    String;
            FEmail:       String;
            FLocalidades: array [1..4] of TLocalidad;
            FCantidad:    Integer;
        public
           { Constructores y destructores }
            constructor Create;

            { Propiedades }
            property Fecha: TDateTime read FFecha write FFecha;
            property Nombre: String read FNombre write FNombre;
            property Dni: String read FDni write FDni;
            property Telefono: String read FTelefono write FTelefono;
            property Email: String read FEmail write FEmail;
            // Cantidad es sólo lectura
            property Cantidad : Integer read FCantidad;

            { Métodos propios de clase }
            procedure AddLocalidad(Localidad: TLocalidad);
            function GetLocalidad(Indice: Integer): TLocalidad;

            { Para guardar-extraer desde ficheros }
            procedure LeerDatos (Lector : TReader); override;
            procedure EscribirDatos (Escritor: TWriter); override;
        end;



implementation
{ TReserva }

constructor TReserva.Create;
begin
    Self.FCantidad := 0;
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

function TReserva.GetLocalidad(Indice: Integer): TLocalidad;
begin
    GetLocalidad := FLocalidades[Indice];
end;

procedure TReserva.LeerDatos(Lector: TReader);
begin
    Self.FFecha := Lector.ReadDate;
    Self.FNombre := Lector.ReadString;
    Self.FDni := Lector.ReadString;
    Self.FTelefono := Lector.ReadString;
    Self.FEmail := Lector.ReadString;
    Self.FLocalidades[1].LeerDatos(Lector);
    Self.FLocalidades[2].LeerDatos(Lector);
    Self.FLocalidades[3].LeerDatos(Lector);
    Self.FLocalidades[4].LeerDatos(Lector);
end;

procedure TReserva.EscribirDatos(Escritor: TWriter);
begin
    Escritor.WriteDate(Self.FFecha);
    Escritor.WriteString(Self.FNombre);
    Escritor.WriteString(Self.FDni);
    Escritor.WriteString(Self.FTelefono);
    Escritor.WriteString(Self.FEmail);
    Self.FLocalidades[1].EscribirDatos(Escritor);
    Self.FLocalidades[2].EscribirDatos(Escritor);
    Self.FLocalidades[3].EscribirDatos(Escritor);
    Self.FLocalidades[4].EscribirDatos(Escritor);
end;

end.
