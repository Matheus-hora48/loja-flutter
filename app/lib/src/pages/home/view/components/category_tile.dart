import 'package:app/src/config/custom_colors.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({Key? key, required this.category, required this.isSelected, required this.onPressed}) : super(key: key);

  final String category;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onPressed,
      child: Align(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isSelected ? CustomColors.customSwatchColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Text(category, style: TextStyle(
            color: isSelected ? Colors.white : CustomColors.customContrastColor,
            fontSize: isSelected ? 12 : 14,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}