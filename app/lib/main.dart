import 'package:app/src/config/custom_colors.dart';
import 'package:app/src/pages/auth/controllers/auth_controller.dart';
import 'package:app/src/pages/splash/splash_screen.dart';
import 'package:app/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zap Frutas',
      theme: ThemeData(
        primarySwatch: CustomColors.customSwatchColor,
        scaffoldBackgroundColor: Colors.white.withAlpha(200),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialRoute: PagesRoutes.splashRoute,
      getPages: AppPages.pages,
    );
  }
}
