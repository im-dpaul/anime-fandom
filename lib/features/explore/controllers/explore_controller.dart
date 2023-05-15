import 'package:anime_fandom/features/explore/repository/explore_repository.dart';
import 'package:flutter/material.dart';
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
  final exploreRepository = ExploreRepository();

  // sharePost({required String imageURL}) async {
  //   String? path = await exploreRepository.downloadImage(path: imageURL);
  // }

  downloadImage({required String imageURL, bool? save}) async {
    String? path =
        await exploreRepository.downloadImage(path: imageURL, save: save);
    return path;
  }
}
