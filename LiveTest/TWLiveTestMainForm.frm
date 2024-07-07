object frmTWLiveTestMain: TfrmTWLiveTestMain
  Left = 373
  Height = 280
  Top = 185
  Width = 540
  Caption = 'Typewriter Live Test'
  ClientHeight = 280
  ClientWidth = 540
  Constraints.MinHeight = 280
  Constraints.MinWidth = 540
  LCLVersion = '8.4'
  object grpEditboxToBeEdited: TGroupBox
    Left = 8
    Height = 72
    Top = 8
    Width = 432
    Caption = 'Editbox to be edited'
    ClientHeight = 52
    ClientWidth = 428
    TabOrder = 0
    object edtEditboxToBeEdited: TEdit
      Left = 8
      Height = 23
      Top = 8
      Width = 416
      TabOrder = 0
    end
  end
  object btnReset: TButton
    Left = 456
    Height = 25
    Hint = 'Reset to initial string'
    Top = 32
    Width = 75
    Caption = 'Reset'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnResetClick
  end
  object grpInitialStringEditbox: TGroupBox
    Left = 8
    Height = 72
    Top = 96
    Width = 432
    Caption = 'InitialString editbox'
    ClientHeight = 52
    ClientWidth = 428
    TabOrder = 2
    object edtInitialString: TEdit
      Left = 8
      Height = 23
      Top = 8
      Width = 416
      TabOrder = 0
      Text = 'This is a text to be diff-ed from F1.'
    end
  end
  object grpWhatToBecomeEditbox: TGroupBox
    Left = 8
    Height = 72
    Top = 192
    Width = 432
    Caption = 'WhatToBecome editbox'
    ClientHeight = 52
    ClientWidth = 428
    TabOrder = 3
    object edtDestinationString: TEdit
      Left = 8
      Height = 23
      Top = 8
      Width = 416
      TabOrder = 0
      Text = 'This was a long text to be diff-ed in F2.'
    end
  end
end
