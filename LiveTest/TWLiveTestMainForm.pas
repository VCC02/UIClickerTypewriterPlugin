{
    Copyright (C) 2024 VCC
    creation date: 06 Jul 2024
    initial release date: 07 Jul 2024

    author: VCC
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
    DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
    OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
}


unit TWLiveTestMainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmTWLiveTestMain }

  TfrmTWLiveTestMain = class(TForm)
    btnReset: TButton;
    edtDestinationString: TEdit;
    edtEditboxToBeEdited: TEdit;
    edtInitialString: TEdit;
    grpWhatToBecomeEditbox: TGroupBox;
    grpEditboxToBeEdited: TGroupBox;
    grpInitialStringEditbox: TGroupBox;
    procedure btnResetClick(Sender: TObject);
  private

  public

  end;

var
  frmTWLiveTestMain: TfrmTWLiveTestMain;

implementation

{$R *.frm}

{ TfrmTWLiveTestMain }

procedure TfrmTWLiveTestMain.btnResetClick(Sender: TObject);
begin
  edtEditboxToBeEdited.Text := edtInitialString.Text;
end;

end.

