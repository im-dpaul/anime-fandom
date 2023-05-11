import 'package:anime_fandom/features/explore/repository/explore_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreController {}

class ExploreControllerNotifier extends StateNotifier<ExploreController> {
  ExploreControllerNotifier() : super(ExploreController());

  final exploreRepository = ExploreRepository();

  sharePost({required String imageURL}) async {
    String? path = await exploreRepository.downloadImage(path: imageURL);
  }

  downloadImage({required String imageURL, bool? save}) async {
    String? path =
        await exploreRepository.downloadImage(path: imageURL, save: save);
    return path;
  }
}
