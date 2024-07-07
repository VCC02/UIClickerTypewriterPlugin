{
    Copyright (C) 2024 VCC
    creation date: 05 Jul 2024
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


unit StringDiffLoader;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Diff, HashUnit{, FGL}, IntegerList;


type
  TDiffLoader = class
  private
    FDiff: TDiff;

    FH1, FH2: TCardinalList;

    FLeftStringIndex: array of Integer;
    FRightStringIndex: array of Integer;

    FStr1, FStr2: string;

    procedure BuildHashes;
  public
    constructor Create;
    destructor Destroy; override;

    function CompareStrings: Integer;
    function LoadStrings(AStr1, AStr2: string): Integer;
    function GetSourceIndexLeft(ADiffIndex: Integer): Integer;
    function GetSourceIndexRight(ADiffIndex: Integer): Integer;
    function GetDiffAtIndex(ADiffIndex: Integer): Byte;
  end;

implementation


constructor TDiffLoader.Create;
begin
  inherited Create;

  FDiff := TDiff.Create(nil);
  FH1 := TCardinalList.Create;
  FH2 := TCardinalList.Create;
end;


destructor TDiffLoader.Destroy;
begin
  FDiff.Free;
  FH1.Free;
  FH2.Free;

  inherited Destroy;
end;


procedure TDiffLoader.BuildHashes;
var
  i: Integer;
begin
  FH1.Clear;
  for i := 1 to Length(FStr1) do
    FH1.Add(DWord(HashLine(FStr1[i], False, False)));     //typecasting to DWord should be fine even on 64-bit, since no pointer operation is done

  FH2.Clear;
  for i := 1 to Length(FStr2) do
    FH2.Add(DWord(HashLine(FStr2[i], False, False)));     //typecasting to DWord should be fine even on 64-bit, since no pointer operation is done
end;


function TDiffLoader.CompareStrings: Integer;
var
  i: Integer;
begin
  BuildHashes;

  FDiff.Execute(FH1, FH2);  //FDiff.Execute(FStr1, FStr2);   //the string version of Execute gives worse results than the integer one

  if FDiff.Cancelled then
  begin
    Result := 0;
    Exit;
  end;

  Result := FDiff.Count;

  SetLength(FLeftStringIndex, Result);
  SetLength(FRightStringIndex, Result);

  for i := 0 to FDiff.Count - 1 do
  begin
    FLeftStringIndex[i] := -1;
    FRightStringIndex[i] := -1;
  end;

  for i := 0 to FDiff.Count - 1 do
  begin
    if FDiff.Compares[i].Kind <> ckAdd then
      FLeftStringIndex[i] := FDiff.Compares[i].oldIndex1;

    if FDiff.Compares[i].Kind <> ckDelete then
      FRightStringIndex[i] := FDiff.Compares[i].oldIndex2;
  end;
end;


function TDiffLoader.LoadStrings(AStr1, AStr2: string): Integer;
begin
  FStr1 := AStr1;
  FStr2 := AStr2;
  Result := CompareStrings;
end;


function TDiffLoader.GetSourceIndexLeft(ADiffIndex: Integer): Integer;  //ADiffIndex goes up to FDiff.Count.
begin
  try
    Result := FLeftStringIndex[ADiffIndex];
  except
    Result := -1;   //the caller should expect -1 for an exception and not actually use it as an index
  end;
end;


function TDiffLoader.GetSourceIndexRight(ADiffIndex: Integer): Integer;  //ADiffIndex goes up to FDiff.Count.
begin
  try
    Result := FRightStringIndex[ADiffIndex];
  except
    Result := -1;   //the caller should expect -1 for an exception and not actually use it as an index
  end;
end;


function TDiffLoader.GetDiffAtIndex(ADiffIndex: Integer): Byte;
begin
  try
    Result := Ord(FDiff.Compares[ADiffIndex].Kind);
  except
    Result := 0;
  end;
end;

end.

