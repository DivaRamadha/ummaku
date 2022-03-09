import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ummaku/controllers/navigation_controller.dart';
import 'package:ummaku/style/theme.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(NavigationController());

    return GetBuilder<NavigationController>(
        init: NavigationController(),
        builder: (controller) {
          return Scaffold(
            body: controller.widgets[controller.ind],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.ind,
              onTap: (e) async {
                // ThemeService().switchTheme();
                await cartController.changeIndex(e);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                  activeIcon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined),
                  label: 'Cari Properti',
                  activeIcon: Icon(
                    Icons.search_rounded,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_outlined),
                  label: 'Chat',
                  activeIcon: Icon(Icons.chat),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Profil',
                  activeIcon: Icon(Icons.person),
                )
              ],
            ),
          );
        });
  }
}
