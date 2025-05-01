import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController with GetTickerProviderStateMixin {

  RxInt menuIndex = 0.obs;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 5, vsync: this);
  }

  void changeBottomNav(int index) {
    menuIndex(index);
    tabController.animateTo(index);
  }
}