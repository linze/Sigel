{    This file is part of Sigel.

    Sigel is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Sigel is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Sigel.  If not, see <http://www.gnu.org/licenses/>. }
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

