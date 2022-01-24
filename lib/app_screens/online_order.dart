import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/widgets/menu_widgets.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

class OnlineOrder extends StatefulWidget {
  const OnlineOrder({Key? key}) : super(key: key);

  @override
  State<OnlineOrder> createState() => _OnlineOrderState();
}

class _OnlineOrderState extends State<OnlineOrder> {
  bool _showFab = true;
  dynamic checkState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
        child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(milliseconds: 0), () {
              setState(() {});
            });
          },
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
                            child: text(
                                context, "No Items in Menu", 0.04, myWhite),
                          );
                        } else {
                          return StatefulBuilder(
                              builder: (context, changeState) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: dynamicWidth(context, 0.3),
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          snapshot.data["categories"].length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  dynamicWidth(context, 0.03)),
                                          child: categoryCircle(
                                              context,
                                              snapshot.data["categories"],
                                              index),
                                        );
                                      }),
                                ),
                                InkWell(
                                  onTap: () {
                                    showSearch(
                                      context: context,
                                      delegate:
                                          CustomSearchDelegate(snapshot.data["menu"]),
                                    ).then((value) => changeState(() {}));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: myWhite,
                                        borderRadius: BorderRadius.circular(
                                            dynamicWidth(context, 0.1))),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          isDense: true,
                                          border: const UnderlineInputBorder(
                                              borderSide: BorderSide.none),
                                          hintText: "Search",
                                          enabled: false,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal:
                                                  dynamicWidth(context, 0.05),
                                              vertical: dynamicHeight(
                                                  context, 0.012))),
                                    ),
                                  ),
                                ),
                                heightBox(context, 0.02),
                                StatefulBuilder(
                                    builder: (context, changeState) {
                                  menuRefresh = () {
                                    changeState(() {});
                                  };
                                  return Expanded(
                                    child: NotificationListener<
                                            UserScrollNotification>(
                                        onNotification: (notification) {
                                          final ScrollDirection direction =
                                              notification.direction;

                                          if (direction ==
                                              ScrollDirection.reverse) {
                                            _showFab = false;
                                            checkState();
                                          } else if (direction ==
                                              ScrollDirection.forward) {
                                            _showFab = true;
                                            checkState();
                                          }

                                          return true;
                                        },
                                        child: ListView.builder(
                                            itemCount:
                                                snapshot.data["menu"].length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: dynamicHeight(
                                                        context, 0.01)),
                                                child: menuCards(
                                                    context,
                                                    snapshot.data["menu"],
                                                    index),
                                              );
                                            })),
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
      ),
      floatingActionButton: StatefulBuilder(builder: (context, stateNotify) {
        checkState = () {
          stateNotify(() {});
        };
        return AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          offset: _showFab ? Offset.zero : const Offset(0, 2),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _showFab ? 1 : 0,
            child: FloatingActionButton.extended(
              isExtended: true,
              onPressed: () {},
              backgroundColor: myOrange,
              label: Row(
                children: [
                  LineIcon(
                    LineIcons.bell,
                    color: myWhite,
                    size: dynamicWidth(context, 0.04),
                  ),
                  widthBox(context, 0.01),
                  text(context, "Call waiter", 0.03, myWhite,
                      alignText: TextAlign.center, bold: true),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

categoryCircle(context, snapshot, index) {
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: myWhite,
        radius: dynamicWidth(context, 0.08),
        child: CircleAvatar(
          radius: dynamicWidth(context, 0.075),
          backgroundImage: const NetworkImage(
              "https://cdn.pixabay.com/photo/2016/12/26/17/28/spaghetti-1932466__340.jpg"),
        ),
      ),
      heightBox(context, 0.01),
      text(context, snapshot[index]["category_name"], 0.04, myWhite)
    ],
  );
}
