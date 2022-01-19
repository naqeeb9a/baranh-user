import 'package:baranh/app_screens/customer_care.dart';
import 'package:baranh/app_screens/arrived_guests.dart';
import 'package:baranh/app_screens/online_order.dart';
import 'package:baranh/app_screens/new_reservations.dart';
import 'package:baranh/app_screens/order_history.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class BasicPage extends StatefulWidget {
  const BasicPage({Key? key}) : super(key: key);

  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> with TickerProviderStateMixin {
  var hintText = "mm/dd/yyy";

  @override
  Widget build(BuildContext context) {
    customContext = context;
    return Scaffold(
      backgroundColor: myBlack,
      body: bodyPage(pageDecider),
    );
  }

  bodyPage(String page) {
    switch (page) {
      case "New Reservations":
        return const NewReservationsPage();
      case "Online order":
        return const OnlineOrder();
      case "Active Order":
        return const ActiveOrders();
      case "Order History":
        return const OrderHistory();
      case "Customer Care":
        return const CustomerCare();

      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            text(context, "error", .06, myWhite),
          ],
        );
    }
  }
}
