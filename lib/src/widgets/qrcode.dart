import 'package:flutter/material.dart';

class QrCode extends StatelessWidget {
  QrCode(this.text);
  final String text;

  String get qrCodeUrl =>
    'https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=$text';

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      Image.network(qrCodeUrl),
    ],
  );
}
