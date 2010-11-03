unit CObjectListItem;

{$mode objfpc}{$H+}

interface

    uses
        Classes, SysUtils;
    type
        TObjectListItem = class (TPersistent)
        public
            procedure LeerDatos (Lector : TReader); virtual; abstract;
            procedure EscribirDatos (Escritor: TWriter); virtual; abstract;
        end;

implementation

end.

