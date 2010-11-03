unit ReservaFrm; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs; 

type

  { TfrmReserva }

  TfrmReserva = class(TForm)
      procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmReserva: TfrmReserva;

implementation

{ TfrmReserva }

procedure TfrmReserva.FormCreate(Sender: TObject);
begin

end;

initialization
  {$I reservafrm.lrs}

end.

