import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'essential_widgets.dart';

genericCards() {
  return FutureBuilder(
    future: getOrderHistory(userResponse["id"]),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.data == false) {
          return retry(context);
        } else if (snapshot.data.length == 0 ||
            snapshot.data == "Nothing found!") {
          return text(context, "No Order History", 0.04, myWhite);
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
            "Order : " + snapshot[index]["sale_no"].toString().toString(),
            0.04,
            myWhite,
            bold: true),
        Divider(
          thickness: 1,
          color: myWhite.withOpacity(0.5),
        ),
        text(context, "Date: " + snapshot[index]["sale_date"].toString(), 0.035,
            myWhite),
        text(context, "Time: " + snapshot[index]["order_time"].toString(),
            0.035, myWhite),
        text(
            context,
            "Total items: " + snapshot[index]["total_items"].toString(),
            0.035,
            myWhite),
        text(
            context,
            "Discount: " +
                snapshot[index]["sub_total_discount_value"].toString(),
            0.035,
            myWhite),
        text(context, "Sub total: " + snapshot[index]["sub_total"].toString(),
            0.035, myWhite),
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
      ],
    ),
  );
}
