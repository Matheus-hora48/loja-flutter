import 'package:app/src/config/custom_colors.dart';
import 'package:app/src/pages/widgets/app_name_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CustomColors.customSwatchColor,
            CustomColors.customSwatchColor.shade700,
          ],
        )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            AppNameWidget(
              greenTileColor: Colors.white,
              isBold: true,
              textSize: 40,
            ),
            SizedBox(
              height: 30,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Colors.white,
              ),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
