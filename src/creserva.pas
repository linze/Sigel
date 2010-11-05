unit CReserva;

{$mode objfpc}{$H+}

interface

    uses
        CLocalidad, Classes, SysUtils;
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

            procedure LogEnFichero;
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

    FLocalidades[FCantidad] := TLocalidad.Create;
    FLocalidades[FCantidad].Tipo := Localidad.Tipo;
    FLocalidades[FCantidad].Estado := Localidad.Estado;
    FLocalidades[FCantidad].Numero := Localidad.Numero;
    FLocalidades[FCantidad].Fila := Localidad.Fila;
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
    //Self.FCantidad := Lector.ReadInteger;
    Lector.ReadListBegin;
    i := 0;
    while not Lector.EndOfList do
    begin
        i := i + 1;
        Self.FLocalidades[i] := TLocalidad.Create;
        Self.FLocalidades[i].LeerDatos(Lector);
    end;
    Self.FCantidad := i;
end;

procedure TReserva.EscribirDatos(Escritor: TWriter);
var
    i : integer;
begin
    Escritor.WriteString(Self.FNombre);
    Escritor.WriteString(Self.FDni);
    Escritor.WriteString(Self.FTelefono);
    Escritor.WriteString(Self.FEmail);
    //Escritor.WriteInteger(Self.FCantidad);
    Escritor.WriteListBegin;
    for i:=1 to Self.FCantidad do
        Self.FLocalidades[i].EscribirDatos(Escritor);
    Escritor.WriteListEnd;
end;

procedure TReserva.LogEnFichero;
var
    i : integer;
    Log : TextFile;
begin
    AssignFile(Log, 'log_reserva.txt');
    Append(Log);
    WriteLn(Log, '');
    WriteLn(Log, 'Nombre: ' + Self.Nombre + ' Cantidad: ' + IntToStr(Self.Cantidad));
    WriteLn(Log, 'Dni: ' + Self.Dni + ' Telefono: ' + Self.Telefono + ' Email: ' + Self.Email);
    for i:=1 to Self.FCantidad do
    begin
        WriteLn(Log, 'Fila: ' + IntToStr(Self.FLocalidades[i].Fila) + ', Numero: ' + IntToStr(Self.FLocalidades[i].Numero));
        if Self.FLocalidades[i].EstaOcupado then
            WriteLn(Log, 'Estado: OCUPADA')
        else
            WriteLn(Log, 'Estado: Libre');
    end;
    Close(Log);
end;

initialization
    RegisterClass (TReserva);

end.
