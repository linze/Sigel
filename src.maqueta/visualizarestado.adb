with Ada.Text_IO;
package body VisualizarEstado is
    procedure MostrarEstado is
    begin
        Ada.Text_IO.Put_Line("                   _ _ _ _          _ _ _ _");
        Ada.Text_IO.Put_Line("                  |_|_|_|_| Fila 1 |_|_|_|_|");
        Ada.Text_IO.Put_Line("                  |_|_|_|_| Fila 2 |X|_|_|_|");
        Ada.Text_IO.Put_Line("                   1 2 3 4          5 6 7 8");
        Ada.Text_IO.Put_Line("    ______             _ _          _ _             ______");
        Ada.Text_IO.Put_Line("   |      |P4        _|_|_|   F4   |_|_|_          |      |P3");
        Ada.Text_IO.Put_Line("   |______|        _|_|X|X|   F3   |_|_|X|_        |______|");
        Ada.Text_IO.Put_Line("   |      |P2     |_|_|_|_|   F2   |O|O|O|_|       |      |P1");
        Ada.Text_IO.Put_Line("   |______|       |_|_|_|_|   F1   |_|_|_|_|       |______|");
        Ada.Text_IO.Put_Line("                   1 2 3 4          5 6 7 8");
        Ada.Text_IO.Put_Line("                                              X -> Comprado");
        Ada.Text_IO.Put_Line("                                              O -> Reservado");
    end MostrarEstado;

    procedure MostrarDatosEjemplo is
    begin
        Ada.Text_IO.Put_Line("  DNI         NOMBRE                TIPO       FILA     BUTACA   ESTADO");
        Ada.Text_IO.Put_Line("  15311535D   Leona Saiz            Patio      F3       3        Comprada");
        Ada.Text_IO.Put_Line("                                    Patio      F3       4        Comprada");
        Ada.Text_IO.Put_Line("  23545131F   Concepcion Quintana   Patio      F3       7        Comprada");
        Ada.Text_IO.Put_Line("  34587654Q   Cornelia Muro         Patio      F2       5        Reservada");
        Ada.Text_IO.Put_Line("                                    Patio      F2       6        Reservada");
        Ada.Text_IO.Put_Line("                                    Patio      F2       7        Reservada");
        Ada.Text_IO.Put_Line("  69696969F   Senen Gonzalez        P.Fila     F2       5        Comprada");
    end MostrarDatosEjemplo;
end VisualizarEstado;
