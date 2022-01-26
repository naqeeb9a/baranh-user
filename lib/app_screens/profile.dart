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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: dynamicHeight(context, .04),
            ),
            child: Container(
              width: dynamicWidth(context, .9),
              height: dynamicHeight(context, .2),
              decoration: BoxDecoration(
                color: myWhite,
                borderRadius: BorderRadius.circular(
                  dynamicWidth(context, .04),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: dynamicWidth(context, .3),
                    height: dynamicHeight(context, .2),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: dynamicWidth(context, 1),
            height: dynamicHeight(context, .4),
            // color: myWhite.withOpacity(.4),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                0.0,
                0.9,
              ],
              colors: [
                myOrange,
                myBlack,
              ],
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                heightBox(context, .1),
                CircleAvatar(
                  radius: dynamicWidth(context, .16),
                  backgroundColor: myWhite,
                  child: LineIcon(
                    LineIcons.user,
                    size: dynamicWidth(context, .22),
                  ),
                ),
                text(context, userResponse['name'], .05, myWhite),
                text(context, userResponse['phone'], .05, myWhite),
                text(context, userResponse['email'], .05, myWhite),
                heightBox(context, .02),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
