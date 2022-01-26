import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: SizedBox(

      width: dynamicWidth(context, 1),
      height: dynamicHeight(context, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: dynamicWidth(context, .18),
              backgroundColor: myOrange,
              child: Center(
                child: LineIcon(
                  LineIcons.user,
                  color: myBlack,
                  size: dynamicHeight(context, .1),
                ),
              ),
            ),
            heightBox(context, .03),
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
            heightBox(context, .06),
            profileRow(context, LineIcons.history, "Order History"),
            profileRow(context, Icons.contact_support, "Customer Care"),
            profileRow(context, Icons.logout_rounded, "Log Out"),
          ],
        ),
      ),
    );
  }
}

Widget profileRow(context, icon, title) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: dynamicHeight(context, .01),
    ),
    child: Container(
      width: dynamicWidth(context, .7),
      height: dynamicHeight(context, .056),
      decoration: BoxDecoration(
        color: myOrange,
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
  );
}
