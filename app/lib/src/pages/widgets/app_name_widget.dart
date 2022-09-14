import 'package:app/src/config/custom_colors.dart';
import 'package:flutter/material.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({Key? key, this.greenTileColor, this.textSize = 30}) : super(key: key);
  final Color? greenTileColor;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        style: TextStyle(
          fontSize: textSize,
        ),
        children: [
          TextSpan(
            text: 'Zap ',
            style: TextStyle(color: greenTileColor ?? CustomColors.customSwatchColor),
          ),
          TextSpan(
            text: 'Frutas',
            style: TextStyle(color: CustomColors.customContrastColor),
          ),
        ]));
  }
}