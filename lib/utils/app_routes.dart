import 'package:flutter/material.dart';

push(context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

pop(context) {
  Navigator.of(context).pop();
}

pushAndRemoveUntil(context, Widget page) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => page,
      ),
      (Route<dynamic> route) => false);
}

popUntil(context) {
  Navigator.popUntil(context, (route) => route.isFirst);
}
