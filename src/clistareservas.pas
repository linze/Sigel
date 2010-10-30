unit CListaReservas;

{$mode objfpc}{$H+}

interface

    uses
        CFecha,CPTReserva,CPTListaReservas;

    type

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
            function BuscarReserva(Telefono :


        end;

implementation

end.

