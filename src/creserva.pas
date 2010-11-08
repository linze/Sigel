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
            // Cadena que contiene las localidades en un formato
            // especial.
            FLocalidades: String;
            FCantidad:    Integer;

            // Convierte de string a localidad y viceversa
            function StrToLocalidad(Cadena: String): TLocalidad;
            function LocalidadToStr (Localidad: TLocalidad): String;

            // Obtiene y cambia una posición de la lista de localidades
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

            { Para depurar }
            procedure LogEnFichero;
        end;



implementation
{ TReserva }

function TReserva.StrToLocalidad(Cadena: String): TLocalidad;
var
    Localidad : TLocalidad;
begin
    // Crea una localidad
    Localidad := TLocalidad.Create;
    Localidad.Estado := Reservada;

    // Obtiene el tipo de localidad
    case Cadena[1] of
    'A': Localidad.Tipo := Patio;
    'B': Localidad.Tipo := PrimeraPlanta;
    'C': Localidad.Tipo := Palco;
    end;

    // Obtiene la fila y el número desde sus posiciones en el
    // array.
    Localidad.Fila := StrToInt(Cadena[2]);
    Localidad.Numero := StrToInt(Cadena[3]);

    // Si la localidad es un palco, se establece su fila y su
    // número iguales.
    if Localidad.Tipo = Palco then
        Localidad.Fila := Localidad.Numero;

    // Devuelve la localidad como resultado de la función
    Result := Localidad;
end;

function TReserva.LocalidadToStr(Localidad: TLocalidad): String;
var
    TmpStr : String;
begin
    // Si la localidad no existe...
    if Localidad = nil then
        // ... se genera el string de localidad vacía
        Result := 'X00'
    else
    // Si existe...
    begin
        // Se establece el tipo como primer carácter
        case Localidad.Tipo of
        Patio: TmpStr := 'A';
        PrimeraPlanta: TmpStr := 'B';
        Palco: TmpStr := 'C';
        end;

        // Si el tipo el palco...
        if Localidad.Tipo = Palco then
            //... se establece la Fila como 0
            TmpStr := TmpStr + '0'
        // En caso contrario...
        else
            //... se introduce la fila como segundo carácter
            TmpStr := TmpStr + IntToStr(Localidad.Fila);

        // Se añade el número como tercer carácter
        TmpStr := TmpStr + IntToStr(Localidad.Numero);

        // Devuelve la conversión ya realizada como resultado
        // de la función
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
    // Nos posicionamos en la parte de string donde
    // comienza la localidad indicada en el índice
    if Indice <> 1 then
        for i:=1 to Indice - 1 do
            j := j + 3;

    // Copiamos 3 carácteres desde la posición j en TmpStr
    // (Es decir, la cadena de la localidad)
    TmpStr := Copy(Self.FLocalidades,j,3);

    // Transformamos el string en localidad y lo devolvemos
    // como resultado de la función
    Result := StrToLocalidad(TmpStr);
end;

procedure TReserva.SetFLocalidad(Indice: integer; Localidad: TLocalidad);
var
    Localidades : array [1..4] of TLocalidad;
    TmpStr : string;
    i,j      : integer;
begin
    // Transformamos el string en localidades que vamos insertando
    // en el array
    j := 1;
    for i:=1 to 4 do
    begin
        // Creamos la localidad
        Localidades[i] := TLocalidad.Create;
        // Convertimos el trozo de cadena de la localidad en una localidad
        // y lo asignamos a su posición en el array
        Localidades[i] := StrToLocalidad(Copy(Self.FLocalidades,j,3));
        // Actualizamos la posición del siguiente inicio de cadena de
        // localidad
        j := j + 3;
    end;

    // Cambiamos la localidad pasada por parámetros
    Localidades[Indice] := Localidad;

    // Transformamos el array en string de nuevo
    TmpStr := '';
    // Para cada una de las posiciones del array...
    for i:=1 to 4 do
    begin
        // ... añadimos la cadena de la localidad
        TmpStr := TmpStr + LocalidadToStr(Localidades[i]);
    end;

    // Actualizamos el atributo con las localidades
    Self.FLocalidades := TmpStr;
end;

constructor TReserva.Create;
begin
    Self.FCantidad := 0;
    // Introducimos al inicio una cadena de localidades vacías
    Self.FLocalidades := 'X00X00X00X00';
    inherited Create;
end;

procedure TReserva.AddLocalidad(Localidad: TLocalidad);
begin
    // Actualizamos el contador de cantidades
    Self.FCantidad := Self.FCantidad + 1;
    // Añadimos la localidad a la nueva posición
    SetFLocalidad(FCantidad, Localidad);
end;

function TReserva.GetLocalidad(Indice: Integer): TLocalidad;
begin
    GetLocalidad := GetFLocalidad(Indice);
end;

procedure TReserva.LeerDatos(Lector: TReader);
begin
    // Lee el TReserva desde un stream
    Self.FNombre := Lector.ReadString;
    Self.FDni := Lector.ReadString;
    Self.FTelefono := Lector.ReadString;
    Self.FEmail := Lector.ReadString;
    Self.FCantidad := Lector.ReadInteger;
    Self.FLocalidades := Lector.ReadString;
end;

procedure TReserva.EscribirDatos(Escritor: TWriter);
begin
    // Escribe el TReserva en un stream
    Escritor.WriteString(Self.FNombre);
    Escritor.WriteString(Self.FDni);
    Escritor.WriteString(Self.FTelefono);
    Escritor.WriteString(Self.FEmail);
    Escritor.WriteInteger(Self.FCantidad);
    Escritor.WriteString(Self.FLocalidades);
end;

// Procedimiento únicamente con valor a la hora de depurar. Añade a un fichero
// el contenido de un TReserva
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
