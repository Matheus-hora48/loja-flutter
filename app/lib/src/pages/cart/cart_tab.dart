import 'package:app/src/config/app_data.dart' as app_data;
import 'package:app/src/config/custom_colors.dart';
import 'package:app/src/models/cart_item_model.dart';
import 'package:app/src/pages/cart/components/cart_tile.dart';
import 'package:app/src/pages/widgets/payment_dialog.dart';
import 'package:app/src/services/utils_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();

  void removeItemFromCart(CartItemModel cartItem) {
    setState(() {
      app_data.cartItems.remove(cartItem);
    });
  }

  double cartTotalPrice() {
    double total = 0;

    for (var item in app_data.cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carrinho',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: app_data.cartItems.length,
            itemBuilder: (_, index) {
              return CartTile(
                cartItem: app_data.cartItems[index],
                remove: removeItemFromCart,
              );
            },
          )),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 3,
                    spreadRadius: 2,
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total geral',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  utilsServices.priceToCurrency(cartTotalPrice()),
                  style: TextStyle(
                      fontSize: 23,
                      color: CustomColors.customSwatchColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool? result = await showOrderConfirmation();
                      if (result ?? false) {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return PaymentDialog(
                                order: app_data.orders.first,
                              );
                            });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    )),
                    child: const Text(
                      'Concluir pedido',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Sim',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        );
      },
    );
  }
}
