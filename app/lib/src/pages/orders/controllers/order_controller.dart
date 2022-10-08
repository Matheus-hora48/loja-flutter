import 'package:app/src/pages/auth/controllers/auth_controller.dart';
import 'package:app/src/pages/orders/repository/orders_repository.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final orderRepository = OrderRepository();
  final authController = Get.find<AuthController>();

  Future<void> getOrderItems() async {
    orderRepository.getOrdersItems(
      orderId: orderId,
      token: authController.user.token!,
    );
  }
}
