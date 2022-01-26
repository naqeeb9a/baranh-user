import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/input_field_home.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
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
                text(context, "Forgot password:", 0.04, myWhite, bold: true),
                heightBox(context, 0.02),
                text(
                    context,
                    "A reset password mail will be sent to your Entered email",
                    0.04,
                    myWhite),
              ],
            ),
            inputFieldsHome("Email", "Enter your email", context,
                controller: email, keyBoardType: TextInputType.emailAddress),
            coloredButton(context, "Send", myOrange, function: () async {
              if (email.text.isEmpty) {
                MotionToast.info(
                  description: const Text("Enter an email"),
                  dismissable: true,
                ).show(context);
              } else {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.loading,
                    barrierDismissible: false,
                    lottieAsset: "assets/loader.json");
                var response =
                    await sendEmailForgotPassword(email.text.toString());
                if (response == "No Email") {
                  Navigator.of(context, rootNavigator: true).pop();
                  MotionToast.error(
                    description: const Text("No Account linked to this email"),
                    dismissable: true,
                  ).show(context);
                } else if (response == false) {
                  Navigator.of(context, rootNavigator: true).pop();
                  MotionToast.error(
                    description: const Text("Server Error Try again later"),
                    dismissable: true,
                  ).show(context);
                } else {
                  Navigator.of(context, rootNavigator: true).pop();
                  pop(context);
                  MotionToast.success(
                    description:
                        const Text("Successfully sent, Check your email"),
                    dismissable: true,
                  ).show(context);
                }
              }
            })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
