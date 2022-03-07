import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/essential_widgets.dart';
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          text(context, "Select one city to proceed", .056, myWhite,
              bold: true, alignText: TextAlign.center),
          heightBox(context, .06),
          FutureBuilder(
            future: getOutlets(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == false) {
                  return retry(context);
                } else {
                  return Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      runSpacing: dynamicHeight(context, .01),
                      children: snapshot.data
                          .map<Widget>((i) => GestureDetector(
                              onTap: () {
                                push(context,
                                    OnlineOrder(outletId: i["id"].toString()));
                              },
                              child: branchCard(
                                  context,
                                  i["outlet_name"].toString(),
                                  "https://pos.baranh.pk/" +
                                      i["image"].toString())))
                          .toList(),
                    ),
                  );
                }
              } else {
                return loader(context);
              }
            },
          ),
        ],
      ),
    );
  }
}

Widget branchCard(context, text1, image) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: dynamicHeight(context, .08),
          backgroundColor: myOrange,
          child: CircleAvatar(
            radius: dynamicHeight(context, .076),
            onBackgroundImageError: (e, error) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.error,
                  color: myWhite,
                ),
                text(context, "no image", 0.04, myWhite)
              ],
            ),
            backgroundImage: NetworkImage(image),
          ),
        ),
        heightBox(context, .02),
        text(context, text1, .04, myWhite),
      ],
    ),
  );
}
