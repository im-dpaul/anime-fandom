import 'package:anime_fandom/features/explore/repository/explore_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController {
  RxBool visibleBottomNavBar = true.obs;
  final scrollController = ScrollController().obs;

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
