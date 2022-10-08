import 'package:app/src/config/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrderStatusWidget extends StatelessWidget {
  OrderStatusWidget({
    Key? key,
    required this.status,
    required this.isOverdue,
  }) : super(key: key);

  final String status;
  final bool isOverdue;

  final Map<String, int> allStatus = <String, int>{
    'pending_payment': 0,
    'refunded': 1,
    'paid': 2,
    'preparing_purchase': 3,
    'shipping': 4,
    'delivered': 5,
  };

  int get currentStatus => allStatus[status]!;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _statusDot(
          isActive: true,
          title: 'Pedido confirmado',
        ),
        const CustomDivider(),
        if (currentStatus == 1) ...[
          const _statusDot(
            isActive: true,
            title: 'Pix estornado',
            backgroundColor: Colors.orangeAccent,
          ),
        ] else if (isOverdue) ...[
          const _statusDot(
            isActive: true,
            title: 'Pagamento Pix vencido',
            backgroundColor: Colors.redAccent,
          ),
        ] else ...[
          _statusDot(
            isActive: currentStatus >= 2,
            title: 'Pagamento',
          ),
          const CustomDivider(),
          _statusDot(
            isActive: currentStatus >= 3,
            title: 'Preparando',
          ),
          const CustomDivider(),
          _statusDot(
            isActive: currentStatus >= 4,
            title: 'Envio',
          ),
          const CustomDivider(),
          _statusDot(
            isActive: currentStatus >= 5,
            title: 'Entregue',
          ),
        ]
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      height: 10,
      width: 2,
      color: Colors.grey.shade300,
    );
  }
}

class _statusDot extends StatelessWidget {
  const _statusDot(
      {Key? key,
      required this.isActive,
      required this.title,
      this.backgroundColor})
      : super(key: key);

  final bool isActive;
  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: CustomColors.customSwatchColor),
              color: isActive
                  ? backgroundColor ?? CustomColors.customSwatchColor
                  : Colors.transparent),
          child: isActive
              ? const Icon(
                  Icons.check,
                  size: 13,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
