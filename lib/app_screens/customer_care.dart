import 'package:baranh/utils/app_routes.dart';
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
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              heightBox(context, 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                    onTap: () {
                      pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: myWhite,
                    )),
              ),
              heightBox(context, 0.03),
              customerCareCard(
                  context,
                  "assets/baranh_lahore.jpg",
                  "BARANH LAHORE",
                  "TIME : 7 PM TO 3 AM",
                  "GULBERG GALLERIA 18 GULBERG BOULEVARD GULBERG LAHORE"),
              heightBox(context, 0.04),
              const Divider(
                color: myWhite,
              ),
              heightBox(context, 0.04),
              customerCareCard(
                  context,
                  "assets/baranh_jhang.jpg",
                  "BARANH JHANG",
                  "TIME : 7 PM TO 3 AM",
                  "LDS - LONDON DEPARTMENTAL STORE NEAR SHELL PUMP, SESSION CHOWK, JHANG SADAR")
            ],
          ),
        ),
      ),
    );
  }
}

customerCareCard(context, img, outletName, timing, description) {
  return Container(
    width: dynamicWidth(context, .9),
    height: dynamicHeight(context, .26),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        dynamicWidth(context, 0.02),
      ),
      image: DecorationImage(
        image: AssetImage(img),
        fit: BoxFit.fitHeight,
      ),
    ),
    child: Container(
      width: dynamicWidth(context, .9),
      height: dynamicHeight(context, .26),
      decoration: BoxDecoration(
        color: myBlack.withOpacity(.6),
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, 0.02),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          text(
            context,
            outletName,
            0.06,
            myWhite,
            bold: true,
          ),
          text(
            context,
            timing,
            0.04,
            myWhite,
          ),
          text(
            context,
            description,
            0.04,
            myWhite,
            alignText: TextAlign.center,
          ),
          heightBox(context, .06),
          essentialsRow(
            context,
            LineIcons.phone,
            LineIcons.whatSApp,
            "042 35745701",
            "+92 346 8697097",
          ),
        ],
      ),
    ),
  );
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
