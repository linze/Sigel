unit frmDatosCompra;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Spin, uDatos;

type

  { TfrmDatosCompra }

  TfrmDatosCompra = class(TForm)
      Button1: TButton;
      Button2: TButton;
      cbTipo: TComboBox;
      Label1: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      seFila: TSpinEdit;
      seNumero: TSpinEdit;
      procedure Button1Click(Sender: TObject);
      procedure Button2Click(Sender: TObject);
      procedure cbTipoChange(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure Label1Click(Sender: TObject);
      procedure Label2Click(Sender: TObject);
  private
    { private declarations }
  public
  end;

var
  frmDatosCompra: TfrmDatosCompra;

implementation

{ TfrmDatosCompra }

procedure TfrmDatosCompra.cbTipoChange(Sender: TObject);
begin

end;

procedure TfrmDatosCompra.Button1Click(Sender: TObject);
var
    i: integer;
    Found : boolean;
begin
    Found := False;
    for i:=1 to uDatos.

end;

procedure TfrmDatosCompra.Button2Click(Sender: TObject);
begin
    Self.Close;
end;

procedure TfrmDatosCompra.FormCreate(Sender: TObject);
begin

end;

procedure TfrmDatosCompra.Label1Click(Sender: TObject);
begin

end;

procedure TfrmDatosCompra.Label2Click(Sender: TObject);
begin

end;

initialization
  {$I frmdatoscompra.lrs}

end.

