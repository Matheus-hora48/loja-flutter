import 'package:app/src/config/custom_colors.dart';
import 'package:app/src/pages/base/controller/navigation_controller.dart';
import 'package:app/src/pages/cart/view/cart_tab.dart';
import 'package:app/src/pages/home/view/home_tab.dart';
import 'package:app/src/pages/orders/view/orders_tab.dart';
import 'package:app/src/pages/profile/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: navigationController.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeTab(),
            CartTab(),
            OrdersTab(),
            ProfileTab(),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: navigationController.currentIndex,
            onTap: (index) {
              navigationController.navigatePageView(index);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: CustomColors.customSwatchColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withAlpha(80),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Carrinho',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Pedidos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Perfil',
              ),
            ],
          ),
        ));
  }
}
