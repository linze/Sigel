unit CRepresentacion;

{$mode objfpc}{$H+}

interface

uses
  CPRepresentacion,CSala;

type
    TRepresentacion = record
                    SiguienteRepresentacion : TPRepresentacion;
                    Sala : TSala;
    end;

implementation
end.

