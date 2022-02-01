import 'package:baranh/app_screens/contact_information.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

Widget drawerItems2(context) {
  return StatefulBuilder(builder: (context, changeState) {
    num total = 0;
    num cost = 0;
    getTotal() {
      for (var item in cartItems) {
        total += num.parse(item["sale_price"]) * item["qty"];
      }
      return total;
    }

    getCost() {
      for (var item in cartItems) {
        cost += num.parse(item["cost"] ?? "0") * item["qty"];
      }
      return cost;
    }

    cost = getCost();
    return ColoredBox(
      color: myBlack.withOpacity(.9),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: dynamicWidth(context, 0.04),
        ),
        child: Column(
          children: [
            dividerRowWidgets(context, "YOUR CART", ""),
            Divider(
              thickness: 1,
              color: myWhite.withOpacity(0.5),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: dynamicHeight(context, 0.01),
                  ),
                  child: cartCards(context, index, () {
                    changeState(() {});
                  }),
                );
              },
            )),
            dividerRowWidgets(
                context, "TOTAL: ", "PKR " + getTotal().toString(),
                check: true),
            heightBox(context, 0.02),
            coloredButton(
              context,
              "Place Order",
              myGreen,
              fontSize: 0.035,
              function: () async {
                if (cartItems.isEmpty) {
                  MotionToast.info(
                    description: const Text("Cart is empty"),
                    dismissable: true,
                  ).show(context);
                } else {
                  if (userResponse == "Guest") {
                    push(
                        context,
                        ContactInformation(
                          seats: getTotal().toString(),
                          dropDownTime: getCost().toString(),
                          date: "",
                          onlineOrderCheck: true,
                        ));
                  } else {}
                }
              },
            ),
            heightBox(context, 0.02),
            coloredButton(
              context,
              "CONTINUE ORDERING",
              noColor,
              fontSize: 0.035,
              function: () {
                pop(context);
              },
            )
          ],
        ),
      ),
    );
  });
}

cartCards(context, index, function) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.network(
        cartItems[index]["photo"] ??
            "https://neurologist-ahmedabad.com/wp-content/themes/apexclinic/images/no-image/No-Image-Found-400x264.png",
        height: dynamicWidth(context, 0.2),
        width: dynamicWidth(context, 0.15),
        fit: BoxFit.cover,
      ),
      FittedBox(
        child: SizedBox(
          width: dynamicWidth(context, 0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              text(
                context,
                cartItems[index]["name"].toString(),
                0.04,
                myWhite,
              ),
              heightBox(context, 0.01),
              Container(
                  width: dynamicWidth(context, 0.25),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(dynamicWidth(context, 0.02)),
                      border: Border.all(color: myWhite, width: 1)),
                  child: StatefulBuilder(builder: (context, changeState) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          splashColor: noColor,
                          onTap: () {
                            if (int.parse(cartItems[index]["qty"].toString()) >
                                1) {
                              changeState(() {
                                var value = int.parse(
                                    cartItems[index]["qty"].toString());
                                value--;
                                cartItems[index]["qty"] = value;
                              });
                            }
                          },
                          child: SizedBox(
                            width: dynamicWidth(context, .1),
                            height: dynamicWidth(context, .07),
                            child: Icon(
                              Icons.remove,
                              size: dynamicWidth(context, .03),
                              color: myOrange,
                            ),
                          ),
                        ),
                        Text(
                          cartItems[index]["qty"].toString(),
                          style: TextStyle(
                            color: myOrange,
                            fontSize: dynamicWidth(context, .03),
                          ),
                        ),
                        InkWell(
                          splashColor: noColor,
                          onTap: () {
                            if (int.parse(cartItems[index]["qty"].toString()) <
                                30) {
                              changeState(() {
                                var value = int.parse(
                                    cartItems[index]["qty"].toString());
                                value++;
                                cartItems[index]["qty"] = value;
                              });
                            }
                          },
                          child: SizedBox(
                            width: dynamicWidth(context, .1),
                            height: dynamicWidth(context, .07),
                            child: Icon(
                              Icons.add,
                              size: dynamicWidth(context, .03),
                              color: myOrange,
                            ),
                          ),
                        ),
                      ],
                    );
                  })),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {
          cartItems.remove(cartItems[index]);
          menuRefresh();
          function();
        },
        child: const Icon(
          Icons.close,
          color: myWhite,
        ),
      )
    ],
  );
}

Widget dividerRowWidgets(context, text1, text2,
    {check = false, function = ""}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: dynamicHeight(context, 0.01)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text(context, text1, 0.04, myWhite),
        check == true
            ? text(
                context,
                "$text2",
                0.04,
                myWhite,
              )
            : InkWell(
                onTap: () {
                  pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: myWhite,
                  size: dynamicWidth(context, .08),
                ),
              ),
      ],
    ),
  );
}
