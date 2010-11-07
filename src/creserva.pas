unit CReserva;

{$mode objfpc}{$H+}

interface

    uses
        CLocalidad, Classes, SysUtils, Dialogs, CTipoLocalidad, CEstadoLocalidad;
    type
        { TReserva }

        TReserva = class (TPersistent)
        private
            FNombre:      String;
            FDni:         String;
            FTelefono:    String;
            FEmail:       String;
            FLocalidades: String;
            FCantidad:    Integer;
            function StrToLocalidad(Cadena: String): TLocalidad;
            function LocalidadToStr (Localidad: TLocalidad): String;
            function GetFLocalidad (Indice: integer) : TLocalidad;
            procedure SetFLocalidad(Indice: integer; Localidad: TLocalidad);
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

function TReserva.StrToLocalidad(Cadena: String): TLocalidad;
var
    Localidad : TLocalidad;
begin
    Localidad := TLocalidad.Create;
    Localidad.Estado := Reservada;

    case Cadena[1] of
    'A': Localidad.Tipo := Patio;
    'B': Localidad.Tipo := PrimeraPlanta;
    'C': Localidad.Tipo := Palco;
    end;

    Localidad.Fila := StrToInt(Cadena[2]);
    Localidad.Numero := StrToInt(Cadena[3]);

    if Localidad.Tipo = Palco then
        Localidad.Fila := Localidad.Numero;

    Result := Localidad;
end;

function TReserva.LocalidadToStr(Localidad: TLocalidad): String;
var
    TmpStr : String;
begin
    if Localidad = nil then
        Result := 'X00'
    else
    begin
        case Localidad.Tipo of
        Patio: TmpStr := 'A';
        PrimeraPlanta: TmpStr := 'B';
        Palco: TmpStr := 'C';
        end;

        if Localidad.Tipo = Palco then
            TmpStr := TmpStr + '0'
        else
            TmpStr := TmpStr + IntToStr(Localidad.Fila);
        TmpStr := TmpStr + IntToStr(Localidad.Numero);
        Result := TmpStr;
    end;
end;

function TReserva.GetFLocalidad(Indice: integer): TLocalidad;
var
    TmpStr : String;
    i,j    : integer;
begin
    {* Formato:
     * -TFN
     * Donde T es el tipo, F la Fila y N el numero
     * En el caso del paco, F es siempre 0.
     * En caso de estar vacío, F y N son 0.
     * T valdra A(Patio) B(P.Planta), C(Palco) o X(Vacio) }
    j := 1;
    if Indice <> 1 then
        for i:=1 to Indice - 1 do
            j := j + 3;
    TmpStr := Copy(Self.FLocalidades,j,3);
    Result := StrToLocalidad(TmpStr);
end;

procedure TReserva.SetFLocalidad(Indice: integer; Localidad: TLocalidad);
var
    Localidades : array [1..4] of TLocalidad;
    TmpStr : string;
    i,j      : integer;
begin
    j := 1;
    for i:=1 to 4 do
    begin
        Localidades[i] := TLocalidad.Create;
        Localidades[i] := StrToLocalidad(Copy(Self.FLocalidades,j,3));
        j := j + 3;
    end;

    Localidades[Indice] := Localidad;

    TmpStr := '';
    for i:=1 to 4 do
    begin
        TmpStr := TmpStr + LocalidadToStr(Localidades[i]);
    end;
    Self.FLocalidades := TmpStr;
end;

constructor TReserva.Create;
begin
    Self.FCantidad := 0;
    Self.FLocalidades := 'X00X00X00X00';
    inherited Create;
end;

procedure TReserva.AddLocalidad(Localidad: TLocalidad);
begin
    Self.FCantidad := Self.FCantidad + 1;
    SetFLocalidad(FCantidad, Localidad);
end;

function TReserva.GetLocalidad(Indice: Integer): TLocalidad;
begin
    GetLocalidad := GetFLocalidad(Indice);
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
    Self.FLocalidades := Lector.ReadString;
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
    Escritor.WriteString(Self.FLocalidades);
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
        WriteLn(Log, 'Fila: ' + IntToStr(GetFLocalidad(i).Fila) + ', Numero: ' + IntToStr(GetFLocalidad(i).Numero));
        if GetFLocalidad(i).EstaOcupado then
            WriteLn(Log, 'Estado: OCUPADA')
        else
            WriteLn(Log, 'Estado: Libre');
    end;
    Close(Log);
end;

initialization
    RegisterClass (TReserva);

end.
