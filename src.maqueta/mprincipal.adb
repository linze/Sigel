with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;

package body MPrincipal is

   function MenuPrincipal return Integer is
      ResultadoValido : boolean := FALSE;
      OpStr  : Ada.Strings.Unbounded.Unbounded_String;
      Opcion : integer;
   begin
      while not ResultadoValido loop
         Ada.Text_IO.Put_Line("  MPTeatro");
         Ada.Text_IO.Put_Line("_______________________________");
         Ada.Text_IO.Put_Line("  1)   Compra de localidades");
         Ada.Text_IO.Put_Line("  2)   Reserva de localidades");
         Ada.Text_IO.Put_Line("  3)   Modificar/anular reserva");
         Ada.Text_IO.Put_Line("");
         Ada.Text_IO.Put_Line("  4)   Visualizar estado actual");
         Ada.Text_IO.Put_Line("");
         Ada.Text_IO.Put_Line("  5)   Finalizar ejecucion");
         Ada.Text_IO.Put_Line("_______________________________");
         Ada.Text_IO.Put ("Elija una opción: ");
         Ada.Strings.Unbounded.Text_IO.Get_Line(OpStr);
         Opcion := Integer'Value(Ada.Strings.Unbounded.To_String(OpStr));
         if (Opcion > 0) and (Opcion < 6) then
            ResultadoValido := TRUE;
            return Opcion;
         end if;
      end loop;
   end MenuPrincipal;

end MPrincipal;
