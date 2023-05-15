import 'dart:developer';

import 'package:anime_fandom/features/dashboard/controllers/home_controller.dart';
import 'package:anime_fandom/features/explore/repository/explore_repository.dart';
import 'package:anime_fandom/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreController {
  bool visibleBottomNavBar = true;
  ScrollController scrollController = ScrollController();

  ExploreController({
    required this.scrollController,
    required this.visibleBottomNavBar,
  });

  ExploreController copyWith({
    bool? visibleBottomNavBar,
    ScrollController? scrollController,
  }) {
    return ExploreController(
      scrollController: scrollController ?? this.scrollController,
      visibleBottomNavBar: visibleBottomNavBar ?? this.visibleBottomNavBar,
    );
  }
}

class ExploreControllerNotifier extends StateNotifier<ExploreController> {
  ExploreControllerNotifier()
      : super(
          ExploreController(
            visibleBottomNavBar: true,
            scrollController: ScrollController(),
          ),
        );
  final _homeController = HomeControllerNotifier();
  final exploreRepository = ExploreRepository();

  setBottomNavBarVisibility(bool val) {
    state = state.copyWith(visibleBottomNavBar: val);
    // if (state.scrollController.position.userScrollDirection ==
    //     ScrollDirection.reverse) {
    //   state = state.copyWith(visibleBottomNavBar: false);
    // }
    // if (state.scrollController.position.userScrollDirection ==
    //     ScrollDirection.forward) {
    //   state = state.copyWith(visibleBottomNavBar: true);
    // }
    log("---${state.visibleBottomNavBar}", name: "v ex");
    // _homeController.setBottomNavBarVisibility(state.visibleBottomNavBar);
  }

  // sharePost({required String imageURL}) async {
  //   String? path = await exploreRepository.downloadImage(path: imageURL);
  // }

  downloadImage({required String imageURL, bool? save}) async {
    String? path =
        await exploreRepository.downloadImage(path: imageURL, save: save);
    return path;
  }
}
