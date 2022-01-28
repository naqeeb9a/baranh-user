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

import '../main.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
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
                    userResponse['name'].toString().toUpperCase(),
                    .06,
                    myOrange,
                    bold: true,
                  ),
                  heightBox(context, .01),
                  text(context, userResponse['phone'], .04, myWhite),
                  text(context, userResponse['email'], .04, myWhite),
                ],
              )
            ],
          ),
          const Divider(
            color: myWhite,
          ),
          Column(
            children: [
              profileRow(context, LineIcons.history, "My Orders", function: () {
                push(context, const OrderHistory());
              }),
              profileRow(context, Icons.contact_support, "Customer Care",
                  function: () {
                push(context, const CustomerCare());
              }),
              profileRow(context, Icons.logout_rounded, "Log Out",
                  function: () async {
                SharedPreferences loginUser =
                    await SharedPreferences.getInstance();
                loginUser.clear();
                userResponse = "";
                checkLoginStatus(context);
              }),
            ],
          ),
        ],
      ),
    );
  }
}

Widget profileRow(context, icon, title, {function = ""}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: dynamicHeight(context, .01),
    ),
    child: InkWell(
      onTap: function == "" ? () {} : function,
      child: Container(
        width: dynamicWidth(context, .7),
        height: dynamicHeight(context, .056),
        decoration: BoxDecoration(
          color: myWhite,
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, 1),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: dynamicWidth(context, .04),
          ),
          child: Row(
            children: [
              LineIcon(
                icon,
                color: myBlack,
                size: dynamicHeight(context, .04),
              ),
              widthBox(context, .04),
              text(
                context,
                title,
                .044,
                myBlack,
                bold: true,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
