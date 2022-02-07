import 'package:baranh/app_screens/customer_care.dart';
import 'package:baranh/app_screens/order_history.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: dynamicHeight(context, .1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: dynamicWidth(context, .1),
                  backgroundColor: myOrange,
                  child: Center(
                    child: LineIcon(
                      LineIcons.user,
                      color: myBlack,
                      size: dynamicHeight(context, .05),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(
                      context,
                      userResponse == "Guest"
                          ? "Guest"
                          : userResponse['name'].toString().toUpperCase(),
                      .06,
                      myOrange,
                      bold: true,
                    ),
                    heightBox(context, .01),
                    text(
                        context,
                        userResponse == "Guest"
                            ? "Features in Guest mode are Limited"
                            : userResponse['phone'],
                        .04,
                        myWhite),
                    text(
                        context,
                        userResponse == "Guest"
                            ? "Sign in to use all features"
                            : userResponse['email'],
                        .04,
                        myWhite),
                  ],
                )
              ],
            ),
          ),
          const Divider(
            color: myWhite,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dynamicWidth(context, 0.02),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                dynamicWidth(context, 0.02),
              ),
              child: Column(
                children: [
                  profileRow(context, LineIcons.history, "My Orders",
                      function: () {
                    if (userResponse == "Guest") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: myOrange,
                          duration: const Duration(seconds: 1),
                          content: text(context, "Sign in to see All Orders",
                              0.04, myWhite)));
                    } else {
                      push(context, const OrderHistory());
                    }
                  }),
                  profileRow(context, Icons.contact_support, "Customer Care",
                      function: () {
                    push(context, const CustomerCare());
                  }),
                  profileRow(context, Icons.info_rounded, "About us",
                      function: () {
                    launch("https://baranh.pk/aboutus");
                  }),
                  profileRow(
                      context,
                      userResponse == "Guest"
                          ? LineIcons.alternateSignIn
                          : Icons.logout_rounded,
                      userResponse == "Guest" ? "Sign in" : "Log Out",
                      function: () async {
                    SharedPreferences loginUser =
                        await SharedPreferences.getInstance();
                    loginUser.clear();
                    userResponse = "";
                    indexPage = 0;
                    checkLoginStatus(globalContextMain);
                  }),

                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: dynamicHeight(context, .12),
            ),
            child: text(
              context,
              "Version: $version",
              .034,
              myWhite,
              alignText: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

Widget profileRow(context, icon, title, {function = ""}) {
  return InkWell(
    onTap: function == "" ? () {} : function,
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: dynamicWidth(context, 0.04),
          horizontal: dynamicWidth(context, 0.02)),
      color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            LineIcon(
              icon,
              color: myWhite,
              size: dynamicHeight(context, .04),
            ),
            widthBox(context, .04),
            text(
              context,
              title,
              .044,
              myWhite,
              bold: true,
            ),
          ]),
          LineIcon(
            Icons.arrow_forward_ios,
            color: myWhite,
          )
        ],
      ),
    ),
  );
}
