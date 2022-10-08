import 'package:app/src/constants/endpoints.dart';
import 'package:app/src/models/order_model.dart';
import 'package:app/src/services/http_maneger.dart';

import '../../../models/order_model.dart';
import '../orders_result.dart/order_result.dart';

class OrderRepository {
  final _httpManager = HttpManager();

  Future<OrdersResult<List<OrderModel>>> getAllOrders({
    required String userId,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllOrders,
      method: HttpMethods.post,
      body: {'user': userId},
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromJson)
              .toList();

              return OrdersResult<List<OrderModel>>.success(orders);
    } else {
      return OrdersResult.error('Não foi possivel recuperar os pedidos');
    }
  }
}
