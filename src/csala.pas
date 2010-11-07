unit CSala;

{$mode DELPHI}{$H+}{$RangeChecks On}

interface
    uses
        CLocalidad, Classes, CTipoLocalidad, CEstadoLocalidad, SysUtils,
        typinfo, Dialogs;
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
            function Buscar(Tipo :TTipoLocalidad; Fila: Integer;
                           Numero : Integer): TLocalidad;
            procedure Cambiar(Localidad : TLocalidad);
            function LocalidadValida(Localidad: TLocalidad): boolean;
            function EstaCompleto : boolean;
            // Devuelve un número de 1..4
            function NumeroLibres(Tipo: TTipoLocalidad) : integer;
            function ObtenerLibre (Tipo:TTipoLocalidad) : TLocalidad;

            { Para guardar-extraer desde ficheros }
            procedure LeerDatos (Lector : TReader); dynamic;
            procedure EscribirDatos (Escritor: TWriter); dynamic;

            procedure LogEnFichero;

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

function TSala.Buscar(Tipo: TTipoLocalidad; Fila: Integer;
  Numero: Integer): TLocalidad;
var
    Localidad : TLocalidad;
begin
    Localidad := TLocalidad.Create;
    Localidad.Tipo := Tipo;
    Localidad.Fila := Fila;
    Localidad.Numero := Numero;

    if LocalidadValida(Localidad) then
    begin
        try
            case Tipo of
            Patio:  result := FPatio[Fila,Numero];
            PrimeraPlanta: result := FPrimeraPlanta[Fila, Numero];
            Palco:  result := FPalco[Numero];
            end;
        except
            result := nil;
        end;
    end
    else
        result := nil;
    Localidad.Free;
end;

procedure TSala.Cambiar(Localidad: TLocalidad);
begin
    try
        case Localidad.Tipo of
        Patio:         FPatio[Localidad.Fila, Localidad.Numero] := Localidad;
        PrimeraPlanta: FPrimeraPlanta[Localidad.Fila, Localidad.Numero] := Localidad;
        Palco:         FPalco[Localidad.Numero] := Localidad;
        end;
    except
        ShowMessage('[CSala:Buscar] Fuera de índice');
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

procedure TSala.LogEnFichero;
    procedure AppendEstado (Localidad : TLocalidad);
    var
       Log : TextFile;
    begin
        AssignFile(Log, 'log_sala.txt');
        Append(Log);
        WriteLn(Log, '');
        WriteLn(Log, 'Fila: ' + IntToStr(Localidad.Fila) + ', Numero: ' + IntToStr(Localidad.Numero));
        if Localidad.EstaOcupado then
            WriteLn(Log, 'Estado: OCUPADA')
        else
            WriteLn(Log, 'Estado: Libre');
        Close(Log);
    end;
var
    i, j: integer;
begin
    // Escribimos el patio del stream
    for i:=1 to 4 do
        for j:=1 to 8 do
            AppendEstado(Self.FPatio[i,j]);

    // Escribimos la primera planta del stream
    for i:=1 to 2 do
        for j:=1 to 8 do
            AppendEstado(Self.FPrimeraPlanta[i,j]);

    // Escribimos el paco del stream
    for i:=1 to 4 do
        AppendEstado(Self.FPalco[i]);

end;

function TSala.LocalidadValida(Localidad: TLocalidad): boolean;
begin
    if Localidad.Tipo = Patio then
        LocalidadValida := not (((Localidad.Fila = 3) and ((Localidad.Numero = 1) or (Localidad.Numero = 8)))
                            or ((Localidad.Fila = 4) and((Localidad.Numero = 1) or (Localidad.Numero = 2)
                            or (Localidad.Numero = 7) or (Localidad.Numero = 8))))
    else if Localidad.Tipo = Palco then
        LocalidadValida := ((Localidad.Numero >=1) and (Localidad.Numero <=4))
    else if Localidad.Tipo = PrimeraPlanta then
        LocalidadValida := (Localidad.Fila = 1) or (Localidad.Fila = 2);
end;

function TSala.EstaCompleto: boolean;
var
    i,j : integer;
    EncontradoLibre : boolean;
begin
    EncontradoLibre := False;

    i := 1;
    while (not EncontradoLibre) and (i <=4) do
    begin
        j := 1;
        while (not EncontradoLibre) and (j <= 8) do
        begin
             if LocalidadValida(Self.FPatio[i,j]) then
                EncontradoLibre := not Self.FPatio[i,j].EstaOcupado;
            j := j + 1;
        end;
        i := i + 1;
    end;

    i := 1;
    while (not EncontradoLibre) and (i <=2) do
    begin
        j := 1;
        while (not EncontradoLibre) and (j <= 8) do
        begin
            EncontradoLibre := not Self.FPrimeraPlanta[i,j].EstaOcupado;
            j := j + 1;
        end;
        i := i + 1;
    end;

    i := 1;
    while (not EncontradoLibre) and (i <= 4) do
    begin
        EncontradoLibre := not Self.FPalco[i].EstaOcupado;
        i := i + 1;
    end;

    EstaCompleto := not EncontradoLibre;
