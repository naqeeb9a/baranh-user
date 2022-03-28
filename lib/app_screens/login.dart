import 'dart:convert';

import 'package:baranh/app_screens/forgot_password.dart';
import 'package:baranh/app_screens/sign_up.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/form_fields.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

  loginFunction() async {
    try {
      setState(() {
        loading = true;
      });
      var response = await http
          .post(Uri.parse(callBackUrl + "/api/signin-customer"), body: {
        "emailphone": email.text,
        "password": password.text
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        return http.Response('Error', 408);
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        return jsonData["data"];
      } else {
        return "Error";
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: (loading == true)
          ? Center(
              child: LottieBuilder.asset(
                "assets/loader.json",
                width: dynamicWidth(context, 0.3),
              ),
            )
          : Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: dynamicHeight(context, 1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                SharedPreferences loginUser =
                                    await SharedPreferences.getInstance();
                                loginUser.setString(
                                  "userResponse",
                                  "Guest",
                                );
                                setState(() {
                                  pageDecider = "Home";
                                });
                                pushAndRemoveUntil(
                                  context,
                                  const MyApp(),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                      radius: dynamicWidth(context, 0.05),
                                      backgroundColor: myOrange,
                                      child: text(
                                          context, "Skip", 0.03, myWhite,
                                          bold: true)),
                                  const Icon(
                                    Icons.double_arrow,
                                    color: myOrange,
                                  )
                                ],
                              )),
                          Image.asset(
                            "assets/logo.png",
                            width: dynamicWidth(context, 0.46),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              heightBox(context, .06),
                              text(context, "Email", .044, myWhite),
                              heightBox(context, .01),
                              inputTextField(
                                context,
                                "Email",
                                email,
                              ),
                              heightBox(context, .01),
                              text(context, "Password", .044, myWhite),
                              heightBox(context, .01),
                              inputTextField(
                                context,
                                "Password",
                                password,
                                password: true,
                                function2: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                              ),
                              heightBox(context, .01),
                              InkWell(
                                onTap: () {
                                  push(context, const ForgotPassword());
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: text(context, "Forgot password", 0.04,
                                      myWhite),
                                ),
                              )
                            ],
                          ),
                          coloredButton(
                            context,
                            "SIGN IN",
                            myOrange,
                            width: dynamicWidth(context, .5),
                            function: () async {
                              if (!EmailValidator.validate(email.text)) {
                                MotionToast.error(
                                  title: const Text("Error"),
                                  dismissable: true,
                                  description:
                                      const Text("Please enter valid email!"),
                                ).show(context);
                              } else if (password.text.isEmpty) {
                                MotionToast.error(
                                  title: const Text("Error"),
                                  dismissable: true,
                                  description: const Text(
                                      "Please enter valid password!"),
                                ).show(context);
                              } else {
                                var response = await loginFunction();
                                if (response == "Error") {
                                  setState(() {
                                    loading = false;
                                  });
                                  MotionToast.error(
                                    title: const Text("Error"),
                                    dismissable: true,
                                    description:
                                        const Text("Invalid Credentials"),
                                  ).show(context);
                                } else if (response == false) {
                                  setState(() {
                                    loading = false;
                                  });
                                  MotionToast.error(
                                    title: const Text("Error"),
                                    dismissable: true,
                                    description: const Text(
                                      "Check your Internet or try again later",
                                    ),
                                  ).show(context);
                                } else {
                                  SharedPreferences loginUser =
                                      await SharedPreferences.getInstance();
                                  loginUser.setString(
                                    "userResponse",
                                    json.encode(response),
                                  );
                                  setState(() {
                                    pageDecider = "Home";
                                  });
                                  pushAndRemoveUntil(
                                    context,
                                    const MyApp(),
                                  );
                                }
                              }
                            },
                          ),
                          InkWell(
                            onTap: () {
                              push(context, const SignUp());
                            },
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(color: myWhite),
                                  ),
                                  TextSpan(
                                    text: "Sign up",
                                    style: TextStyle(
                                      color: myOrange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
