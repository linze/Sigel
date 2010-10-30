unit CTipoListaEspera;

{$mode objfpc}{$H+}

interface
    uses
        CFecha, CPTipoListaEspera, CTipoEspera;
    type

        TPListaEspera = ^TListaEspera;
        FFechas        : TFecha;
        FEsperas       : TPEspera;
        FSiguiente     : TPListaEspera;
        
implementation

end.
