import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController{
  final index = 0.obs;
  late PageController pageController;

  void updateIndex(int index){
    this.index.value = index;
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
