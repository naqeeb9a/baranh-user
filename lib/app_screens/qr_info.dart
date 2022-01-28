import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class QRInfo extends StatefulWidget {
  final dynamic tableId;

  const QRInfo({Key? key, this.tableId}) : super(key: key);

  @override
  _QRInfoState createState() => _QRInfoState();
}

class _QRInfoState extends State<QRInfo> {
  dynamic qRData;

  @override
  void initState() {
    super.initState();
    qRData = getQRSummary(widget.tableId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: text(context, "text", .06, myWhite),
    );
  }
}
