import 'dart:math';

import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

Widget inputFieldsHome(text1, hintText1, context,
    {check = false,
    generatePasswordCheck = false,
    timeSlot = false,
    function = "",
    keyBoardType = TextInputType.text,
    controller = "",
    enable = true}) {
  return StatefulBuilder(builder: (context, changeState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(context, text1, 0.04, myWhite),
        heightBox(context, .01),
        Container(
          color: myWhite,
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.04),
          ),
          child: (check == true)
              ? InkWell(
                  onTap: () async {
                    var newTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2999, 1, 1),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: myBlack,
                            colorScheme:
                                const ColorScheme.light(primary: myOrange),
                            buttonTheme: const ButtonThemeData(
                              textTheme: ButtonTextTheme.primary,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (newTime != null) {
                      changeState(() {
                        hintText =
                            DateFormat('yyyy-MM-dd').format(newTime).toString();
                        function();
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: dynamicWidth(context, 0.5),
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: hintText.toString(),
                            fillColor: myWhite,
                          ),
                        ),
                      ),
                      const Icon(Icons.calendar_today_outlined)
                    ],
                  ),
                )
              : generatePasswordCheck == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp("[0-9]"),
                              ),
                              FilteringTextInputFormatter.deny(
                                RegExp('[\\.|\\,]'),
                              ),
                              LengthLimitingTextInputFormatter(11),
                            ],
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: hintText1,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            var rng = Random();
                            controller.text = rng.nextInt(9999999).toString();
                          },
                          child: const Icon(Icons.rotate_left),
                        )
                      ],
                    )
                  : TextFormField(
                      controller: controller,
                      keyboardType: keyBoardType,
                      inputFormatters: [
                        keyBoardType == TextInputType.number
                            ? FilteringTextInputFormatter.allow(
                                RegExp("[0-9]"),
                              )
                            : keyBoardType == TextInputType.emailAddress
                                ? FilteringTextInputFormatter.allow(
                                    RegExp("[0-9a-zA-Z \\- @ _ .]"),
                                  )
                                : FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z ]"),
                                  ),
                        keyBoardType == TextInputType.number
                            ? FilteringTextInputFormatter.deny(
                                RegExp('[\\.|\\,]'),
                              )
                            : FilteringTextInputFormatter.deny(
                                RegExp('[\\#]'),
                              ),
                      ],
                      decoration: InputDecoration(
                        enabled: enable,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: hintText1,
                      ),
                    ),
        )
      ],
    );
  });
}