end;

function TSala.NumeroLibres (Tipo : TTipoLocalidad): integer;
var
    i,j     : integer;
    cuenta  : integer;
    EncontradasCuatro : boolean;
begin
    EncontradasCuatro := False;

    cuenta := 0;
    case tipo of
    Patio: begin
           i := 1;
           while (not EncontradasCuatro) and (i <=4) do
           begin
               j := 1;
               while (not EncontradasCuatro) and (j <= 8) do
               begin
                    if LocalidadValida(Self.FPatio[i,j]) then
                       if not Self.FPatio[i,j].EstaOcupado then
                       begin
                            cuenta := cuenta + 1;
                            EncontradasCuatro := (cuenta >= 4);
                       end;
                    j := j + 1;
               end;
               i := i + 1;
               end;
           end;

    PrimeraPlanta :begin
                      i := 1;
                      while (not EncontradasCuatro) and (i <=2) do
                      begin
                          j := 1;
                          while (not EncontradasCuatro) and (j <= 8) do
                          begin
                               if not Self.FPrimeraPlanta[i,j].EstaOcupado then
                               begin
                                    cuenta := cuenta + 1;
                                    EncontradasCuatro := (cuenta >= 4);
                               end;
                          end;
                          i := i + 1;
                      end;
                  end;

    Palco : begin
                i := 1;
                while (not EncontradasCuatro) and (i <= 4) do
                begin
                   if not Self.FPalco[i].EstaOcupado then
                   begin
                        cuenta := cuenta + 4;
                        EncontradasCuatro := (cuenta >= 4);
                   end;
                   i := i + 1;
                   end;
                end;
    end;
    result := cuenta;

    case Tipo of
    Patio:          begin
                        i := 1;
                        while (not EncontradasCuatro) and (i <=4) do
                        begin
                            j := 1;
                            while (not EncontradasCuatro) and (j <= 8) do
                            begin
                                 if LocalidadValida(Self.FPatio[i,j]) then
                                    if not Self.FPatio[i,j].EstaOcupado then
                                    begin
                                        cuenta := cuenta + 1;
                                        EncontradasCuatro := (cuenta >= 4);
                                    end;
                                j := j + 1;
                            end;
                            i := i + 1;
                        end;
                    end;
    PrimeraPlanta:  begin
                        i := 1;
                        while (not EncontradasCuatro) and (i <=2) do
                        begin
                            j := 1;
                            while (not EncontradasCuatro) and (j <= 8) do
                            begin
                                if not Self.FPrimeraPlanta[i,j].EstaOcupado then
                                begin
                                    cuenta := cuenta + 1;
                                    EncontradasCuatro := (cuenta >= 4);
                                end;
                            end;
                            i := i + 1;
                        end;
                    end;
    Palco:          begin
                        i := 1;
                        while (not EncontradasCuatro) and (i <= 4) do
                        begin
                            if not Self.FPalco[i].EstaOcupado then
                            begin
                                cuenta := cuenta + 4;
                                EncontradasCuatro := (cuenta >= 4);
                            end;
                            i := i + 1;
                        end;
                    end;
    end;

    result := cuenta;
end;

function TSala.ObtenerLibre(Tipo: TTipoLocalidad): TLocalidad;
var
    i,j     : integer;
    Found   : boolean;
begin
    Found := False;
    case Tipo of
    Patio:          begin
                        i := 1;
                        while (i <=4) do
                        begin
                            j := 1;
                            while (j <= 8) do
                            begin
                                 if LocalidadValida(Self.FPatio[i,j]) then
                                    if not Self.FPatio[i,j].EstaOcupado then
                                    begin
                                        Found := True;
                                        result := Self.FPatio[i,j];
                                    end;
                                j := j + 1;
                            end;
                            i := i + 1;
                        end;
                    end;
    PrimeraPlanta:  begin
                        i := 1;
                        while (i <=2) do
                        begin
                            j := 1;
                            while (j <= 8) do
                            begin
                                if not Self.FPrimeraPlanta[i,j].EstaOcupado then
                                begin
                                    Found := True;
                                    result := Self.FPrimeraPlanta[i,j];
                                end;
                            end;
                            i := i + 1;
                        end;
                    end;
    Palco:          begin
                        i := 1;
                        while (i <= 4) do
                        begin
                            if not Self.FPalco[i].EstaOcupado then
                            begin
                                Found := True;
                                result := Self.FPalco[i];
                            end;
                            i := i + 1;
                        end;
                    end;
    end;

    if not Found then
    begin
        ShowMessage('[CSala:ObtenerLibre] No había ninguna localidad libre para este tipo');
        result := nil;
    end;
end;

initialization
    RegisterClass (TSala);

end.

