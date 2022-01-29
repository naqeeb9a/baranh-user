import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

bar(
  context,
) {
  return AppBar(
    backgroundColor: myBlack,
    title: Center(
      child: Image.asset(
        "assets/logo.png",
        width: dynamicWidth(context, 0.2),
      ),
    ),
    automaticallyImplyLeading: false,
    centerTitle: true,
    bottom: PreferredSize(
      child: Container(
        color: myWhite.withOpacity(0.5),
        height: 1,
      ),
      preferredSize: const Size.fromHeight(4.0),
    ),
  );
}

loader(context) {
  return Center(
    child: LottieBuilder.asset(
      "assets/loader.json",
      width: dynamicWidth(context, 0.3),
    ),
  );
}
