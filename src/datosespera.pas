unit DatosEspera;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Spin, CTipoLocalidad, uFuncionesComunes;

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
      procedure btnAceptarClick(Sender: TObject);
      procedure btnCancelarClick(Sender: TObject);
      procedure cbTipoChange(Sender: TObject);
      procedure eNombreKeyPress(Sender: TObject; var Key: char);
      procedure eTelefonoExit(Sender: TObject);
      procedure eTelefonoKeyPress(Sender: TObject; var Key: char);
      procedure GroupBox2Click(Sender: TObject);
  private
    { private declarations }
  public
    DatosIntroducidos : boolean;
    Nombre: string;
    Telefono: string;
    Email: string;
    Cantidad : Integer;
    Tipo : TTipoLocalidad;
  end;

var
  frmDatosEspera: TfrmDatosEspera;

implementation

{ TfrmDatosEspera }

procedure TfrmDatosEspera.GroupBox2Click(Sender: TObject);
begin

end;

procedure TfrmDatosEspera.btnAceptarClick(Sender: TObject);
begin
  if (eNombre.Text <> '') and ((eTelefono.Text <> '') or (eEmail.Text <> '')) and (cbTipo.Text <> '') then
  begin
    Nombre := eNombre.Text;
    Telefono := eTelefono.Text;
    Email := eEmail.Text;
    Cantidad := seCantidad.Value;
    if cbTipo.Text = 'Patio' then
    begin
       Tipo := Patio;
       Self.DatosIntroducidos := True;
       Self.Close;
    end
    else if cbTipo.Text = 'Primera Planta' then
     begin
        Tipo := PrimeraPlanta;
        Self.DatosIntroducidos := True;
        Self.Close;
     end
     else if cbTipo.Text = 'Palco' then
          begin
             Tipo := Palco;
             if Cantidad > 1 then
                  ShowMessage('Solo puede seleccionar un palco')
             else
             begin
                 Self.DatosIntroducidos := True;
                 Self.Close;
             end;
          end;
  end
    else
        ShowMessage('Debe introducir los datos');
end;

procedure TfrmDatosEspera.btnCancelarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmDatosEspera.cbTipoChange(Sender: TObject);
begin

end;

procedure TfrmDatosEspera.eNombreKeyPress(Sender: TObject; var Key: char);
begin
    Key := uFuncionesComunes.EsLetra(Key);
end;

procedure TfrmDatosEspera.eTelefonoExit(Sender: TObject);
var
    LongitudErronea, ComienzoErroneo : boolean;
begin
    if (Sender as TEdit).Text <> '' then
    begin
        LongitudErronea := (Length((Sender as TEdit).Text) < 9) or (Length((Sender as TEdit).Text) > 9);
        if LongitudErronea then
        begin
            ShowMessage('Numero de teléfono incorrecto. Se han de introducir 9 dígitos');
            (Sender as TEdit).Focused;
        end
        else
        begin
            ComienzoErroneo := (((Sender as TEdit).Text[1] <> '9') and ((Sender as TEdit).Text[1] <> '6'));
            if ComienzoErroneo then
            begin
                ShowMessage('Numero de teléfono incorrecto. Debe comenzar por 9 o por 6');
            end;
        end;
    end;
end;

procedure TfrmDatosEspera.eTelefonoKeyPress(Sender: TObject; var Key: char);
begin
    Key := uFuncionesComunes.EsNumero(Key);
end;



initialization
  {$I datosespera.lrs}

end.

