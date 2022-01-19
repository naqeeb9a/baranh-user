import 'package:badges/badges.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

bar(
  context, {
  function = "",
  function1 = "",
}) {
  return AppBar(
    backgroundColor: myBlack,
    title: Center(
      child: Image.asset(
        "assets/logo.png",
        width: dynamicWidth(context, 0.2),
      ),
    ),
    leading: GestureDetector(
      onTap: function == "" ? () {} : function,
      child: Image.asset(
        "assets/menu.png",
        scale: 30,
      ),
    ),
    centerTitle: true,
    actions: [
      InkWell(
        onTap: function1 == "" ? () {} : function1,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, .02),
          ),
          child: Obx(() {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Badge(
                position: BadgePosition.topEnd(),
                badgeContent: text(
                  context,
                  cartItems.length.toString(),
                  0.02,
                  myWhite,
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            );
          }),
        ),
      ),
      widthBox(context, 0.01)
    ],
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
