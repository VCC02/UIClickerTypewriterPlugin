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


unit TypewriterPluginProperties;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ClickerUtils;


const
  CMaxRequiredSubControlActions = 1;
  CAdditionalPropertiesCount = 4;
  CPropertiesCount = CMaxRequiredSubControlActions + CAdditionalPropertiesCount;

  CWhatToBecomeVarNamePropertyIndex = 0;
  CCurrentTextVarNamePropertyIndex = 1;
  CTextToBeTypedVarNamePropertyIndex = 2;
  CCurrentTextVarUpdaterActionPropertyIndex = 3;
  CLowLevelTypewriterActionPropertyIndex = 4;

  CWhatToBecomeVarNamePropertyName = 'WhatToBecomeVarName';
  CCurrentTextVarNamePropertyName = 'CurrentTextVarName';
  CTextToBeTypedVarNamePropertyName = 'TextToBeTypedVarName';
  CCurrentTextVarUpdaterActionPropertyName = 'CurrentTextVarUpdaterAction';
  CLowLevelTypewriterActionPropertyName = 'LowLevelTypewriterAction';


  CRequiredPropertyNames: array[0..CPropertiesCount - 1] of string = (  //these are the expected property names, configured in plugin properties
    CWhatToBecomeVarNamePropertyName,
    CCurrentTextVarNamePropertyName,
    CTextToBeTypedVarNamePropertyName,
    CCurrentTextVarUpdaterActionPropertyName,
    CLowLevelTypewriterActionPropertyName
  );

  //property details: (e.g. enum options, hints, icons, menus, min..max spin intervals etc)

  //See TOIEditorType datatype from ObjectInspectorFrame.pas, for valid values
  CRequiredPropertyTypes: array[0..CPropertiesCount - 1] of string = (
    'TextWithArrow', //WhatToBecomeVarName
    'TextWithArrow', //CurrentTextVarName
    'TextWithArrow', //TextToBeTypedVarName
    'TextWithArrow', //CurrentTextVarUpdaterAction
    'TextWithArrow'  //LowLevelTypewriterAction
  );

  CRequiredPropertyDataTypes: array[0..CPropertiesCount - 1] of string = (
    CDTString, //WhatToBecomeVarName
    CDTString, //CurrentTextVarName
    CDTString, //TextToBeTypedVarName
    CDTString, //CurrentTextVarUpdaterAction
    CDTString  //LowLevelTypewriterAction
  );

  CPluginEnumCounts: array[0..CPropertiesCount - 1] of Integer = (
    0, //WhatToBecomeVarName
    0, //CurrentTextVarName
    0, //TextToBeTypedVarName
    0, //CurrentTextVarUpdaterAction
    0  //LowLevelTypewriterAction
  );

  CPluginEnumStrings: array[0..CPropertiesCount - 1] of string = (
    '', //WhatToBecomeVarName
    '', //CurrentTextVarName
    '', //TextToBeTypedVarName
    '', //CurrentTextVarUpdaterAction
    ''  //LowLevelTypewriterAction
  );

  CPluginHints: array[0..CPropertiesCount - 1] of string = (
    'Name of a variable, which contains the (target) text, that should end up in the target editbox.', //WhatToBecomeVarName
    'Name of a variable, which contains the text, that is currently in the target editbox.', //CurrentTextVarName
    'Name of a variable, which will contain the text, that will by typed (including deleting) in the target editbox, either over an empty or a filled in editbox.', //TextToBeTyped
    'Name of an action, from the same template, which updates the variable, pointed to by CurrentTextVarName property.' + #4#5 + 'The action will be called by this plugin. It can be of any action type, which is capable of modifying the CurrentTextVarName variable.' + #4#5 + 'The action reads the current text from the application and updates the variable.' + #4#5 + 'The action should be disabled, to avoid being called automatically at template execution.', //CurrentTextVarUpdaterAction
    'Name of an action, from the same template, which does the actual typing, using the content from the variable pointed to by TextToBeTyped property.' + #4#5 + 'It''s usually a SetControlText action. Can also be a plugin or a CallTemplate action.' + #4#5 + 'The action should be disabled, to avoid being called automatically at template execution.'       //LowLevelTypewriterAction
  );

  CPropertyEnabled: array[0..CPropertiesCount - 1] of string = (  // The 'PropertyValue[<index>]' replacement uses indexes from the following array only. It doesn't count fixed properties.
    '', //WhatToBecomeVarName                        // If empty string, the property is unconditionally enabled. For available operators, see CComp constans in ClickerUtils.pas.
    '', //CurrentTextVarName
    '', //TextToBeTypedVarName
    '', //CurrentTextVarUpdaterAction
    ''  //LowLevelTypewriterAction
  );

  CPluginDefaultValues: array[0..CPropertiesCount - 1] of string = (
    '$WhatToBecome$', //WhatToBecomeVarName
    '$CurrentText$', //CurrentTextVarName
    '$TextToBeTyped$', //TextToBeTypedVarName
    '',      //CurrentTextVarUpdaterAction
    ''       //LowLevelTypewriterAction
  );


function FillInPropertyDetails: string;


implementation


uses
  ClickerActionPlugins;


function FillInPropertyDetails: string;
var
  i: Integer;
begin
  Result := '';

  for i := 0 to CPropertiesCount - 1 do
    Result := Result + CRequiredPropertyNames[i] + '=' + CRequiredPropertyTypes[i] + #8#7 +
                       CPluginPropertyAttr_DataType + '=' + CRequiredPropertyDataTypes[i] + #8#7 +
                       CPluginPropertyAttr_EnumCounts + '=' + IntToStr(CPluginEnumCounts[i]) + #8#7 +
                       CPluginPropertyAttr_EnumStrings + '=' + CPluginEnumStrings[i] + #8#7 +
                       CPluginPropertyAttr_Hint + '=' + CPluginHints[i] + #8#7 +
                       CPluginPropertyAttr_Enabled + '=' + CPropertyEnabled[i] + #8#7 +
                       CPluginPropertyAttr_DefaultValue + '=' + CPluginDefaultValues[i] + #8#7 +
                       #13#10;
end;

end.

