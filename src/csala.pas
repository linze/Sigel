unit CSala;

{$mode objfpc}{$H+}

interface
         uses
             CTipoLocalidad, CLocalidad, CFecha;
         type

             { TSala }

             TSala = class
             private
                    { Atributos }
                    FPatio           : array [1..4, 1..8] of TLocalidad;
                    FPrimeraPlanta   : array [1..2, 1..8] of TLocalidad;
                    FPalco           : array [1..4] of TLocalidad;
                    FFecha           : TFecha;
             public
                   { Constructores y destructores }
                   constructor Create;

                   { Métodos de asignación de atributos }
                   procedure SetFecha(Fecha: TFecha);

                   { Métodos de obtención de atributos }
                   function GetFecha: TFecha;

                   { Operaciones propias de la clase }
                   function Buscar(Tipo :TTipoLocalidad; Numero: Integer;
                                   Fila : Integer): TLocalidad;
                   procedure Cambiar(Tipo : TLocalidad);
             end;

implementation

{ TSala }

constructor TSala.Create;
begin
     // TODO: Evaluar si es necesario e implementar
end;

procedure TSala.SetFecha(Fecha: TFecha);
begin
     Self.FFecha := Fecha;
end;

function TSala.GetFecha: TFecha;
begin
     GetFecha := Self.FFecha;
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
               Encontrado := (FPatio[i,j].GetNumero = Numero) and
                             (FPatio[i,j].GetFila = Fila);
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
               Encontrado := (FPrimeraPlanta[i,j].GetNumero = Numero) and
                             (FPrimeraPlanta[i,j].GetFila = Fila);
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
               Encontrado := (FPalco[i].GetNumero = Numero);
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
         // TODO: Elevar excepción
     end;
end;

procedure TSala.Cambiar(Tipo: TLocalidad);
begin
     // TODO: Implementar
end;

end.

