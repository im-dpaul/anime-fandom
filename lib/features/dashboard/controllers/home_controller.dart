import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeController {
  int selectedIndex = 2;
  bool visibleBottomNavBar = true;
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController(initialPage: 2);

  HomeController({
    required this.selectedIndex,
    required this.pageController,
    required this.scrollController,
    required this.visibleBottomNavBar,
  });

  HomeController copyWith({
    int? selectedIndex,
    bool? visibleBottomNavBar,
    PageController? pageController,
    ScrollController? scrollController,
  }) {
    return HomeController(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      pageController: pageController ?? this.pageController,
      scrollController: scrollController ?? this.scrollController,
      visibleBottomNavBar: visibleBottomNavBar ?? this.visibleBottomNavBar,
    );
  }
}

class HomeControllerNotifier extends StateNotifier<HomeController> {
  HomeControllerNotifier()
      : super(
          HomeController(
            selectedIndex: 2,
            visibleBottomNavBar: true,
            scrollController: ScrollController(),
            pageController: PageController(initialPage: 2),
          ),
        );

  onPageChanged(int index) {
    state = state.copyWith(
      selectedIndex: index,
      visibleBottomNavBar: true,
      pageController: PageController(),
    );
  }

  setBottomNavBarVisibility(bool val) {
    state = state.copyWith(visibleBottomNavBar: val);
    log("val --> ${state.visibleBottomNavBar}");
  }

  addScrollListener() {
    state.scrollController.addListener(
      () {
        if (state.scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          state = state.copyWith(visibleBottomNavBar: false);
        }
        if (state.scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          state = state.copyWith(visibleBottomNavBar: true);
        }
      },
    );
  }
}
