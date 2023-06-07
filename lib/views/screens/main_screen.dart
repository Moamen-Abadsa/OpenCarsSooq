import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main_controller.dart';
import '../widgets/main/custom_bottom_navigation_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<MainController>(builder: (controller) {
          return controller.bottomNavPages[controller.currentIndex]; //New
        }),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}
