import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/drawer.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.loading,
                        barrierDismissible: false,
                        lottieAsset: "assets/loader.json");
                    var response = await punchOrder(total, cost);
                    if (response == false) {
                      Navigator.of(context, rootNavigator: true).pop();
                      MotionToast.error(
                        description:
                            const Text("Server Error or check your internet"),
                        dismissable: true,
                      ).show(context);
                    } else {
                      Navigator.of(context, rootNavigator: true).pop();
                      cartItems.clear();
                      saleIdGlobal = "";
                      tableNoGlobal = "";

                      pop(context);
                      popUntil(globalDineInContext);
                      globalDineInRefresh();
                      CoolAlert.show(
                          title: "Order Placed",
                          text: "Do you wish to proceed?",
                          context: context,
                          loopAnimation: true,
                          backgroundColor: myOrange,
                          confirmBtnColor: myOrange,
                          confirmBtnText: "Continue",
                          type: CoolAlertType.success,
                          animType: CoolAlertAnimType.slideInRight);
                    }
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
                  pageDecider = "Online Order";
                  staticRefresh();
                },
              ),
              heightBox(context, 0.1)
            ],
          ),
        ),
      );
    });
  }
}
