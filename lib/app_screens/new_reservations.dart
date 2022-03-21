import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/app_screens/contact_information.dart';
import 'package:baranh/app_screens/verification_screen.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/input_field_home.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';

class NewReservationsPage extends StatefulWidget {
  const NewReservationsPage({Key? key}) : super(key: key);

  @override
  State<NewReservationsPage> createState() => _NewReservationsPageState();
}

class _NewReservationsPageState extends State<NewReservationsPage> {
  final TextEditingController _seats = TextEditingController();

  String indexValue = "";
  dynamic bigArray = [];
  var timeDropDown = "";
  String outletId = "1";
  String outletValue = "";
  dynamic dynamicRefreshTimeSlot;

  @override
  void dispose() {
    _seats.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.05),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                heightBox(context, 0.05),
                text(context, "RESERVATION", 0.05, myWhite),
                const Divider(
                  thickness: 1,
                  color: myWhite,
                ),
                heightBox(context, 0.01),
                text(context, "BARANH LAHORE", 0.04, myWhite),
                inputFieldsHome("Date", hintText, context,
                    check: true, timeSlot: true, function: () {
                  setState(() {});
                }),
                heightBox(context, 0.02),
                SizedBox(
                  height: dynamicHeight(context, 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(
                        context,
                        "Outlet",
                        0.04,
                        myWhite,
                      ),
                      StatefulBuilder(builder: (context, changeStateNow) {
                        return FutureBuilder(
                          future: getOutlets(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data != false) {
                                outletValue = snapshot.data[0]["outlet_name"];
                                outletId = snapshot.data[0]["id"];
                              }

                              return (snapshot.data == false)
                                  ? InkWell(
                                      onTap: () {
                                        changeStateNow(() {});
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.rotate_right_outlined,
                                            color: myOrange,
                                            size: dynamicWidth(context, 0.08),
                                          ),
                                          text(context, "Retry", 0.04, myWhite)
                                        ],
                                      ),
                                    )
                                  : StatefulBuilder(
                                      builder:
                                          (BuildContext context, changeSate) {
                                        return DropdownButton<String>(
                                          hint: text(
                                            context,
                                            outletValue,
                                            0.04,
                                            myWhite,
                                          ),
                                          items: snapshot.data
                                              .map<DropdownMenuItem<String>>(
                                                  (value) => DropdownMenuItem<
                                                          String>(
                                                      value: value["id"] +
                                                          value["outlet_name"],
                                                      child: Text(
                                                        value["outlet_name"],
                                                      )))
                                              .toList(),
                                          onChanged: (value) {
                                            changeSate(() {
                                              var aStr = value!.replaceAll(
                                                  RegExp(r'[^0-9]'), '');
                                              var aStr2 = value.replaceAll(
                                                  RegExp(r'[^a-z A-Z]'), '');
                                              outletId = aStr;
                                              outletValue = aStr2;
                                            });
                                            dynamicRefreshTimeSlot();
                                          },
                                        );
                                      },
                                    );
                            } else {
                              return LottieBuilder.asset(
                                "assets/loader.json",
                                width: dynamicWidth(context, 0.3),
                              );
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: dynamicHeight(context, 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(
                        context,
                        "Time",
                        0.04,
                        myWhite,
                      ),
                      StatefulBuilder(builder: (context, changeStateNow) {
                        dynamicRefreshTimeSlot = () {
                          changeStateNow(() {});
                        };
                        return FutureBuilder(
                          future: getTimeSlots(hintText, outletId),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              (snapshot.data == false)
                                  ? ""
                                  : indexValue = "Select time";
                              // indexValue = getConvertedTime(
                              //         snapshot.data[0]["opening_time"]) +
                              //     "  ${snapshot.data[0]["discount"]} % off" +
                              //     "#${snapshot.data[0]["id"]}#${snapshot.data[0]["seats"]}#${snapshot.data[0]["booksum"]}#${snapshot.data[0]["discount"]}";

                              return (snapshot.data == false)
                                  ? InkWell(
                                      onTap: () {
                                        changeStateNow(() {});
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.rotate_right_outlined,
                                            color: myOrange,
                                            size: dynamicWidth(context, 0.08),
                                          ),
                                          text(context, "Retry", 0.04, myWhite)
                                        ],
                                      ),
                                    )
                                  : (snapshot.data == null)
                                      ? text(context, "no Slots", 0.04, myWhite)
                                      : StatefulBuilder(
                                          builder: (BuildContext context,
                                              changeSate) {
                                            return DropdownButton<String>(
                                              hint: text(
                                                context,
                                                indexValue == "Select time"
                                                    ? indexValue
                                                    : indexValue.substring(
                                                        0,
                                                        indexValue
                                                            .indexOf("#")),
                                                0.04,
                                                myWhite,
                                              ),
                                              items: snapshot.data.map<
                                                      DropdownMenuItem<String>>(
                                                  (value) {
                                                if ((double.parse(value[
                                                                    "opening_time"]
                                                                .toString()
                                                                .replaceAll(
                                                                    ":", ".")) -
                                                            1) >
                                                        double.parse((DateTime
                                                                        .now()
                                                                    .hour)
                                                                .toString() +
                                                            "." +
                                                            (DateTime.now()
                                                                    .minute)
                                                                .toString()) &&
                                                    DateTime.now()
                                                        .toString()
                                                        .contains(hintText)) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: getConvertedTime(value[
                                                            "opening_time"]) +
                                                        "  ${value["discount"]} % off" +
                                                        "#${value["id"]}#${value["seats"]}#${value["booksum"]}#${value["discount"]}",
                                                    child: Text(getConvertedTime(
                                                            value[
                                                                "opening_time"]) +
                                                        "  ${value["discount"]} % off"),
                                                  );
                                                } else if (!DateTime.now()
                                                    .toString()
                                                    .contains(hintText)) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: getConvertedTime(value[
                                                            "opening_time"]) +
                                                        "  ${value["discount"]} % off" +
                                                        "#${value["id"]}#${value["seats"]}#${value["booksum"]}#${value["discount"]}",
                                                    child: Text(getConvertedTime(
                                                            value[
                                                                "opening_time"]) +
                                                        "  ${value["discount"]} % off"),
                                                  );
                                                } else {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: getConvertedTime(value[
                                                            "opening_time"]) +
                                                        "  ${value["discount"]} % off" +
                                                        "#${value["id"]}#${value["seats"]}#${value["booksum"]}#${value["discount"]}",
                                                    child: Text(
                                                      getConvertedTime(value[
                                                              "opening_time"]) +
                                                          "  ${value["discount"]} % off",
                                                      style: const TextStyle(
                                                          color: myGrey),
                                                    ),
                                                    enabled: false,
                                                  );
                                                }
                                              }).toList(),
                                              onChanged: (value) {
                                                changeSate(() {
                                                  indexValue = value!;
                                                });
                                              },
                                            );
                                          },
                                        );
                            } else {
                              return LottieBuilder.asset(
                                "assets/loader.json",
                                width: dynamicWidth(context, 0.3),
                              );
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ),
                heightBox(context, 0.02),
                inputFieldsHome(
                  "Seats:",
                  "",
                  context,
                  keyBoardType: TextInputType.number,
                  controller: _seats,
                ),
                heightBox(context, 0.03),
                coloredButton(
                  context,
                  "CHECK AVAILABILITY",
                  myOrange,
                  width: dynamicWidth(context, .56),
                  function: () async {
                    if (_seats.text.isEmpty ||
                        hintText == "mm/dd/yyyy" ||
                        indexValue == "Select time") {
                      MotionToast.info(
                        description: const Text(
                            "Make sure to select and fill all the fields"),
                        dismissable: true,
                      ).show(context);
                    } else {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.loading,
                          lottieAsset: "assets/loader.json");
                      var response = await checkAvailability(
                          hintText,
                          indexValue.substring(indexValue.indexOf("#") + 1),
                          _seats.text,
                          outletId);
                      if (response == true) {
                        Navigator.of(context, rootNavigator: true).pop();
                        CoolAlert.show(
                            onConfirmBtnTap: () async {
                              if (userResponse == "Guest") {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                push(
                                    context,
                                    ContactInformation(
                                      dropDownTime: indexValue.substring(
                                          indexValue.indexOf("#") + 1),
                                      seats: _seats.text,
                                      date: hintText,
                                      outletID: outletId.toString(),
                                      onlineOrderCheck: false,
                                    ));
                              } else {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.loading,
                                    barrierDismissible: false,
                                    lottieAsset: "assets/loader.json");
                                var response = await reserveTable(
                                    userResponse["name"],
                                    userResponse["phone"],
                                    userResponse["email"],
                                    _seats.text,
                                    hintText,
                                    indexValue
                                        .substring(indexValue.indexOf("#") + 1),
                                    outletId.toString());
                                if (response == false) {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  MotionToast.error(
                                    description: const Text(
                                        "Check your internet or try again"),
                                    dismissable: true,
                                  ).show(context);
                                } else {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();

                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.info,
                                      title: "Verify",
                                      text:
                                          "A verification message has been sent to your Email and Number",
                                      confirmBtnText: "Verify",
                                      confirmBtnColor: myOrange,
                                      backgroundColor: myOrange,
                                      onConfirmBtnTap: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();

                                        push(
                                            context,
                                            VerifyCode(
                                              saleId: response[0]["sale_id"],
                                            ));
                                      });
                                }
                              }
                            },
                            title: "Slots Available",
                            text: userResponse == "Guest"
                                ? "Do you wish to proceed"
                                : "Do you wish to Book a slot?",
                            context: context,
                            loopAnimation: true,
                            backgroundColor: myOrange,
                            confirmBtnColor: myOrange,
                            confirmBtnText: "Continue",
                            type: CoolAlertType.confirm,
                            animType: CoolAlertAnimType.slideInRight);
                      } else if (response == false) {
                        Navigator.of(context, rootNavigator: true).pop();
                        MotionToast.error(
                          description: const Text(
                              "Slots are not available try again after some time"),
                          dismissable: true,
                        ).show(context);
                      } else if (response == "internet") {
                        Navigator.of(context, rootNavigator: true).pop();
                        MotionToast.warning(
                          description: const Text("Check your internet"),
                          dismissable: true,
                        );
                      } else {
                        Navigator.of(context, rootNavigator: true).pop();
                        CoolAlert.show(
                          title: "Server Error",
                          text: "please Try again",
                          context: context,
                          loopAnimation: true,
                          backgroundColor: myOrange,
                          confirmBtnColor: myOrange,
                          confirmBtnText: "Retry",
                          type: CoolAlertType.error,
                          animType: CoolAlertAnimType.slideInRight,
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

getConvertedTime(String time) {
  var parsedTime = int.parse(time.substring(0, time.length - 3));
  if (parsedTime > 12) {
    return (parsedTime - 12) >= 10
        ? (parsedTime - 12).toString() + time.substring(2) + " pm"
        : "0" + (parsedTime - 12).toString() + time.substring(2) + " pm";
  } else if (parsedTime == 12) {
    return "12" + time.substring(2) + " pm";
  } else if (parsedTime == 00) {
    return "12" + time.substring(2) + " am";
  } else {
    return time + " am";
  }
}
