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
end VisualizarEstado;
