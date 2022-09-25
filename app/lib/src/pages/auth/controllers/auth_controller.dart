import 'package:app/src/pages/auth/repository/auth_repository.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final authRepository = AuthRepository();

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    await authRepository.singIn(
      email: email,
      password: password,
    );

    isLoading.value = false;
  }
}
