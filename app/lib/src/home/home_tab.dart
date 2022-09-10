import 'package:app/src/config/custom_colors.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key? key}) : super(key: key);

  List<String> categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(TextSpan(style: TextStyle(fontSize: 30), children: [
          TextSpan(
              text: 'Zap ',
              style: TextStyle(color: CustomColors.customSwatchColor)),
          TextSpan(
              text: 'Frutas',
              style: TextStyle(color: CustomColors.customContrastColor)),
        ])),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 15),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                  badgeColor: CustomColors.customContrastColor,
                  badgeContent: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    color: CustomColors.customSwatchColor,
                  )),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                hintText: 'Pesquise aqui',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: CustomColors.customContrastColor,
                  size: 21,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
