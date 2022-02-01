import 'package:badges/badges.dart';
import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/widgets/drawer.dart';
import 'package:baranh/widgets/menu_widgets.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnlineOrder extends StatefulWidget {
  final String outletId;
  const OnlineOrder({Key? key, required this.outletId}) : super(key: key);
  @override
  State<OnlineOrder> createState() => _OnlineOrderState();
}

class _OnlineOrderState extends State<OnlineOrder> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  dynamic checkState;
  @override
  Widget build(BuildContext context) {
    outletNoGlobal = widget.outletId;
    return Scaffold(
      key: _key,
      endDrawer: Drawer(child: drawerItems2(context)),
      backgroundColor: myBlack,
      body: WillPopScope(
        onWillPop: () async {
          cartItems.clear();
          return true;
        },
        child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(milliseconds: 0), () {
              setState(() {});
            });
          },
          child: SizedBox(
            width: dynamicWidth(context, 1),
            child: Column(
              children: [
                heightBox(context, 0.02),
                Expanded(
                  child: FutureBuilder(
                    future: getMenu(widget.outletId),
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
                                  InkWell(
                                    onTap: () {
                                      showSearch(
                                        context: context,
                                        delegate: CustomSearchDelegate(
                                            snapshot.data["menu"]),
                                      ).then((value) => changeState(() {}));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              dynamicWidth(context, 0.05)),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              cartItems.clear();
                                              pop(context);
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.arrow_back,
                                                  color: myWhite,
                                                ),
                                                widthBox(context, 0.05),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: myWhite,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          dynamicWidth(
                                                              context, 0.1))),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    isDense: true,
                                                    border:
                                                        const UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide
                                                                    .none),
                                                    hintText: "Search",
                                                    enabled: false,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                dynamicWidth(
                                                                    context,
                                                                    0.05),
                                                            vertical:
                                                                dynamicHeight(
                                                                    context,
                                                                    0.012))),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                _key.currentState!
                                                    .openEndDrawer();
                                              },
                                              child: Row(
                                                children: [
                                                  widthBox(context, 0.05),
                                                  Obx(() {
                                                    return Badge(
                                                      badgeContent: text(
                                                          context,
                                                          cartItems.length
                                                              .toString(),
                                                          0.02,
                                                          myWhite),
                                                      child: const Icon(
                                                        Icons.shopping_basket,
                                                        color: myWhite,
                                                      ),
                                                    );
                                                  }),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  heightBox(context, 0.02),
                                  text(context, "Categories", 0.04, myWhite,
                                      bold: true),
                                  heightBox(context, 0.03),
                                  SizedBox(
                                    height: dynamicWidth(context, 0.28),
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            snapshot.data["categories"].length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: dynamicWidth(
                                                    context, 0.02)),
                                            child: categoryCircle(
                                                context,
                                                snapshot.data["categories"],
                                                index),
                                          );
                                        }),
                                  ),
                                  Divider(
                                    color: myWhite,
                                    endIndent: dynamicWidth(context, 0.3),
                                    indent: dynamicWidth(context, 0.3),
                                  ),
                                  heightBox(context, 0.005),
                                  text(context, "Menu", 0.04, myWhite,
                                      bold: true),
                                  heightBox(context, 0.01),
                                  StatefulBuilder(
                                      builder: (context, changeState) {
                                    menuRefresh = () {
                                      changeState(() {});
                                    };
                                    return Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                dynamicWidth(context, 0.03)),
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
                                            }),
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
        ),
      ),
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
