import 'package:app/src/models/cart_item_model.dart';
import 'package:app/src/models/order_model.dart';
import 'package:app/src/pages/orders/controllers/order_controller.dart';
import 'package:app/src/pages/orders/view/components/order_status.dart';
import 'package:app/src/pages/widgets/payment_dialog.dart';
import 'package:app/src/services/utils_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTile extends StatelessWidget {
  OrderTile({Key? key, required this.order}) : super(key: key);

  final OrderModel order;
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: GetBuilder<OrderController>(
            init: OrderController(order),
            global: false,
            builder: (controller) {
              return ExpansionTile(
                onExpansionChanged: (value) {
                  if (value && order.items.isEmpty) {
                    controller.getOrderItems();
                  }
                },
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pedido: ${order.id}'),
                    Text(
                      utilsServices.formatDateTime(order.createdDateTime!),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                children: controller.isLoading
                    ? [
                        Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        )
                      ]
                    : [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height: 150,
                                  child: ListView(
                                    children:
                                        controller.order.items.map((orderItem) {
                                      return orderItemWidget(
                                        utilsServices: utilsServices,
                                        orderItem: orderItem,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.grey.shade300,
                                thickness: 2,
                                width: 8,
                              ),
                              Expanded(
                                flex: 2,
                                child: OrderStatusWidget(
                                  isOverdue: order.overdueDateTime.isBefore(
                                    DateTime.now(),
                                  ),
                                  status: order.status,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              children: [
                                const TextSpan(
                                    text: 'Total ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                TextSpan(
                                  text: utilsServices
                                      .priceToCurrency(order.total),
                                )
                              ]),
                        ),
                        Visibility(
                          visible: order.status == 'pending_payment' &&
                              order.isOverDue,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return PaymentDialog(
                                          order: order,
                                        );
                                      });
                                },
                                icon: Image.asset(
                                  'assets/app_images/pix.png',
                                  height: 18,
                                ),
                                label: const Text(
                                  'Ver QR Code Pix',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
              );
            },
          )),
    );
  }
}

// ignore: camel_case_types
class orderItemWidget extends StatelessWidget {
  const orderItemWidget({
    Key? key,
    required this.utilsServices,
    required this.orderItem,
  }) : super(key: key);

  final UtilsServices utilsServices;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Text(orderItem.item.itemName)),
          Text(utilsServices.priceToCurrency(orderItem.totalPrice()))
        ],
      ),
    );
  }
}
