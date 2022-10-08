import 'package:app/src/pages/orders/controllers/all_orders_controller.dart';
import 'package:get/get.dart';

class OrdersBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(AllOrdersController());
  }

}