unit CreditosFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls;

type

  { TfrmCreditos }

  TfrmCreditos = class(TForm)
      Bevel1: TBevel;
      Button1: TButton;
      Image1: TImage;
      Label1: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      Label4: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmCreditos: TfrmCreditos;

implementation

{ TfrmCreditos }


procedure TfrmCreditos.Button1Click(Sender: TObject);
begin
    Self.Close;
end;

initialization
  {$I creditosfrm.lrs}

end.

