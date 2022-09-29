import 'package:app/src/models/user_model.dart';
import 'package:app/src/pages/auth/repository/auth_repository.dart';
import 'package:app/src/pages/auth/result/auth_result.dart';
import 'package:app/src/routes/app_routes.dart';
import 'package:app/src/services/utils_services.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final utilsServices = UtilsServices();
  RxBool isLoading = false.obs;
  final authRepository = AuthRepository();

  UserModel user = UserModel();

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result = await authRepository.singIn(
      email: email,
      password: password,
    );

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        Get.offAllNamed(PagesRoutes.baseRoute);
      },
      error: (message) {
        print(message);
        utilsServices.showToast(
          isError: true,
          message: message,
        );
      },
    );
  }
}
