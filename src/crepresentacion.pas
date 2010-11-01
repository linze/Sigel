unit CRepresentacion;

{$mode objfpc}{$H+}

interface

uses
  CSala;

type
    PTRepresentacion = ^TRepresentacion;
    TRepresentacion = record
                    SiguienteRepresentacion : PTRepresentacion;
                    Sala : TSala;
    end;


implementation
end.

