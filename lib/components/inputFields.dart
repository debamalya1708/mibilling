
import 'dart:convert';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildValidationInputField(String labelText, String? prefixText, String? suffixText, {bool numericKeyboard = false, bool readOnly = false}){
  return TextFormField(
    // controller: textEditingControllers[labelText],
    readOnly: readOnly,
    // onChanged: (value){
    //   setState(() {
    //     BlankError = false;
    //     typingInputValue = value == '' || value == null ? value : prefixText! + value + suffixText!;
    //     // widget.finalJsonResponse?[labelText.toLowerCase().camelCase] = (labelText.toLowerCase().camelCase.isNotEmpty ? textEditingControllers[labelText]!.text == '' || textEditingControllers[labelText]!.text == null ? textEditingControllers[labelText]!.text : prefixText! + textEditingControllers[labelText]!.text + suffixText! : "");
    //   });
    // },
    keyboardType: numericKeyboard ? TextInputType.number : TextInputType.text,
    inputFormatters: numericKeyboard ? <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    ] : null,


    decoration: InputDecoration(
      suffixIcon: null,
      filled: true,
      labelText: labelText,
      prefixText: !readOnly ? prefixText : null,
      suffixText: !readOnly ? suffixText : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    validator: (String? value) {
      if (value == null || value == '') {
        return 'Enter $labelText';
      }
      return null;
    },
    autovalidateMode: true ? AutovalidateMode.always : AutovalidateMode.onUserInteraction,
  );
}