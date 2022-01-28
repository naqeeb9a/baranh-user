import 'dart:io';

import 'package:baranh/app_screens/qr_info.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/essential_widgets.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final qrKey = GlobalKey();
  QRViewController? controller;

  void qrCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((event) {
      var tableCode = event.code.toString().substring(
          event.code.toString().length - 3, event.code.toString().length);

      onDone(tableCode);

      // onDone() {
      //   controller.resumeCamera();
      //   push(
      //     context,
      //     QRInfo(
      //       tableId: tableCode,
      //     ),
      //   );
      // }
      //
      // onDone();
    });
  }

  onDone(tableCode) async {
    controller?.pauseCamera();
    push(
      context,
      QRInfo(
        tableId: tableCode,
      ),
    ).then((value) => controller?.resumeCamera());
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar(context, qrVisibility: false),
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: qrCreated,
            overlay: QrScannerOverlayShape(
                borderColor: myOrange,
                borderLength: 20,
                borderRadius: 10,
                borderWidth: 10,
                cutOutSize: dynamicWidth(context, 0.8)),
          ),
          bottomText(),
          toggleIcons()
        ],
      ),
    );
  }

  Widget bottomText() {
    return Positioned(
      bottom: dynamicHeight(context, 0.1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(dynamicWidth(context, 0.02)),
        child: Container(
          color: myWhite.withOpacity(0.4),
          padding: EdgeInsets.all(dynamicWidth(context, 0.02)),
          child: text(context, "Scan the QR code", 0.04, myWhite),
        ),
      ),
    );
  }

  Widget toggleIcons() {
    return Positioned(
      top: dynamicHeight(context, 0.02),
      child: SizedBox(
        width: dynamicWidth(context, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: myWhite,
                )),
            Container(
              padding: EdgeInsets.all(dynamicWidth(context, 0.01)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(dynamicWidth(context, 0.1)),
                color: Colors.white24,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await controller?.toggleFlash();
                      setState(() {});
                    },
                    icon: FutureBuilder<bool?>(
                      future: controller?.getFlashStatus(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return Icon(
                            snapshot.data! ? Icons.flash_on : Icons.flash_off,
                            color: myWhite,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await controller?.flipCamera();
                      setState(() {});
                    },
                    icon: FutureBuilder(
                      future: controller?.getCameraInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return const Icon(
                            Icons.switch_camera,
                            color: myWhite,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.transparent,
                )),
          ],
        ),
      ),
    );
  }
}
