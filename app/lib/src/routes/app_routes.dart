import 'package:app/src/pages/auth/view/sign_in_screen.dart';
import 'package:app/src/pages/auth/view/sing_up_screen.dart';
import 'package:app/src/pages/base/base_screen.dart';
import 'package:app/src/pages/home/binding/home_binding.dart';
import 'package:app/src/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PagesRoutes.singInRoute,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: PagesRoutes.singUpRoute,
      page: () => SingUpScreen(),
    ),
    GetPage(
      name: PagesRoutes.baseRoute,
      page: () => const BaseScreen(),
      binding: HomeBinding(),
    ),
  ];
}

abstract class PagesRoutes {
  static const String splashRoute = '/splash';
  static const String singInRoute = '/signin';
  static const String singUpRoute = '/singup';
  static const String baseRoute = '/home';
}
