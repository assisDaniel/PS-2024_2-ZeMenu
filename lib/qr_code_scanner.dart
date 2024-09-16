import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanner extends StatelessWidget {
  QRScanner({required this.setResult, super.key});
  final MobileScannerController controller = MobileScannerController();
  final Function setResult;

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: controller,
      onDetect: (BarcodeCapture capture) async {
        final code = capture.barcodes.first;
        if (code.rawBytes != null) {
          final content = code.rawBytes!;
          setResult((utf8.decode(content.sublist(2)), content.sublist(0, 2).buffer.asByteData().getInt16(0)));
          await controller
            .stop()
            .then((value) => controller.dispose())
            .then((value) => {
              if (context.mounted) {
                Navigator.of(context).pop()
              }
            });
        }
      },
    );
  }
}