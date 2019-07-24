import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/styles/text.dart';

class BrandText extends StatelessWidget {
  BrandText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppTextStyle.textBrandStyle,
    );
  }
}
