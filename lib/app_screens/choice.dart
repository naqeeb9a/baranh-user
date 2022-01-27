import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'online_order.dart';

class Choice extends StatefulWidget {
  const Choice({Key? key}) : super(key: key);

  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text(context, "Select one city to proceed", .056, myWhite,
              bold: true),
          heightBox(context, .06),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  push(
                      context,
                      const OnlineOrder(
                        outletId: "1",
                      ));
                },
                child: branchCard(
                    context, "Baranh Lahore", "assets/baranh_lahore.jpg"),
              ),
              GestureDetector(
                onTap: () {
                  push(
                      context,
                      const OnlineOrder(
                        outletId: "6",
                      ));
                },
                child: branchCard(
                    context, "Baranh Jhang", "assets/baranh_jhang.jpg"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget branchCard(context, text1, image) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        radius: dynamicHeight(context, .08),
        backgroundColor: myOrange,
        child: CircleAvatar(
          radius: dynamicHeight(context, .076),
          backgroundImage: AssetImage(image),
        ),
      ),
      heightBox(context, .02),
      text(context, text1, .04, myWhite),
    ],
  );
}
