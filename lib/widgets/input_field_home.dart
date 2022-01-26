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
          color: noColor,
          width: dynamicWidth(context, 1),
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: myWhite,
                      borderRadius: BorderRadius.circular(
                        dynamicWidth(context, 1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              fillColor: myWhite,
                              focusColor: myWhite,
                              hoverColor: myWhite,
                              filled: true,
                              isDense: true,
                              hintText: hintText.toString(),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(color: myBlack),
                                borderRadius: BorderRadius.circular(
                                  dynamicWidth(context, .4),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(color: myBlack),
                                borderRadius: BorderRadius.circular(
                                  dynamicWidth(context, .4),
                                ),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(color: myBlack),
                                borderRadius: BorderRadius.circular(
                                  dynamicWidth(context, .4),
                                ),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(color: myBlack),
                                borderRadius: BorderRadius.circular(
                                  dynamicWidth(context, .4),
                                ),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: const BorderSide(color: myBlack),
                                borderRadius: BorderRadius.circular(
                                  dynamicWidth(context, .4),
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: dynamicHeight(context, .014),
                                horizontal: dynamicWidth(context, .05),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: dynamicWidth(context, .04),
                          ),
                          child: const Icon(
                            Icons.calendar_today_outlined,
                            color: myBlack,
                          ),
                        )
                      ],
                    ),
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
                              fillColor: myWhite,
                              focusColor: myWhite,
                              hoverColor: myWhite,
                              filled: true,
                              isDense: true,
                              hintText: hintText1,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(color: myBlack),
                                borderRadius: BorderRadius.circular(
                                  dynamicWidth(context, .4),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(color: myBlack),
                                borderRadius: BorderRadius.circular(
                                  dynamicWidth(context, .4),
                                ),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(color: myBlack),
                                borderRadius: BorderRadius.circular(
                                  dynamicWidth(context, .4),
                                ),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(color: myBlack),
                                borderRadius: BorderRadius.circular(
                                  dynamicWidth(context, .4),
                                ),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: const BorderSide(color: myBlack),
                                borderRadius: BorderRadius.circular(
                                  dynamicWidth(context, .4),
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: dynamicHeight(context, .014),
                                horizontal: dynamicWidth(context, .05),
                              ),
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
                        fillColor: myWhite,
                        focusColor: myWhite,
                        hoverColor: myWhite,
                        filled: true,
                        isDense: true,
                        hintText: hintText1,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myBlack),
                          borderRadius: BorderRadius.circular(
                            dynamicWidth(context, .4),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myBlack),
                          borderRadius: BorderRadius.circular(
                            dynamicWidth(context, .4),
                          ),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myBlack),
                          borderRadius: BorderRadius.circular(
                            dynamicWidth(context, .4),
                          ),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myBlack),
                          borderRadius: BorderRadius.circular(
                            dynamicWidth(context, .4),
                          ),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myBlack),
                          borderRadius: BorderRadius.circular(
                            dynamicWidth(context, .4),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: dynamicHeight(context, .014),
                          horizontal: dynamicWidth(context, .05),
                        ),
                      ),
                    ),
        )
      ],
    );
  });
}
