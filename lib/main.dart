import 'dart:convert';

import 'package:baranh/app_screens/basic_page.dart';
import 'package:baranh/app_screens/login.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/widgets/essential_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  bool loaderNow = false;
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Baranh Team',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primaryColor,
          textTheme: GoogleFonts.sourceSansProTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: StatefulBuilder(builder: (context, changeState) {
          checkLoginStatus(context);
          return loaderNow == true
              ? loader(context)
              : const BasicPage();
        }));
  }
}

checkLoginStatus(context1) async {
  SharedPreferences loginUser = await SharedPreferences.getInstance();
  dynamic temp = loginUser.getString("userResponse");
  userResponse = temp == null ? "" : await json.decode(temp);

  if (temp == null) {
    Navigator.pushAndRemoveUntil(
        context1,
        MaterialPageRoute(
          builder: (context1) => const LoginScreen(),
        ),
        (route) => false);
  }
}
