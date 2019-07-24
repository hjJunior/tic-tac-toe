import 'package:flutter/material.dart';

class BrandText extends StatelessWidget {
  BrandText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(fontSize: 45, color: Colors.yellow, fontFamily: 'Crackman'),
    );
  }
}
