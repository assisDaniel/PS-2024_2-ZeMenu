import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ze_menu/codigo_qr.dart';

class QRLeitor extends StatelessWidget {
  QRLeitor({super.key});
  final MobileScannerController controlador = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: controlador,
      onDetect: (BarcodeCapture captura) async {
        final codigo = captura.barcodes.first;
        if (codigo.rawBytes != null) {
          final conteudo = codigo.rawBytes!;
          await controlador
            .stop()
            .then((valor) => controlador.dispose())
            .then((valor) => {
              if (context.mounted) {
                Navigator.of(context).pushNamed("/inicio", arguments: CodigoQr(
                  restaurante: utf8.decode(conteudo.sublist(2)),
                  mesaId: conteudo.sublist(0, 2).buffer.asByteData().getInt16(0))
                )
              }
            });
        }
      },
    );
  }
}