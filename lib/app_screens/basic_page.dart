import 'package:baranh/app_screens/arrived_guests.dart';
import 'package:baranh/app_screens/choice.dart';
import 'package:baranh/app_screens/customer_care.dart';
import 'package:baranh/app_screens/home.dart';
import 'package:baranh/app_screens/new_reservations.dart';
import 'package:baranh/app_screens/order_history.dart';
import 'package:baranh/app_screens/profile.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'Cart.dart';

class BasicPage extends StatefulWidget {
  const BasicPage({Key? key}) : super(key: key);

  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> with TickerProviderStateMixin {
  late AnimationController _controller;

  startAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  late Animation<double> _animation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var hintText = "mm/dd/yyy";

  @override
  Widget build(BuildContext context) {
    staticRefresh = () {
      setState(() {});
    };
    startAnimation();
    customContext = context;
    return Scaffold(
      extendBody: true,
      backgroundColor: myBlack,
      body: FadeTransition(
        opacity: _animation,
        child: bodyPage(pageDecider),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            if (value == 0) {
              pageDecider = "Home";
            } else if (value == 1) {
              pageDecider = "New Reservations";
            } else if (value == 2) {
              pageDecider = "Online order";
            } else if (value == 3) {
              pageDecider = "Cart";
            } else if (value == 4) {
              pageDecider = "Profile";
            } else {
              pageDecider = "Home";
            }
            index = value;
          });
        },
        unselectedItemColor: myWhite,
        unselectedIconTheme: const IconThemeData(color: myWhite),
        selectedItemColor: myOrange,
        backgroundColor: myBlack.withOpacity(0.7),
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: "Reserve",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  bodyPage(String page) {
    switch (page) {
      case "New Reservations":
        return const NewReservationsPage();
      case "Online order":
        return const Choice();
      case "Active Order":
        return const ActiveOrders();
      case "Order History":
        return const OrderHistory();
      case "Customer Care":
        return const CustomerCare();
      case "Home":
        return const Home();
      case "Cart":
        return const Cart();
      case "Profile":
        return const Profile();

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
