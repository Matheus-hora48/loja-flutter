import 'package:app/src/constants/storage_key.dart';
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

  @override
  void onInit() {
    super.onInit();

    validateToken();
  }

  Future<void> validateToken() async {
    String? token = await utilsServices.getLocalData(key: StorageKey.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.singInRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndeProcedToBase();
      },
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> signOut() async {
    user = UserModel();
    await utilsServices.removeLocalData(key: StorageKey.token);
    Get.offAllNamed(PagesRoutes.singInRoute);
  }

  void saveTokenAndeProcedToBase() {
    utilsServices.saveLocalData(key: StorageKey.token, data: user.token!);
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

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

        saveTokenAndeProcedToBase();
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
