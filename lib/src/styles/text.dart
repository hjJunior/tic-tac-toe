import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/styles/colors.dart';

class AppTextStyle {
  static TextStyle get textWhite =>
    TextStyle(color: Colors.white);

  static TextStyle get textBody1 =>
    TextStyle(fontSize: 21).merge(textWhite);

  static TextStyle get textAccentColor =>
    TextStyle(color: AppColors.accentColor);

  static TextStyle get textBrandStyle =>
      TextStyle(fontSize: 41, fontFamily: 'Crackman').merge(textAccentColor);
}
