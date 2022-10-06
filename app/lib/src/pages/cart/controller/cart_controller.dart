import 'package:app/src/models/cart_item_model.dart';
import 'package:app/src/pages/auth/controllers/auth_controller.dart';
import 'package:app/src/pages/cart/cart_result/cart_result.dart';
import 'package:app/src/pages/cart/repository/cart_repository.dart';
import 'package:app/src/services/utils_services.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();

    getCartItems();
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(
        success: (data) {
          cartItems = data;
          update();
        },
        error: (message) {
          utilsServices.showToast(message: message);
        });
  }
}
