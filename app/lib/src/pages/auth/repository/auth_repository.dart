import 'package:app/src/constants/endpoints.dart';
import 'package:app/src/models/user_model.dart';
import 'package:app/src/services/http_maneger.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future singIn({required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      body: {
        "email": email,
        "password": password,
      },
    );

    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      print(user);
    }
  }
}
