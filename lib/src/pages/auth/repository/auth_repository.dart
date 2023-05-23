import 'package:app/src/constants/endpoints.dart';
import 'package:app/src/models/user_model.dart';
import 'package:app/src/pages/auth/repository/auth_errors.dart' as auth_errors;
import 'package:app/src/pages/auth/result/auth_result.dart';
import 'package:app/src/services/http_maneger.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(auth_errors.authErrorsString(result['error']));
    }
  }

  Future<bool> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.changePassword,
        method: HttpMethods.post,
        body: {
          'email': email,
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
        headers: {
          'X-Parse-Session-Token': token,
        });

    return result['error'] == null;
  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.validateToken,
        method: HttpMethods.post,
        headers: {
          'X-Parse-Session-Token': token,
        });

    return handleUserOrError(result);
  }

  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      body: {
        'email': email,
        'password': password,
      },
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signup,
      method: HttpMethods.post,
      body: user.toJson(),
    );

    return handleUserOrError(result);
  }

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
      url: Endpoints.resetPassword,
      method: HttpMethods.post,
      body: {'email': email},
    );
  }
}
