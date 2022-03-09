import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:ummaku/page/chat_page.dart';
import 'package:ummaku/page/home_page.dart';
import 'package:ummaku/page/profil_page.dart';
import 'package:ummaku/page/search_page.dart';

class NavigationController extends GetxController {
  var widgetItems = [
    const HomePge(),
    const SearchPage(),
    const ChatPage(),
    const ProfilPage(),
  ];
  var index = 0;
  int get ind => index;
  List<Widget> get widgets => widgetItems;

  changeIndex(int idx) {
    index = idx;
    update();
  }
}
