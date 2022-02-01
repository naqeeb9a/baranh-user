import 'package:baranh/app_functions/fcm_services.dart';
import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/generic_cards.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:motion_toast/motion_toast.dart';

class QRInfo extends StatefulWidget {
  final dynamic tableId;

  const QRInfo({Key? key, this.tableId}) : super(key: key);

  @override
  _QRInfoState createState() => _QRInfoState();
}

class _QRInfoState extends State<QRInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (globalWaiterId != null || globalWaiterId != null) {
              var temp = FCMServices.sendFCM(
                'waiter',
                63,
                "Customer Message",
                "Table $globalTableId is calling you.",
              );

              try {
                await temp.then((value) {
                  MotionToast.success(
                    description:
                        const Text("Bell is ringing on your waiter's Phone"),
                    dismissable: true,
                  ).show(context);
                });
              } catch (e) {
                MotionToast.error(
                  description: const Text(
                      "Sorry we can't call your waiter check your internet or call him yourself"),
                  dismissable: true,
                ).show(context);
              }
            }
          },
          backgroundColor: myOrange,
          label: Row(
            children: [
              LineIcon(LineIcons.bell),
              text(context, " Call Waiter", 0.04, myWhite)
            ],
          )),
      backgroundColor: myBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.05),
          ),
          child: Column(
            children: [
              heightBox(context, 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: myWhite,
                    ),
                  ),
                  text(context, "Active Order", 0.05, myWhite),
                  const Icon(
                    Icons.arrow_back,
                    color: myBlack,
                  ),
                ],
              ),
              heightBox(context, 0.01),
              const Divider(
                thickness: 1,
                color: myWhite,
              ),
              Expanded(child: genericCards(getQRSummary(widget.tableId)))
            ],
          ),
        ),
      ),
    );
  }
}
