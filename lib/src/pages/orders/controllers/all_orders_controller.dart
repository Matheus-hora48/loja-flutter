import 'package:app/src/models/order_model.dart';
import 'package:app/src/pages/auth/controllers/auth_controller.dart';
import 'package:app/src/pages/orders/orders_result.dart/order_result.dart';
import 'package:app/src/pages/orders/repository/orders_repository.dart';
import 'package:app/src/services/utils_services.dart';
import 'package:get/get.dart';

class AllOrdersController extends GetxController {
  List<OrderModel> allOrders = [];
  final orderRepository = OrderRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  @override
  void onInit() {
    super.onInit();

    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await orderRepository.getAllOrders(
      userId: authController.user.id!,
      token: authController.user.token!,
    );

    result.when(
      success: (orders) {
        allOrders = orders
          ..sort(
            (a, b) => b.createdDateTime!.compareTo(a.createdDateTime!),
          );
        update();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
