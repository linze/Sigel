unit CReserva;

{$mode objfpc}{$H+}

interface

    uses
        CLocalidad, Classes;
    type
        { TReserva }

        TReserva = class (TPersistent)
        private
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
            procedure LeerDatos (Lector : TReader); dynamic;
            procedure EscribirDatos (Escritor: TWriter); dynamic;
        end;



implementation
{ TReserva }

constructor TReserva.Create;
var
    i: integer;
begin
    Self.FCantidad := 0;
    inherited Create;
end;

procedure TReserva.AddLocalidad(Localidad: TLocalidad);
begin
    Self.FCantidad := Self.FCantidad + 1;
    Self.FLocalidades[Self.FCantidad] := Localidad;
end;

// NOTICE: En teoria, una clase devuelve siempre un puntero, luego
// tras realizar el GetLocalidad si se modifica, debería de modificarse
// el original.
function TReserva.GetLocalidad(Indice: Integer): TLocalidad;
begin
    GetLocalidad := FLocalidades[Indice];
end;

procedure TReserva.LeerDatos(Lector: TReader);
var
    i: integer;
begin
    Self.FNombre := Lector.ReadString;
    Self.FDni := Lector.ReadString;
    Self.FTelefono := Lector.ReadString;
    Self.FEmail := Lector.ReadString;
    Self.FCantidad := Lector.ReadInteger;
    for i:=1 to Self.FCantidad do
        Self.FLocalidades[i].LeerDatos(Lector);
end;

procedure TReserva.EscribirDatos(Escritor: TWriter);
var
    i : integer;
begin
    Escritor.WriteString(Self.FNombre);
    Escritor.WriteString(Self.FDni);
    Escritor.WriteString(Self.FTelefono);
    Escritor.WriteString(Self.FEmail);
    Escritor.WriteInteger(Self.FCantidad);
    for i:=1 to Self.FCantidad do
        Self.FLocalidades[i].EscribirDatos(Escritor);
end;

initialization
    RegisterClass (TReserva);

end.
