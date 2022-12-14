import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/generic_cards.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: myBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.05),
          ),
          child: Column(
            children: [
              heightBox(context, 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: myWhite,
                    ),
                  ),
                  text(context, "My Orders", 0.05, myWhite),
                  const Icon(
                    Icons.arrow_back,
                    color: myBlack,
                  ),
                ],
              ),
              heightBox(context, 0.01),
              const Divider(
                thickness: 1,
                color: myWhite,
              ),
              Expanded(child: genericCards(getOrderHistory(userResponse["id"])))
            ],
          ),
        ),
      ),
    );
  }
}
