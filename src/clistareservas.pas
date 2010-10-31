unit CListaReservas;

{$mode objfpc}{$H+}

interface

    uses
        CFecha,CPTReserva;

    type
        {PTListaReservas}

        PTListaReservas = ^TListaReservas;

        {TListaReservas}

        TListaReservas = class
        private
            { Atributos }

            FFecha : TFecha;
            FReservas : PTReserva;
            FSiguienteLista : PTListaReservas;

        public
            { Constructores y destructores }
            constructor Create();

            { Métodos de asignación de atributos }
            procedure SetFecha(Fecha: TFecha);
            procedure SetSiguiente(ListaReservas : TListaReservas);

            { Métodos de obtención de atributos }
            function GetFecha: TFecha;
            function GetSiguiente: PTListaReservas;

            { Operaciones propias de la clase }
            procedure AddReserva(Reserva : PTReserva);
            function BuscarReserva(Telefono : integer; Nombre : String):TReserva;
            procedure AnularReserva(Telefono : integer; Nombre : String);
            function ExisteReserva(Telefono : integer; Nombre : String):boolean;


        end;

implementation

              {Constructor}

              constructor TListaReservas.Create();
              begin
                   Self.FReservas := NIL;
                   Self.FSiguienteLista := NIL;
              end;

              { Métodos de asignación de atributos }

              procedure SetFecha(Fecha: TFecha);
              begin
                   Self.FFecha.Dia := Fecha.Dia;
                   Self.FFecha.Mes := Fecha.Mes;
              end;

              procedure SetSiguiente(ListaReservas : TListaReservas);
              begin
                   Self.FSiguienteLista^ :=  ListaReservas;
              end;

              { Métodos de obtención de atributos }

              function GetFecha: TFecha;
              begin
                   GetFecha:=Self.FFecha;
              end;

              function GetSiguiente: PTListaReservas;
              begin
                   GetSiguiente := Self.FSiguienteLista;
              end;

              { Operaciones propias de la clase }

              {AddReserva}
              procedure AddReserva(Reserva : PTReserva);
              begin
                   Reserva^.FSiguiente := Self.FReservas;
                   Self.FReservas^ := Reserva;
              end;

              {BuscarReserva}
               // TODO: Revisar si este método funciona.
              function BuscarReserva(Telefono : integer; Nombre : String):TReserva;
               var
                 encontrado : boolean;
                 auxFecha : PTListaReservas;
                 auxRes : PTReserva
              begin
                   encontrado := false;
                   // Empieza a buscar por el principio
                   auxFecha^ := Self;
                   auxRes := auxFecha^.FReservas;
                   while not encontrado do
                   begin
                        // Si encuentra la reserva o llega al final de la lista
                        // devuelve el puntero que corresponda
                        if ((auxRes^.GetNombre() = Nombre and auxRes^.GetTelefono() = Telefono)) then
                          begin
                               encontrado := true;
                               Self.BuscarReserva := auxRes;
                          end;
                        // Si no la encuentra continua por el siguiente
                        // hasta que lo haga o llegue al final de la lista de reservas
                        else
                            auxRes := FReservas.FSiguiente
                            if  (auxRes = NIL) then
                                begin
                                     auxFecha^ := Self.FSiguiente;
                                     if (auxFecha = NIL) then
                                        begin
                                             encontrado := true;
                                             Self.BuscarReserva := auxRes;
                                        end;
                                     else
                                         auxRes := auxFecha^.FReservas;
                                end;

                        end; // if
                   end; // while
              end; // BuscarReserva

            {AnularReserva}
            // No se si este metodo está correcto.
            // No entiendo bien la implementacion de TReserva
            // Creo que este método debería implementarse en TReserva
            procedure AnularReserva(Telefono : integer; Nombre : String);
            var
               index : 1..4;
               i :integer
            begin
                 if Self.ExisteReserva(Telefono,Nombre) then
                 begin
                     index := Self.BuscarReserva(Telefono,Nombre).GetCantidad();
                     for i := 1 to index do
                     begin
                          Self.BuscarReserva(Telefono,Nombre).GetLocalidad[index].SetEstado := Libre;
                     end;
                 end;
            end;}

            {ExisteReserva}
            function ExisteReserva(Telefono : integer; Nombre : String):boolean;
            begin
                 if (Self.BuscarReserva(Telefono,Nombre) <> NIL) then
                    ExisteReserva := true
                 else
                     ExisteReserva := false;
            end;


end.

