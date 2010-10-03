with Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;
with Ada.Text_IO;

package body CompraReserva is

   procedure PedirLocalidad (Numero: integer) is
      Tipo : Ada.Strings.Unbounded.Unbounded_String;
      Tmp : Ada.Strings.Unbounded.Unbounded_String;
   begin
      Ada.Text_IO.Put_Line("Localidad #" & Integer'Image(Numero) );
      Ada.Text_IO.Put ("Tipo: ");
      Ada.Strings.Unbounded.Text_IO.Get_Line (Tipo);
      if Ada.Strings.Unbounded.To_String(Tipo) = "palco" then
         Ada.Text_IO.Put ("Numero: ");
         Ada.Strings.Unbounded.Text_IO.Get_Line(Tmp);
      else
         Ada.Text_IO.Put ("Fila y asiento: ");
         Ada.Strings.Unbounded.Text_IO.Get_Line(Tmp);
      end if;
   end PedirLocalidad;


   procedure SimularPedirDatos is
      Tmp : Ada.Strings.Unbounded.Unbounded_String;
      i   : integer;
   begin
      Ada.Text_IO.Put_Line("Nombre del solicitante: ");
      Ada.Strings.Unbounded.Text_IO.Get_Line(Tmp);
      Ada.Text_IO.Put_Line("DNI del solicitante: ");
      Ada.Strings.Unbounded.Text_IO.Get_Line(Tmp);
      Ada.Text_IO.Put_Line("Numero de localidades: ");
      Ada.Strings.Unbounded.Text_IO.Get_Line(Tmp);
      i := Integer'Value(Ada.Strings.Unbounded.To_String(Tmp));
      for j in 1..i loop
         PedirLocalidad(j);
      end loop;
   end SimularPedirDatos;

   procedure SimularCompra is
   begin
      Ada.Text_IO.Put_Line("COMPRA DE LOCALIDADES:");
      Ada.Text_IO.Put_Line("_________________________________________");
      SimularPedirDatos;
   end SimularCompra;

   procedure SimularReserva is
   begin
      Ada.Text_IO.Put_Line("RESERVA DE LOCALIDADES:");
      Ada.Text_IO.Put_Line("_________________________________________");
      SimularPedirDatos;
   end SimularReserva;

   procedure SimularModReserva is
   begin
      null;
   end SimularModReserva;

end CompraReserva;
