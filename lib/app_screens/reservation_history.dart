import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ReservationHistoryPage extends StatelessWidget {
  const ReservationHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              heightBox(context, 0.05),
              text(context, "Reservation History", 0.05, myWhite),
              text(context, "VARDA SARWAR", 0.05, myWhite),
              heightBox(context, 0.02),
              heightBox(context, 0.005),
            ],
          ),
        ),
      ),
    );
  }
}
