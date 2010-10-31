unit CRepresentacion;

{$mode objfpc}{$H+}

interface

uses
  CSala;

type
    TPRepresentacion = ^TRepresentacion;
    TRepresentacion = record
                    SiguienteRepresentacion : TPRepresentacion;
                    Sala : TSala;
    end;


implementation
end.

