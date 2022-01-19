import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/buttons_column.dart';
import 'package:baranh/widgets/custom_search.dart';
import 'package:baranh/widgets/essential_widgets.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'input_field_home.dart';

Widget tableCards(context, function, buttonText1, buttonText2,
    {setState = "", visible = false, visibleButton = true}) {
  final TextEditingController _tableNo = TextEditingController();
  var assignTable = 0;
  return FutureBuilder(
    future: function,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.data == false) {
          return retry(
            context,
          );
        } else if (snapshot.data.length == 0) {
          return Center(child: text(context, "No orders Yet!!", 0.04, myWhite));
        } else {
          return Column(
            children: [
              Visibility(
                  visible: visible,
                  child: Column(
                    children: [
                      heightBox(context, 0.02),
                      InkWell(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: CustomDineInSearchDelegate(
                              snapshot.data,
                              setState,
                              assignTable,
                              buttonText1,
                              buttonText2,
                            ),
                          );
                        },
                        child: inputFieldsHome(
                          pageDecider == "Waiting For Arrival" ||
                                  pageDecider == "Arrived Guests"
                              ? "Search"
                              : "Table no:",
                          pageDecider == "Waiting For Arrival" ||
                                  pageDecider == "Arrived Guests"
                              ? "Ex: Name / phone"
                              : "Ex: table no",
                          context,
                          enable: false,
                          controller: _tableNo,
                        ),
                      ),
                      heightBox(context, 0.03),
                    ],
                  )),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(const Duration(milliseconds: 0), () {
                      setState();
                    });
                  },
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return tableCardsExtension(context, snapshot.data, index,
                          buttonText1, buttonText2,
                          function: setState,
                          assignTable: assignTable,
                          visibleButton: visibleButton);
                    },
                  ),
                ),
              ),
            ],
          );
        }
      } else {
        return loader(context);
      }
    },
  );
}

Widget tableCardsExtension(
    context, snapshotTable, indexTable, buttonText1, buttonText2,
    {function = "", assignTable, visibleButton = true}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: dynamicHeight(context, 0.01)),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(dynamicWidth(context, 0.015)),
        border: Border.all(width: 1, color: myWhite.withOpacity(0.5))),
    padding: EdgeInsets.all(dynamicWidth(context, 0.04)),
    child: Column(
      children: [
        snapshotTable[indexTable]["table_id"] == null
            ? text(
                context,
                snapshotTable[indexTable]["customer_name"]
                    .toString()
                    .toString(),
                0.04,
                myWhite)
            : text(
                context,
                "Table: " + snapshotTable[indexTable]["table_name"].toString(),
                0.04,
                myWhite),
        Divider(
          thickness: 1,
          color: myWhite.withOpacity(0.5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                    context,
                    "Order: " + snapshotTable[indexTable]["sale_no"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Name: " +
                        snapshotTable[indexTable]["customer_name"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Phone: " +
                        snapshotTable[indexTable]["customer_phone"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Date: " +
                        snapshotTable[indexTable]["booking_date"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Time: " +
                        snapshotTable[indexTable]["opening_time"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Seats: " +
                        snapshotTable[indexTable]["booked_seats"].toString(),
                    0.035,
                    myWhite),
                text(
                    context,
                    "Status: " +
                        snapshotTable[indexTable]["usage_status"].toString(),
                    0.035,
                    myWhite),
              ],
            ),
            buttonsColumn(context, buttonText1, buttonText2, snapshotTable,
                indexTable, assignTable, function, visibleButton)
          ],
        )
      ],
    ),
  );
}
