import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerCare extends StatefulWidget {
  const CustomerCare({Key? key}) : super(key: key);

  @override
  State<CustomerCare> createState() => _CustomerCareState();
}

class _CustomerCareState extends State<CustomerCare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: myBlack,
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox(context, 0.03),
                text(context, "BARANH LAHORE", 0.06, myWhite, bold: true),
                text(context, "TIME : 7 PM TO 3 AM", 0.04, myWhite),
                text(
                    context,
                    "GULBERG GALLERIA 18 GULBERG BOULEVARD GULBERG LAHORE",
                    0.04,
                    myWhite),
                heightBox(context, 0.01),
                ClipRRect(
                    borderRadius:
                        BorderRadius.circular(dynamicWidth(context, 0.02)),
                    child: Image.asset("assets/baranh_lahore.jpg")),
                heightBox(context, 0.01),
                essentialsRow(context, LineIcons.phone, LineIcons.whatSApp,
                    "042 35745701", "+92 346 8697097"),
                const Divider(
                  color: myWhite,
                ),
                text(context, "BARANH JHANG", 0.06, myWhite, bold: true),
                text(context, "TIME : 7 PM TO 3 AM", 0.04, myWhite),
                text(
                    context,
                    "LDS - LONDON DEPARTMENTAL STORE NEAR SHELL PUMP, SESSION CHOWK, JHANG SADAR",
                    0.04,
                    myWhite),
                heightBox(context, 0.01),
                ClipRRect(
                    borderRadius:
                        BorderRadius.circular(dynamicWidth(context, 0.02)),
                    child: Image.asset("assets/baranh_jhang.jpg")),
                heightBox(context, 0.01),
                essentialsRow(context, LineIcons.phone, LineIcons.whatSApp,
                    "042 35745701", "+92 346 8697097")
              ],
            ),
          ),
        ));
  }
}

essentialsRow(context, icon1, icon2, phone1, phone2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      InkWell(
        onTap: () async {
          await launch(('tel:$phone1'));
        },
        child: Row(
          children: [
            LineIcon(
              icon1,
              color: Colors.blue,
            ),
            text(context, phone1, 0.04, myWhite),
          ],
        ),
      ),
      InkWell(
        onTap: () async {
          await launch("whatsapp://send?phone=" + phone2 + "&text=hello");
        },
        child: Row(
          children: [
            LineIcon(
              icon2,
              color: Colors.green,
            ),
            text(context, phone2, 0.04, myWhite),
          ],
        ),
      ),
    ],
  );
}
