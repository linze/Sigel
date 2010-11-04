unit CSala;

{$mode DELPHI}{$H+}{$RangeChecks On}

interface
    uses
        CLocalidad, Classes, CTipoLocalidad, CEstadoLocalidad, Dialogs;
    type

        { TSala }
        TSala = class (TPersistent)
        private
            { Atributos }
            FFecha           : TDateTime;
            FPatio           : array [1..4, 1..8] of TLocalidad;
            FPrimeraPlanta   : array [1..2, 1..8] of TLocalidad;
            FPalco           : array [1..4] of TLocalidad;
        public
            { Constructores y destructores }
            constructor Create;

            { Propiedades }
            property Fecha: TDateTime read FFecha write FFecha;


            { Operaciones propias de la clase }
            function Buscar(Tipo :TTipoLocalidad; Numero: Integer;
                           Fila : Integer): TLocalidad;
            procedure Cambiar(Localidad : TLocalidad);

            { Para guardar-extraer desde ficheros }
            procedure LeerDatos (Lector : TReader); dynamic;
            procedure EscribirDatos (Escritor: TWriter); dynamic;
        end;

implementation

{ TSala }

constructor TSala.Create;
var
    i, j: integer;
begin
    for i:=1 to 4 do
        for j:=1 to 8 do
        begin
            Self.FPatio[i,j] := TLocalidad.Create;
            Self.FPatio[i,j].Tipo := Patio;
            Self.FPatio[i,j].Estado := Libre;
            Self.FPatio[i,j].Fila := i;
            Self.FPatio[i,j].Numero := j;
        end;

    for i:=1 to 2 do
        for j:=1 to 8 do
        begin
            Self.FPrimeraPlanta[i,j] := TLocalidad.Create;
            Self.FPrimeraPlanta[i,j].Tipo := PrimeraPlanta;
            Self.FPrimeraPlanta[i,j].Estado := Libre;
            Self.FPrimeraPlanta[i,j].Fila := i;
            Self.FPrimeraPlanta[i,j].Numero := j;
        end;

    for i:=1 to 4 do
    begin
        Self.FPalco[i] := TLocalidad.Create;
        Self.FPalco[i].Tipo := Palco;
        Self.FPalco[i].Estado := Libre;
        Self.FPalco[i].Numero := i;
    end;

    inherited Create;
end;

// TODO: Estudiar si este método ha de separarse en varios métodos
// privados de búsqueda para cada tipo de localidad. Implementarlo
// todo en el mismo puede llegar a ser engorroso.
function TSala.Buscar(Tipo: TTipoLocalidad; Numero: Integer;
  Fila: Integer): TLocalidad;
var
    Encontrado   : boolean;
    Fin_Busqueda : boolean;
    i,j          : integer;
begin
    Encontrado := False;
    Fin_Busqueda := False;

    i := 1;
    if Tipo = Patio then
    begin
        j := 1;
        while (not Encontrado) and (not Fin_Busqueda) do
        begin
            Encontrado := (FPatio[i,j].Numero = Numero) and
                          (FPatio[i,j].Fila = Fila);
            // Comprobamos que no hemos llegado al final
            if (i = 4) and (j = 8) then
                Fin_Busqueda := True
            else if (not Encontrado) then
            begin
                // Mientras no sea el final, avanzamos
                // de asiento
                if (j <> 8) then
                    j := j + 1
                else
                // ... o de fila
                begin
                    i := i + 1;
                    j := 1;
                end;
            end;
        end;
    end
    else if Tipo = PrimeraPlanta then
    begin
        j := 1;
        while (not Encontrado) and (not Fin_Busqueda) do
        begin
            Encontrado := (FPrimeraPlanta[i,j].Numero = Numero) and
                           (FPrimeraPlanta[i,j].Fila = Fila);
           // Comprobamos que no hemos llegado al final
            if (i = 2) and (j = 8) then
                Fin_Busqueda := True
            else if (not Encontrado) then
            begin
                // Mientras no sea el final, avanzamos
                // de asiento
                if (j <> 8) then
                    j := j + 1
                else
                // ... o de fila
                begin
                    i := i + 1;
                    j := 1;
                end;
            end;
        end;
    end
    else
    begin
        while (not Encontrado) and (not Fin_Busqueda) do
        begin
            Encontrado := (FPalco[i].Numero = Numero);
            // Comprobamos que no hemos llegado al final
            if (i = 4) then
                Fin_Busqueda := True
            else if (not Encontrado) then
            begin
                i := i + 1;
            end;
       end;
    end;

     if Encontrado then
     begin
        case Tipo of
            Patio:         Buscar := FPatio[i,j];
            PrimeraPlanta: Buscar := FPrimeraPlanta[i,j];
            Palco:         Buscar := FPalco[i];
        end;
     end
     else
     begin
        Buscar := nil;
     end;
end;

procedure TSala.Cambiar(Localidad: TLocalidad);
begin
    case Localidad.Tipo of
    Patio:         FPatio[Localidad.Fila, Localidad.Numero] := Localidad;
    PrimeraPlanta: FPrimeraPlanta[Localidad.Fila, Localidad.Numero] := Localidad;
    // TODO: Verificar que al grupo le ha quedado claro que para los palcos
    // usaremos el número y no la fila.
    Palco:         FPalco[Localidad.Numero] := Localidad;
    end;
end;

procedure TSala.LeerDatos(Lector: TReader);
var
    i,j : integer;
begin
    Self.FFecha := Lector.ReadDate;

    // Leemos el patio del stream
    for i:=1 to 4 do
        for j:=1 to 8 do
        begin
            Self.FPatio[i,j].LeerDatos(Lector);
        end;
    // Leemos la primera planta del stream
    for i:=1 to 2 do
        for j:=1 to 8 do
            Self.FPrimeraPlanta[i,j].LeerDatos(Lector);

    // Leemos el paco del stream
    for i:=1 to 4 do
        Self.FPalco[i].LeerDatos(Lector);
end;

procedure TSala.EscribirDatos(Escritor: TWriter);
var
    i,j : integer;
begin
    Escritor.WriteDate(Self.FFecha);

    // Escribimos el patio del stream
    for i:=1 to 4 do
        for j:=1 to 8 do
            Self.FPatio[i,j].EscribirDatos(Escritor);

    // Escribimos la primera planta del stream
    for i:=1 to 2 do
        for j:=1 to 8 do
            Self.FPrimeraPlanta[i,j].EscribirDatos(Escritor);

    // Escribimos el paco del stream
    for i:=1 to 4 do
        Self.FPalco[i].EscribirDatos(Escritor);

end;

initialization
    RegisterClass (TSala);

end.

