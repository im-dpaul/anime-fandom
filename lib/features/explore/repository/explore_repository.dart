import 'dart:developer';

import 'package:anime_fandom/core/dio_utils.dart';
import 'package:anime_fandom/features/explore/models/all_post_model.dart';
import 'package:anime_fandom/routes/api_routes.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ExploreRepository {
  final _dioInstance = DioUtil().getInstance();

  Future<AllPostModel?> getAllPost() async {
    try {
      final response = await _dioInstance?.get(
        ApiRoutes.getAllPostsURL,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      if (response != null) {
        if (response.statusCode == 200) {
          AllPostModel allPostModel = AllPostModel.fromJson(response.data);
          return allPostModel;
        }
      }
    } catch (e) {
      log("getAllPost() Exception -> $e");
    }
    return null;
  }

  Future<bool> likePost(String postId) async {
    try {
      final response =
          await _dioInstance?.put("${ApiRoutes.likePostURL}/$postId");
      if (response != null) {
        if (response.statusCode == 201) {
          return true;
        }
      }
    } catch (e) {
      log("likePost() Exception -> $e");
    }
    return false;
  }

  Future<bool> setFavourite(String postId) async {
    try {
      final response =
          await _dioInstance?.put("${ApiRoutes.setFavouriteURL}/$postId");
      if (response != null) {
        if (response.statusCode == 201) {
          return true;
        }
      }
    } catch (e) {
      log("setFavourite() Exception -> $e");
    }
    return false;
  }

  Future downloadImage({required String path, bool? save}) async {
    try {
      Dio dio = Dio();
      String filePath;
      String name = DateTime.now().millisecondsSinceEpoch.toString();
      if (save != null && save) {
        name = path.split("/")[3];
        filePath =
            '/storage/emulated/0/Download/Anime Fandom/AnimeFandom-$name.jpg';
      } else {
        var dir = await getApplicationDocumentsDirectory();
        filePath = '${dir.path}/AnimeFandom-$name.jpg';
      }
      log('File Name in path = $filePath');
      final response = await dio.download(
        path,
        filePath,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return filePath;
      }
    } catch (e) {
      log('Exception -> $e', name: 'ExploreRepository downloadImage()');
    }
  }
}
