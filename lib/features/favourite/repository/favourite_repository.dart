import 'dart:developer';

import 'package:anime_fandom/core/dio_utils.dart';
import 'package:anime_fandom/features/favourite/model/all_favourite_model.dart';
import 'package:anime_fandom/routes/api_routes.dart';
import 'package:dio/dio.dart';

class FavouriteRepository {
  final _dioInstance = DioUtil().getInstance();

  Future<AllFavouriteModel?> getAllFavourite() async {
    try {
      final response = await _dioInstance?.get(
        ApiRoutes.getAllFavouriteURL,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      if (response != null) {
        if (response.statusCode == 200) {
          AllFavouriteModel allFavouriteModel =
              AllFavouriteModel.fromJson(response.data);
          return allFavouriteModel;
        }
      }
    } catch (e) {
      log("getAllFavourite() Exception -> $e");
    }
    return null;
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
}
