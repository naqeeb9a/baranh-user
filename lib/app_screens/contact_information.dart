import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/app_screens/verification_screen.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/input_field_home.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:motion_toast/motion_toast.dart';

class ContactInformation extends StatefulWidget {
  final String seats, dropDownTime, date, outletID;
  final bool onlineOrderCheck;
  const ContactInformation(
      {Key? key,
      required this.seats,
      required this.outletID,
      required this.dropDownTime,
      required this.date,
      required this.onlineOrderCheck})
      : super(key: key);

  @override
  State<ContactInformation> createState() => _ContactInformationState();
}

class _ContactInformationState extends State<ContactInformation> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              heightBox(context, 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    pop(context);
                  },
                  child: const Icon(
                    LineIcons.arrowLeft,
                    color: myWhite,
                  ),
                ),
              ),
              heightBox(context, 0.05),
              text(
                context,
                "CONTACT INFORMATION",
                0.05,
                myWhite,
              ),
              heightBox(context, 0.02),
              inputFieldsHome(
                "Your Name",
                "Enter Your Name",
                context,
                controller: _name,
              ),
              heightBox(context, 0.02),
              inputFieldsHome(
                "Phone",
                "Enter Phone Number",
                context,
                keyBoardType: TextInputType.number,
                controller: _phone,
                generatePasswordCheck: true,
              ),
              heightBox(context, 0.02),
              inputFieldsHome("Address", "Enter Address", context,
                  controller: _address,
                  keyBoardType: TextInputType.emailAddress),
              heightBox(context, 0.02),
              inputFieldsHome(
                "Email",
                "someone@gmail.com",
                context,
                keyBoardType: TextInputType.emailAddress,
                controller: _email,
              ),
              heightBox(context, 0.04),
              coloredButton(
                  context,
                  widget.onlineOrderCheck == true ? "Place Order" : "Submit",
                  myOrange, function: () async {
                if (_name.text.isEmpty || _phone.text.isEmpty) {
                  MotionToast.info(
                    description: const Text("Fill all fields appropriately"),
                    dismissable: true,
                  ).show(context);
                } else if (_email.text.isNotEmpty &&
                    !_email.text.contains("@")) {
                  MotionToast.info(
                    description: const Text("Enter a Valid Email"),
                    dismissable: true,
                  ).show(context);
                } else if (widget.onlineOrderCheck == true) {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.loading,
                      lottieAsset: "assets/loader.json",
                      barrierDismissible: false);
                  var response = await punchOrder(
                      widget.seats,
                      widget.dropDownTime,
                      outletNoGlobal,
                      _name.text,
                      _phone.text,
                      _email.text == "" ? "" : _email.text,
                      _address.text);
                  if (response == false) {
                    Navigator.of(context, rootNavigator: true).pop();
                    MotionToast.error(
                      description: const Text("Check your internet"),
                      dismissable: true,
                    ).show(context);
                  } else {
                    Navigator.of(context, rootNavigator: true).pop();
                    cartItems.clear();
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.confirm,
                        title: "Verification",
                        barrierDismissible: false,
                        confirmBtnText: "Verify",
                        text:
                            "A verification code has been sent to your number and mail",
                        onConfirmBtnTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          push(
                              context,
                              VerifyCode(
                                  saleId: response["sale_no"].toString()));
                        });
                  }
                } else {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.loading,
                      barrierDismissible: false,
                      lottieAsset: "assets/loader.json");
                  var response = await reserveTable(
                      _name.text,
                      _phone.text,
                      _email.text == "" ? "" : _email.text,
                      widget.seats,
                      widget.date,
                      widget.dropDownTime,
                      widget.outletID);
                  if (response == false) {
                    Navigator.of(context, rootNavigator: true).pop();
                    CoolAlert.show(
                        title: "Server Error or check internet",
                        text: "please Try again",
                        context: context,
                        loopAnimation: true,
                        backgroundColor: myOrange,
                        confirmBtnColor: myOrange,
                        confirmBtnText: "Retry",
                        type: CoolAlertType.error,
                        animType: CoolAlertAnimType.slideInRight);
                  } else {
                    Navigator.of(context, rootNavigator: true).pop();
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.info,
                        barrierDismissible: false,
                        title: "Verify",
                        text:
                            "A verification message has been sent to your Email and Number",
                        confirmBtnText: "Verify",
                        confirmBtnColor: myOrange,
                        backgroundColor: myOrange,
                        onConfirmBtnTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          pop(context);
                          push(context,
                              VerifyCode(saleId: response[0]["sale_id"]));
                        });
                  }
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    _email.dispose();
    super.dispose();
  }
}
