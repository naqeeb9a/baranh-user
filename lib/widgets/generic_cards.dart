import 'package:baranh/app_screens/order_summary_page.dart';
import 'package:baranh/app_screens/verification_screen.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/green_buttons.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'essential_widgets.dart';

genericCards(function) {
  return FutureBuilder(
    future: function,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.data == false) {
          return retry(context);
        } else if (snapshot.data.length == 0 ||
            snapshot.data == "Nothing found!") {
          return Center(child: text(context, "No Orders Found", 0.04, myWhite));
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return genericCardsExtension(context, snapshot.data, index);
            },
          );
        }
      } else {
        return loader(context);
      }
    },
  );
}

genericCardsExtension(context, snapshot, index) {
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
        text(
            context,
            snapshot[index]["table_name"] == null
                ? "Order no : " + snapshot[index]["sale_no"]
                : "Table no : " +
                    snapshot[index]["table_name"].toString().toString(),
            0.04,
            myWhite,
            bold: true),
        Divider(
          thickness: 1,
          color: myWhite.withOpacity(0.5),
        ),
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
            "Date and Time: " +
                snapshot[index]["sale_date"].toString() +
                " " +
                snapshot[index]["order_time"].toString(),
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
        Align(
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
        Align(
          alignment: Alignment.center,
          child: Visibility(
              visible: true,
              child: Column(
                children: [
                  heightBox(context, 0.02),
                  greenButtons(
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
                  }),
                ],
              )),
        )
      ],
    ),
  );
}
