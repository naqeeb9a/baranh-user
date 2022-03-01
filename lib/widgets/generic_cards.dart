import 'package:baranh/app_functions/fcm_services.dart';
import 'package:baranh/app_screens/new_reservations.dart';
import 'package:baranh/app_screens/order_summary_page.dart';
import 'package:baranh/app_screens/verification_screen.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/green_buttons.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import 'essential_widgets.dart';

genericCards(function, {check = false}) {
  return FutureBuilder(
    future: function,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.data == false) {
          return retry(context);
        } else if (snapshot.data[0]["status"] == false) {
          return Center(
              child: text(
                  context,
                  check == true
                      ? ("No orders on Table no : " +
                          snapshot.data[0]["table_name"].toString())
                      : "No Orders found",
                  0.04,
                  myWhite));
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return genericCardsExtension(
                  context, snapshot.data, index, check);
            },
          );
        }
      } else {
        return loader(context);
      }
    },
  );
}

genericCardsExtension(context, snapshot, index, check) {
  globalWaiterId = snapshot[index]["waiter_id"];
  globalTableId = snapshot[index]["table_name"];
  return Container(
    margin: EdgeInsets.symmetric(vertical: dynamicHeight(context, 0.01)),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(dynamicWidth(context, 0.015)),
        border: Border.all(width: 1, color: myWhite.withOpacity(0.5))),
    padding: EdgeInsets.all(dynamicWidth(context, 0.04)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: text(
              context,
              snapshot[index]["table_name"] == null
                  ? "Order no : " + snapshot[index]["sale_no"]
                  : "Table no : " +
                      snapshot[index]["table_name"].toString().toString(),
              0.04,
              myWhite,
              bold: true),
        ),
        Divider(
          thickness: 1,
          color: myWhite.withOpacity(0.5),
        ),
        text(
            context,
            snapshot[index]["outlet_id"].toString() == "1"
                ? "Outlet : Baranh Lahore"
                : "Outlet : Baranh Jhang",
            0.035,
            myWhite),
        text(context, "Customer Name: " + snapshot[index]["customer_name"],
            0.035, myWhite),
        Visibility(
          visible: snapshot[index]["waiter_name"] == null ? false : true,
          child: text(
              context,
              "Waiter: " + snapshot[index]["waiter_name"].toString(),
              0.035,
              myWhite),
        ),
        text(
            context,
            "Date/Order Time: " +
                snapshot[index][check == true ? "booking_date" : "sale_date"]
                    .toString() +
                " | " +
                getConvertedTime(snapshot[index]["order_time"]
                    .toString()
                    .substring(0, snapshot[index]["order_time"].length - 3)),
            0.035,
            myWhite),
        text(
            context,
            "Total items: " + snapshot[index]["total_items"].toString(),
            0.035,
            myWhite),
        text(
            context,
            "Total: " + snapshot[index]["sub_total_with_discount"].toString(),
            0.035,
            myWhite),
        Visibility(
          visible: snapshot[index]["paid_amount"] == null ? false : true,
          child: Align(
              alignment: Alignment.center,
              child: text(
                context,
                "Paid Amount\n PKR." +
                    (snapshot[index]["paid_amount"] ?? "0").toString(),
                0.04,
                myWhite,
                bold: true,
                alignText: TextAlign.center,
              )),
        ),
        heightBox(context, 0.02),
        Row(
          mainAxisAlignment: check == true
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.center,
          children: [
            Visibility(
                visible: true,
                child: greenButtons(
                    context,
                    snapshot[index]["verification_status"]
                                .toString()
                                .toLowerCase() ==
                            "unverified"
                        ? "Verify"
                        : "View Details", function: () {
                  if (snapshot[index]["verification_status"]
                          .toString()
                          .toLowerCase() ==
                      "unverified") {
                    push(
                      context,
                      VerifyCode(
                        saleId: snapshot[index]["id"],
                      ),
                    );
                  } else {
                    push(context,
                        OrderSummaryPage(saleId: snapshot[index]["id"]));
                  }
                })),
            Visibility(
                visible: check == true ? true : false,
                child:
                    greenButtons(context, "Request Bill", function: () async {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.info,
                      backgroundColor: myOrange,
                      title: "Select your payment method",
                      confirmBtnText: "Card",
                      showCancelBtn: true,
                      confirmBtnColor: myOrange,
                      cancelBtnTextStyle: const TextStyle(
                          color: myOrange, fontWeight: FontWeight.bold),
                      cancelBtnText: "Cash",
                      onCancelBtnTap: () async {
                        Navigator.of(context, rootNavigator: true).pop();
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.loading,
                            lottieAsset: "assets/cash.json",
                            text: "Requesting Bill .....",
                            barrierDismissible: false);
                        if (globalWaiterId != null || globalWaiterId != null) {
                          var temp = FCMServices.sendFCM(
                            'waiter',
                            63,
                            "Table no : $globalTableId",
                            "Requesting bill via Cash",
                          );

                          try {
                            await temp.then((value) {
                              Navigator.of(context, rootNavigator: true).pop();
                              MotionToast.success(
                                description:
                                    const Text("Bill requested successfully"),
                                dismissable: true,
                              ).show(context);
                            });
                          } catch (e) {
                            Navigator.of(context, rootNavigator: true).pop();
                            MotionToast.error(
                              description: const Text(
                                  "Sorry we can't request your Bill check your internet or Ask yourself"),
                              dismissable: true,
                            ).show(context);
                          }
                        }
                      },
                      onConfirmBtnTap: () async {
                        Navigator.of(context, rootNavigator: true).pop();
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.loading,
                            lottieAsset: "assets/card.json",
                            text: "Requesting Bill .....",
                            barrierDismissible: false);
                        if (globalWaiterId != null || globalWaiterId != null) {
                          var temp = FCMServices.sendFCM(
                            'waiter',
                            63,
                            "Table no : $globalTableId",
                            "Requesting bill via Card",
                          );

                          try {
                            await temp.then((value) {
                              Navigator.of(context, rootNavigator: true).pop();
                              MotionToast.success(
                                description:
                                    const Text("Bill requested successfully"),
                                dismissable: true,
                              ).show(context);
                            });
                          } catch (e) {
                            Navigator.of(context, rootNavigator: true).pop();
                            MotionToast.error(
                              description: const Text(
                                  "Sorry we can't request your Bill check your internet or Ask yourself"),
                              dismissable: true,
                            ).show(context);
                          }
                        }
                      });
                })),
          ],
        )
      ],
    ),
  );
}
