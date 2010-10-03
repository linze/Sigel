----------------------------------------------------------
-- Proyecto: MP_Teatro                                  --
-- Descripción:                                         --
-- Maqueta para presentar a la entrevista de requisitos --
----------------------------------------------------------

with Ada.Text_IO;
with Ada.Integer_Text_IO;
with mprincipal;
with comprareserva;

procedure Maqueta is
   Opcion : integer;
begin
   while Opcion /= 5 loop
      Opcion := mprincipal.MenuPrincipal;
      case Opcion is
         when 1 => comprareserva.SimularCompra;
         when 2 => comprareserva.SimularReserva;
         when 3 => comprareserva.SimularModReserva;
         when 4 => null;
         when others => null;
      end case;
   end loop;
end Maqueta;
