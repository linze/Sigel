with Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;
with Ada.Text_IO;
with visualizarestado;

package body CompraReserva is

   procedure PedirLocalidad (Numero: integer) is
      Tipo : Ada.Strings.Unbounded.Unbounded_String;
      Tmp : Ada.Strings.Unbounded.Unbounded_String;
   begin
      Ada.Text_IO.Put_Line("Localidad #" & Integer'Image(Numero) );
      Ada.Text_IO.Put_Line ("Tipo: ");
      Ada.Text_IO.Put_Line ("1. Palco");
      Ada.Text_IO.Put_Line ("2. Primer piso");
      Ada.Text_IO.Put_Line ("3. Patio");
      Ada.Strings.Unbounded.Text_IO.Get_Line (Tipo);
      case Integer'Value(Ada.Strings.Unbounded.To_String(Tipo)) is
         when 1 => Ada.Text_IO.Put ("Numero: ");
         when others => Ada.Text_IO.Put ("Fila y butaca: ");
      end case;
      Ada.Strings.Unbounded.Text_IO.Get_Line (Tmp);
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
      Ada.Text_IO.Put_Line("Estado actual del teatro:");
      visualizarestado.MostrarEstado;
      visualizarestado.MostrarDatosEjemplo;
   end SimularModReserva;


   procedure VisualizarTeatro is
   begin
      Ada.Text_IO.Put_Line("Estado actual del teatro:");
      visualizarestado.MostrarEstado;
      visualizarestado.MostrarDatosEjemplo;
   end VisualizarTeatro;
end CompraReserva;
