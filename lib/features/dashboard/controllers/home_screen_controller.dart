import 'dart:developer';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxInt selectedIndex = 2.obs;
  RxBool visibleBottomNavBar = true.obs;
  final scrollController = ScrollController().obs;
  final pageController = PageController(initialPage: 2).obs;

  onPageChanged(int index) {
    selectedIndex.value = index;
    visibleBottomNavBar.value = true;
    pageController.value = PageController();
  }

  setBottomNavBarVisibility(bool val) {
    visibleBottomNavBar.value = val;
    log("val --> $visibleBottomNavBar", name: "setBottomNavBarVisibility");
  }

  addScrollListener() {
    scrollController.value.addListener(
      () {
        if (scrollController.value.position.userScrollDirection ==
            ScrollDirection.reverse) {
          visibleBottomNavBar.value = false;
        }
        if (scrollController.value.position.userScrollDirection ==
            ScrollDirection.forward) {
          visibleBottomNavBar.value = true;
        }
      },
    );
  }
}
