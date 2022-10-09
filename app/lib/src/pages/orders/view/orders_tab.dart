import 'package:app/src/pages/orders/controllers/all_orders_controller.dart';
import 'package:app/src/pages/orders/view/components/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pedidos',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<AllOrdersController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getAllOrders(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (_, index) => const SizedBox(height: 10),
              itemBuilder: (_, index) {
                return OrderTile(
                  order: controller.allOrders[index],
                );
              },
              itemCount: controller.allOrders.length,
            ),
          );
        },
      ),
    );
  }
}
