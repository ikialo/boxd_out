import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImage extends StatelessWidget {
  const QRImage(this.controller, {super.key});

  final String controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImage(
        data: controller,
        size: 280,
        // You can include embeddedImageStyle Property if you
        //wanna embed an image from your Asset folder
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: const Size(
            100,
            100,
          ),
        ),
      ),
    );
  }
}
