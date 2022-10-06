import 'package:app/src/constants/endpoints.dart';
import 'package:app/src/models/cart_item_model.dart';
import 'package:app/src/pages/cart/cart_result/cart_result.dart';
import 'package:app/src/services/http_maneger.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems({
    required String token,
    required String userId,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getCartItems,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'user': userId,
      },
    );

    if (result['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return CartResult<List<CartItemModel>>.success(data);
    } else {
      return CartResult<List<CartItemModel>>.error(
          'Erro ao recurar os itens do carrinho');
    }
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String token,
    required String productId,
    required String quantity,
  }) async {
    final result = _httpManager.restRequest(
      url: Endpoints.addItemToCart,
      method: HttpMethods.post,
      body: {
        "user": userId,
        "quantity": quantity,
        "productId": productId,
      },
      headers: {
        'token' : token,
      }
    );

    if(result['result'] != null){
      return CartResult<String>.success(result['result']['id']);
    } else {
      return CartResult.error('Não foi possivel adicionar item no carirnho');
    }
    
  }
}
