import 'package:app/src/config/custom_colors.dart';
import 'package:app/src/pages/auth/pages/sign_in_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Zap Frutas',
        theme: ThemeData(
            primarySwatch: CustomColors.customSwatchColor,
            scaffoldBackgroundColor: Colors.white.withAlpha(200)),
        debugShowCheckedModeBanner: false,
        home: const SignInScreen());
  }
}
