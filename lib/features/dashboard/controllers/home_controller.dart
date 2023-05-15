import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeController {
  int selectedIndex = 2;
  bool visibleBottomNavBar = true;
  PageController pageController = PageController(initialPage: 2);

  HomeController({
    required this.selectedIndex,
    required this.pageController,
    required this.visibleBottomNavBar,
  });

  HomeController copyWith({
    int? selectedIndex,
    bool? visibleBottomNavBar,
    PageController? pageController,
  }) {
    return HomeController(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      pageController: pageController ?? this.pageController,
      visibleBottomNavBar: visibleBottomNavBar ?? this.visibleBottomNavBar,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'selectedIndex': selectedIndex,
  //   };
  // }

  // factory HomeController.fromMap(Map<String, dynamic> map) {
  //   return HomeController(

  //     selectedIndex: map['selectedIndex'] as int,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory HomeController.fromJson(String source) => HomeController.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() => 'HomeController(selectedIndex: $selectedIndex)';

  // @override
  // bool operator ==(covariant HomeController other) {
  //   if (identical(this, other)) return true;

  //   return
  //     other.selectedIndex == selectedIndex;
  // }

  // @override
  // int get hashCode => selectedIndex.hashCode;
}

class HomeControllerNotifier extends StateNotifier<HomeController> {
  HomeControllerNotifier()
      : super(
          HomeController(
            selectedIndex: 2,
            visibleBottomNavBar: true,
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
  }
}
