unit CReserva;

{$mode objfpc}{$H+}

interface

    uses
        CLocalidad, Classes, SysUtils, Dialogs;
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
            destructor Destroy; override;

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
            function PasarString: String;

            { Para guardar-extraer desde ficheros }
            procedure LeerDatos (Lector : TReader); dynamic;
            procedure EscribirDatos (Escritor: TWriter); dynamic;

            procedure LogEnFichero;
        end;



implementation
{ TReserva }

constructor TReserva.Create;
begin
    Self.FCantidad := 0;
    inherited Create;
end;

destructor TReserva.Destroy;
var
    i: integer;
begin
    for i:=1 to Cantidad do
        FLocalidades[i].Free;
    inherited Destroy;
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
    Lector.ReadListBegin;
    i := 0;
    while not Lector.EndOfList do
    begin
        i := i + 1;
        Self.FLocalidades[i] := TLocalidad.Create;
        Self.FLocalidades[i].LeerDatos(Lector);
    end;
    Self.FCantidad := i;
    if Self.FCantidad > 4 then
        ShowMessage ('[Reserva:LeerDatos] La cantidad no debería de ser mayor de 4 y es ' +
                        IntToStr(Self.FCantidad));
end;

procedure TReserva.EscribirDatos(Escritor: TWriter);
var
    i : integer;
begin
    Escritor.WriteString(Self.FNombre);
    Escritor.WriteString(Self.FDni);
    Escritor.WriteString(Self.FTelefono);
    Escritor.WriteString(Self.FEmail);
    Escritor.WriteListBegin;
    if Self.FCantidad > 4 then
        ShowMessage ('[Reserva:EscribirDatos] La cantidad no debería de ser mayor de 4 y es ' +
                        IntToStr(Self.FCantidad));
    for i:=1 to Self.FCantidad do
        Self.FLocalidades[i].EscribirDatos(Escritor);
    Escritor.WriteListEnd;
end;

function TReserva.PasarString: string;
var
   strg: string;
   i: integer;
begin
   strg := Self.FNombre + '-' + Self.FDni + '-' + Self.FTelefono + '-' + Self.FEmail + '-' + IntToStr(Self.FCantidad);
   for i := 1 to Self.FCantidad do
       strg := strg + '-' + IntToStr(ord(Self.FLocalidades[i].Tipo)) + '-' + IntToStr(Self.FLocalidades[i].Fila) + '-' + IntToStr(Self.FLocalidades[i].Numero);
   PasarString := strg;
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
