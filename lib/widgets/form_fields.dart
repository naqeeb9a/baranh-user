import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

import '../utils/config.dart';

Widget inputTextField(context, label, myController,
    {function, function2, password = false}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (function == "")
        ? () {
            return null;
          }
        : function,
    controller: myController,
    textInputAction: TextInputAction.next,
    keyboardType: password == true
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
    obscureText: password == true ? obscureText : false,
    cursorColor: myBlack,
    cursorWidth: 2.0,
    style: TextStyle(
      color: myBlack,
      fontSize: dynamicWidth(context, .04),
    ),
    decoration: InputDecoration(
      fillColor: myWhite,
      focusColor: myWhite,
      hoverColor: myWhite,
      filled: true,
      isDense: true,
      enabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: myBlack),
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .4),
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: myBlack),
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .4),
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: myBlack),
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .4),
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: myBlack),
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .4),
        ),
      ),
      border: UnderlineInputBorder(
        borderSide: const BorderSide(color: myBlack),
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .4),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: dynamicHeight(context, .014),
        horizontal: dynamicWidth(context, .05),
      ),
    ),
  );
}
