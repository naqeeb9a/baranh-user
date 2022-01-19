import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

Widget text(context, text, size, color,
    {bold = false, alignText = TextAlign.start}) {
  return Text(
    text,
    textAlign: alignText,
    style: TextStyle(
      color: color,
      fontSize: dynamicWidth(context, size),
      fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
    ),
  );
}
