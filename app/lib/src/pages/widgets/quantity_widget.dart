import 'package:app/src/config/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget(
      {Key? key,
      required this.value,
      required this.suffixText,
      required this.result,
      this.isRemovable = false})
      : super(key: key);

  final int value;
  final String suffixText;
  final Function(int quantity) result;
  final bool isRemovable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ]),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        _QuantityButton(
          color: !isRemovable || value > 1 ? Colors.grey : Colors.redAccent,
          icon: !isRemovable || value > 1 ? Icons.remove : Icons.delete_forever,
          onPressed: () {
            if (value == 1 && !isRemovable) return;
            int resultCount = value - 1;
            result(resultCount);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            '$value$suffixText',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _QuantityButton(
          color: CustomColors.customSwatchColor,
          icon: Icons.add,
          onPressed: () {
            int resultCount = value + 1;
            result(resultCount);
          },
        ),
      ]),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onPressed,
        child: Ink(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}
