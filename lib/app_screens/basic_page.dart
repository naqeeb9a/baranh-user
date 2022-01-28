import 'package:baranh/app_screens/arrived_guests.dart';
import 'package:baranh/app_screens/choice.dart';
import 'package:baranh/app_screens/customer_care.dart';
import 'package:baranh/app_screens/home.dart';
import 'package:baranh/app_screens/new_reservations.dart';
import 'package:baranh/app_screens/order_history.dart';
import 'package:baranh/app_screens/profile.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/widgets/essential_widgets.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cart.dart';

class BasicPage extends StatefulWidget {
  const BasicPage({Key? key}) : super(key: key);

  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> with TickerProviderStateMixin {
  final pageController = PageController(initialPage: 0);
  final MaterialColor primaryColor = const MaterialColor(
    0xff000000,
    <int, Color>{
      50: Color(0xff000000),
      100: Color(0xff000000),
      200: Color(0xff000000),
      300: Color(0xff000000),
      400: Color(0xff000000),
      500: Color(0xff000000),
      600: Color(0xff000000),
      700: Color(0xff000000),
      800: Color(0xff000000),
      900: Color(0xff000000),
    },
  );
  var hintText = "mm/dd/yyy";

  @override
  Widget build(BuildContext context) {
    staticRefresh = () {
      setState(() {});
    };

    customContext = context;
    return Scaffold(
      appBar: bar(context),
      extendBody: true,
      backgroundColor: myBlack,
      body: PageView(
        onPageChanged: (value) => setState(() {
          indexPage = value;
        }),
        controller: pageController,
        children: [
          const Home(),
          const NewReservationsPage(),
          MaterialApp(
              title: 'Baranh Team',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: primaryColor,
                textTheme: GoogleFonts.sourceSansProTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              home: const Choice()),
          const Cart(),
          const Profile()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: indexPage,
        onTap: (value) {
          if (value == 0) {
            pageController.animateToPage(0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeIn);
          } else if (value == 1) {
            pageController.animateToPage(1,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeIn);
          } else if (value == 2) {
            pageController.animateToPage(2,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeIn);
          } else if (value == 3) {
            pageController.animateToPage(3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeIn);
          } else if (value == 4) {
            pageController.animateToPage(4,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeIn);
          } else {
            pageController.animateToPage(0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeIn);
          }
          setState(() {
            indexPage = value;
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
