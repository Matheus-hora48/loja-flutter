import 'package:app/src/config/custom_colors.dart';
import 'package:app/src/models/cart_item_model.dart';
import 'package:app/src/pages/widgets/quantity_widget.dart';
import 'package:app/src/services/utils_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartTile extends StatelessWidget {
  CartTile({Key? key, required this.cartItem}) : super(key: key);

  final CartItemModel cartItem;
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),
        title: Text(
          cartItem.item.itemName,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          utilsServices.priceToCurrency(cartItem.item.price),
          style: TextStyle(
              color: CustomColors.customSwatchColor,
              fontWeight: FontWeight.bold),
        ),
        trailing: QuantityWidget(
          value: cartItem.quantity,
          suffixText: cartItem.item.unit,
          result: ((quantity) {}),
        ),
      ),
    );
  }
}
