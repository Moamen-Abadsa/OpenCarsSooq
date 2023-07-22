import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/views/tabs/favorites_tab.dart';
import 'package:opencarssooq/views/tabs/home_tab.dart';
import 'package:opencarssooq/views/tabs/offers_tab.dart';
import 'package:opencarssooq/views/tabs/search_tab.dart';
import 'package:opencarssooq/views/tabs/settings_tab.dart';

class MainController extends GetxController with GetSingleTickerProviderStateMixin {

  late TabController tabController;
  ScrollController scrollController = ScrollController();
  int currentIndex = 0;

  List<Widget> bottomNavPages = <Widget>[
    HomeTab(),
    FavoritesTab(),
    OffersTab(),
    SearchTab(),
    SettingsTab(),
  ];

  onItemTapped(int index) {
    currentIndex = index;
    update();
  }

  @override
  void onInit() {
    tabController = TabController(
      initialIndex: 0,
      length: bottomNavPages.length,
      vsync: this,
    );
    tabController.addListener(() {
      onItemTapped(tabController.index);
    });
    super.onInit();
  }

}
