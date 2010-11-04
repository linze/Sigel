unit CreditosFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TfrmCreditos }

  TfrmCreditos = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmCreditos: TfrmCreditos;

implementation

{ TfrmCreditos }

procedure TfrmCreditos.FormCreate(Sender: TObject);
begin

end;

initialization
  {$I creditosfrm.lrs}

end.

