unit DatosEspera; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs; 

type
  TfrmDatosEspera = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmDatosEspera: TfrmDatosEspera;

implementation

initialization
  {$I datosespera.lrs}

end.

