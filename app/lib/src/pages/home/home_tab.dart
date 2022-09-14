import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:app/src/config/app_data.dart' as app_data;
import 'package:app/src/config/custom_colors.dart';
import 'package:app/src/pages/home/components/category_tile.dart';
import 'package:app/src/pages/home/components/item_title.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCatrgory = 'Frutas';
  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCardAnimation;

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

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
                  child: AddToCartIcon(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: CustomColors.customSwatchColor,
                    ),
                    key: globalKeyCartItems,
                  )),
            ),
          )
        ],
      ),
      body: AddToCartAnimation(
        gkCart: globalKeyCartItems,
        previewDuration: const Duration(milliseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          runAddToCardAnimation = addToCardAnimationMethod;
        },
        child: Column(
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
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return CategoryTile(
                    onPressed: () {
                      setState(() {
                        selectedCatrgory = app_data.categories[index];
                      });
                    },
                    category: app_data.categories[index],
                    isSelected: app_data.categories[index] == selectedCatrgory,
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(
                  width: 10,
                ),
                itemCount: app_data.categories.length,
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 9 / 11.5),
                itemCount: app_data.items.length,
                itemBuilder: (_, index) {
                  return ItemTile(
                      item: app_data.items[index],
                      cartAnimationMethod: itemSelectedCartAnimations);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
