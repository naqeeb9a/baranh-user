import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/essential_widgets.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class OrderSummaryPage extends StatefulWidget {
  final String saleId;

  const OrderSummaryPage({Key? key, required this.saleId}) : super(key: key);

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
          child: Column(
            children: [
              heightBox(context, 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    pop(context);
                  },
                  child: const Icon(
                    LineIcons.arrowLeft,
                    color: myWhite,
                  ),
                ),
              ),
              heightBox(context, 0.02),
              FutureBuilder(
                future: getOrderSummary(widget.saleId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null) {
                      return Expanded(
                        child: Center(
                          child: text(
                            context,
                            "No details",
                            0.04,
                            myWhite,
                          ),
                        ),
                      );
                    } else if (snapshot.data == false) {
                      return Expanded(
                          child: retry(
                        context,
                      ));
                    } else {
                      return orderDetails(context, snapshot.data);
                    }
                  } else {
                    return Expanded(child: loader(context));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

billRow(context, text1, text2, size, color) {
  return Column(
    children: [
      const Divider(
        thickness: 1,
        color: myWhite,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(context, text1, size, color),
          text(context, text2, size, color),
        ],
      ),
      const Divider(
        thickness: 1,
        color: myWhite,
      ),
    ],
  );
}

orderDetails(context, snapshot) {
  return Column(
    children: [
      heightBox(context, 0.05),
      text(context, "ORDER DETAILS #" + snapshot[0]["sale_no"], 0.05, myWhite),
      const Divider(
        thickness: 1,
        color: myWhite,
      ),
      heightBox(context, 0.05),
      (snapshot[0]["sale_details"].length == 0)
          ? text(
              context,
              "No items ordered yet!",
              0.04,
              myWhite,
            )
          : SizedBox(
              width: dynamicWidth(context, .7),
              height: dynamicHeight(context, .52),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot[0]["sale_details"].length,
                itemBuilder: (BuildContext context, int index) {
                  return viewOrderCard(
                    context,
                    snapshot[0]["sale_details"],
                    index,
                  );
                },
              ),
            ),
      heightBox(context, 0.02),
      billRow(
        context,
        "Total",
        "PKR " + snapshot[0]["sub_total_with_discount"],
        0.03,
        myWhite,
      ),
    ],
  );
}

viewOrderCard(context, snapshot, index) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: dynamicHeight(context, 0.01),
    ),
    height: dynamicHeight(context, .064),
    decoration: BoxDecoration(
      color: noColor,
      borderRadius: BorderRadius.circular(
        dynamicWidth(context, 0.02),
      ),
      border: Border.all(
        color: myWhite,
      ),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: dynamicWidth(context, .02),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text(
              context,
              "${index + 1}. ",
              0.03,
              myWhite,
              alignText: TextAlign.center,
            ),
          ],
        ),
        widthBox(context, .04),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dynamicWidth(context, 0.02),
              ),
              child: text(
                context,
                snapshot[index]["menu_name"].toString(),
                0.03,
                myWhite,
                alignText: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dynamicWidth(context, 0.02),
              ),
              child: text(
                context,
                "Rs ." +
                    snapshot[index]["menu_unit_price"] +
                    " x " +
                    snapshot[index]["qty"].toString(),
                0.03,
                myWhite,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
