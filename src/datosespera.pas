unit DatosEspera;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Spin;

type

  { TfrmDatosEspera }

  TfrmDatosEspera = class(TForm)
      btnAceptar: TButton;
      btnCancelar: TButton;
      cbTipo: TComboBox;
      eNombre: TEdit;
      eTelefono: TEdit;
      eEmail: TEdit;
      GroupBox1: TGroupBox;
      GroupBox2: TGroupBox;
      Label1: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      Label5: TLabel;
      Label6: TLabel;
      seCantidad: TSpinEdit;
      procedure GroupBox2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmDatosEspera: TfrmDatosEspera;

implementation

{ TfrmDatosEspera }

procedure TfrmDatosEspera.GroupBox2Click(Sender: TObject);
begin

end;

initialization
  {$I datosespera.lrs}

end.

