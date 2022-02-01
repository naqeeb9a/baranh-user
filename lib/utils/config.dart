import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

const myWhite = Color(0xffffffff);
const myGrey = Colors.grey;
const myBlack = Color(0xff000000);
const myOrange = Color(0xffff6624);
const myGreen = Color(0xFF008000);
const myRed = Color(0xFFff0000);
const noColor = Colors.transparent;

bool obscureText = true;
var indexPage = 0;
dynamic staticRefresh;
var pageDecider = "Home";
dynamic hintText = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
dynamic customContext = "";
dynamic globalRefresh = "";
dynamic saleIdGlobal;
dynamic outletNoGlobal;
dynamic globalDineInContext;
dynamic globalDineInRefresh;
dynamic userResponse = "Guest";
dynamic menuRefresh;
dynamic globalContextMain;

var cartItems = [].obs;
var reservedTable = [];
var callBackUrl = "https://baranh.pk";

const serverKey =
    'AAAAELUEy8M:APA91bHj4D-x3M1ThDFQXFMGXssPLgLu32qMHs2-j87YlyHuUV4BCVYCPzpM_cGJDsvkpgHLThU96j6C7ZPx-7Mmjbifr1OHZvdJFGEHoXaiSBOrKMIFEwDN7GcNniMXhw9Wlq2Ult2j';
