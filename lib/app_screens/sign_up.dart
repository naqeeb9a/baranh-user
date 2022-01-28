import 'dart:convert';

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

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  signUpFunction() async {
    try {
      setState(() {
        loading = true;
      });
      var response = await http.post(
          Uri.parse(callBackUrl+"/api/register-customer"),
          body: {
            "yourname": name.text,
            "phone": phone.text,
            "address": address.text,
            "email": email.text,
            "password": password.text
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
              padding: EdgeInsets.symmetric(
                horizontal: dynamicWidth(context, 0.05),
              ),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: dynamicHeight(context, 1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/logo.png",
                            width: dynamicWidth(context, 0.46),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text(context, "Your Name", .044, myWhite),
                              SizedBox(
                                height: dynamicHeight(context, 0.01),
                              ),
                              inputTextField(
                                context,
                                "Your Name",
                                name,
                              ),
                              SizedBox(
                                height: dynamicHeight(context, 0.01),
                              ),
                              text(context, "Phone", .044, myWhite),
                              SizedBox(
                                height: dynamicHeight(context, 0.01),
                              ),
                              inputTextField(
                                context,
                                "Phone",
                                phone,
                              ),
                              SizedBox(
                                height: dynamicHeight(context, 0.01),
                              ),
                              text(context, "Address:", .044, myWhite),
                              SizedBox(
                                height: dynamicHeight(context, 0.01),
                              ),
                              inputTextField(
                                context,
                                "Address",
                                address,
                              ),
                              SizedBox(
                                height: dynamicHeight(context, 0.01),
                              ),
                              text(context, "Email", .044, myWhite),
                              SizedBox(
                                height: dynamicHeight(context, 0.01),
                              ),
                              inputTextField(
                                context,
                                "Email",
                                email,
                              ),
                              SizedBox(
                                height: dynamicHeight(context, 0.01),
                              ),
                              text(context, "Password", .044, myWhite),
                              SizedBox(
                                height: dynamicHeight(context, 0.01),
                              ),
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
                            ],
                          ),
                          coloredButton(
                            context,
                            "REGISTER",
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
                              } else if (name.text.isEmpty ||
                                  phone.text.isEmpty ||
                                  address.text.isEmpty) {
                                MotionToast.error(
                                  title: const Text("Error"),
                                  dismissable: true,
                                  description:
                                      const Text("Fill all the fields"),
                                ).show(context);
                              } else {
                                var response = await signUpFunction();

                                if (response == "Error") {
                                  setState(() {
                                    loading = false;
                                  });
                                  MotionToast.error(
                                    title: const Text("Error"),
                                    dismissable: true,
                                    description: const Text(
                                        "Invalid Information Provided Try Again"),
                                  ).show(context);
                                } else if (response == false) {
                                  setState(() {
                                    loading = false;
                                  });
                                  MotionToast.error(
                                    title: const Text("Error"),
                                    dismissable: true,
                                    description: const Text(
                                        "Check your Internet or try again later"),
                                  ).show(context);
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                  pop(context);
                                  MotionToast.success(
                                    title:
                                        const Text("Successfully Registered"),
                                    dismissable: true,
                                    description: const Text(
                                        "You have successfully signed up now please login"),
                                  ).show(context);
                                }
                              }
                            },
                          ),
                          InkWell(
                            onTap: () {
                              pop(context);
                            },
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Already have an account? ",
                                    style: TextStyle(color: myWhite),
                                  ),
                                  TextSpan(
                                    text: "LogIn",
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
    name.dispose();
    phone.dispose();
    address.dispose();
    super.dispose();
  }
}
