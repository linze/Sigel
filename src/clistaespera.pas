unit CListaEspera;

{$mode objfpc}{$H+}

interface
    uses
        CFecha, CEspera;
    type

        PTListaEspera = ^TListaEspera;
        TListaEspera = record
            FFechas        : TFecha;
            FEsperas       : PTEspera;
            FSiguiente     : PTListaEspera;
        end;
        
implementation

end.
