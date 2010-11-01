unit ReservaFrm; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs; 

type
  TfrmReserva = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmReserva: TfrmReserva;

implementation

initialization
  {$I reservafrm.lrs}

end.

