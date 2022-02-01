import 'package:baranh/app_screens/choice.dart';

import 'package:baranh/app_screens/new_reservations.dart';

import 'package:baranh/app_screens/profile.dart';
import 'package:baranh/app_screens/qr_screen.dart';

import 'package:baranh/utils/config.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class BasicPage extends StatefulWidget {
  const BasicPage({Key? key}) : super(key: key);

  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> with TickerProviderStateMixin {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var hintText = "mm/dd/yyy";
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
        child: bodyPage(pageDecider),
        opacity: _animation,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: indexPage,
        onTap: (value) {
          if (value == 0) {
            pageDecider = "Home";
          } else if (value == 1) {
            pageDecider = "New Reservations";
          } else if (value == 2) {
            pageDecider = "Online order";
          } else if (value == 3) {
            pageDecider = "QR Scan";
          } else if (value == 4) {
            pageDecider = "Profile";
          } else {
            pageDecider = "Home";
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
            icon: Icon(Icons.qr_code),
            label: "QR Scan",
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
      case "Home":
        return const Home();
      case "QR Scan":
        return const QRScreen();
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
