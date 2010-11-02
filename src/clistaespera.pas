unit CListaEspera;

{$mode objfpc}{$H+}

interface

    type
        // TODO: Implementar herencia desde TObjectList
        // NOTE: Contendrá items TEspera
        TListaEspera = class
        private
            FFecha        : TDateTime;
        public
            property Fecha:TDateTime read FFecha write FFecha;
        end;
        
implementation

end.
