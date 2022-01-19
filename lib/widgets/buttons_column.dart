import 'package:baranh/app_screens/order_summary_page.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/guest_arrived_function.dart';
import 'package:baranh/widgets/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import 'green_buttons.dart';

buttonsColumn(context, buttonText1, buttonText2, snapshotTable, indexTable,
    assignTable, function, visibleButton) {
  return SizedBox(
    height: dynamicHeight(context,
        buttonText1 == "View details" && visibleButton == true ? 0.16 : 0.12),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: buttonText1 == "View details" && visibleButton == true
              ? true
              : false,
          child: greenButtons(
              context, "Change Table", snapshotTable, indexTable, function: () {
            dialogueCustom(
                context, snapshotTable, indexTable, assignTable, function);
          }),
        ),
        greenButtons(context, buttonText1, snapshotTable, indexTable,
            function: () async {
          if (buttonText1 == "View details") {
            push(
                context,
                OrderSummaryPage(
                  saleId: snapshotTable[indexTable]["sale_id"].toString(),
                ));
          } else if (buttonText1 == "Assign Table") {
            dialogueCustom(
                context, snapshotTable, indexTable, assignTable, function);
          } else if (buttonText1 == "Assign Waiter") {
            dialogueCustomWaiter(
                context, snapshotTable, indexTable, assignTable, function);
          } else if (buttonText1 == "Guest Arrived") {
            guestArrivedNow(context, snapshotTable, indexTable);
          } else {
            MotionToast.info(
              description: const Text("Something Went wrong"),
              dismissable: true,
            ).show(context);
          }
        }),
        Visibility(
          visible: visibleButton,
          child: greenButtons(
            context,
            buttonText2,
            snapshotTable,
            indexTable,
            function: () {
              if (buttonText2 == "Assign Waiter") {
                dialogueCustomWaiter(
                    context, snapshotTable, indexTable, assignTable, function);
              } else if (buttonText2 == "Assign Table") {
                dialogueCustom(
                    context, snapshotTable, indexTable, assignTable, function);
              } else if (buttonText2 == "Take Order") {
                // push(
                //     context,
                //     MenuPage(
                //       saleId: snapshotTable[indexTable]["sale_id"].toString(),
                //       tableNo: snapshotTable[indexTable]["table_id"].toString(),
                //     ));
              } else if (buttonText2 == "View details") {
                push(
                  context,
                  OrderSummaryPage(
                    saleId: snapshotTable[indexTable]["sale_id"].toString(),
                  ),
                );
              } else {
                MotionToast.error(
                    description: const Text("Something went Wrong"));
              }
            },
          ),
        ),
      ],
    ),
  );
}
