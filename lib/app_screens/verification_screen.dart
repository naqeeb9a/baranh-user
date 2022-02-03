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

class VerifyCode extends StatefulWidget {
  final String saleId;

  const VerifyCode({
    Key? key,
    required this.saleId,
  }) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final verifyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                  onTap: () {
                    pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: myWhite,
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(context, "Verify Code", 0.07, myWhite, bold: true),
                heightBox(context, 0.02),
                text(
                    context,
                    "A Verify Code has been sent to your mail check and enter the verification code below",
                    0.03,
                    myWhite),
              ],
            ),
            inputFieldsHome("Verfication Code", "Example : 0001", context,
                controller: verifyController,
                keyBoardType: TextInputType.number,
                width: 0.5),
            coloredButton(context, "Verify", myOrange,
                width: dynamicWidth(context, 0.3), function: () async {
              CoolAlert.show(
                  context: context,
                  type: CoolAlertType.loading,
                  barrierDismissible: false,
                  lottieAsset: "assets/loader.json");
              var response =
                  await getVerified(widget.saleId, verifyController.text);
              if (response == false) {
                Navigator.of(context, rootNavigator: true).pop();
                MotionToast.error(
                  description: const Text("Check your internet or try again"),
                  dismissable: true,
                ).show(context);
              } else {
                Navigator.of(context, rootNavigator: true).pop();
                popUntil(context);
                MotionToast.success(
                  description: const Text("Verified Successfully"),
                  dismissable: true,
                ).show(context);
              }
            })
          ],
        ),
      ),
    );
  }
}
