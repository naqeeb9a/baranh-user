import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/widgets/menu_widgets.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnlineOrder extends StatefulWidget {
  const OnlineOrder({Key? key}) : super(key: key);

  @override
  State<OnlineOrder> createState() => _OnlineOrderState();
}

class _OnlineOrderState extends State<OnlineOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
        child: Column(
          children: [
            heightBox(context, 0.02),
            text(context, "Menu", 0.05, myWhite),
            const Divider(
              thickness: 1,
              color: myWhite,
            ),
            heightBox(context, 0.02),
            Expanded(
              child: FutureBuilder(
                future: getMenu(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == false) {
                      return retry(
                        context,
                      );
                    } else {
                      if (snapshot.data.length == 0) {
                        return Center(
                          child:
                              text(context, "No Items in Menu", 0.04, myWhite),
                        );
                      } else {
                        return StatefulBuilder(builder: (context, changeState) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showSearch(
                                    context: context,
                                    delegate:
                                        CustomSearchDelegate(snapshot.data),
                                  ).then((value) => changeState(() {}));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: myWhite,
                                      borderRadius: BorderRadius.circular(
                                          dynamicWidth(context, 0.1))),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: const UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: "Search",
                                        enabled: false,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal:
                                                dynamicWidth(context, 0.05))),
                                  ),
                                ),
                              ),
                              heightBox(context, 0.02),
                              StatefulBuilder(builder: (context, changeState) {
                                menuRefresh = () {
                                  changeState(() {});
                                };
                                return Expanded(
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            childAspectRatio:
                                                dynamicWidth(context, 0.5) /
                                                    dynamicWidth(context, 0.5)),
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return menuCards(
                                          context, snapshot.data, index);
                                    },
                                  ),
                                );
                              }),
                            ],
                          );
                        });
                      }
                    }
                  } else {
                    return LottieBuilder.asset(
                      "assets/loader.json",
                      width: dynamicWidth(context, 0.3),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
