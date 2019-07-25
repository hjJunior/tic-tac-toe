import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/styles/text.dart';

class MenuItem extends StatelessWidget {
  MenuItem({this.menuText, this.onClick});

  final String menuText;
  final Function onClick;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onClick,
    child: Container(
      color: Colors.yellow,
      padding: EdgeInsets.all(20),
      child: Text(
        menuText.toUpperCase(),
        style: AppTextStyle.textMenu,
      ),
    ),
  );
}
