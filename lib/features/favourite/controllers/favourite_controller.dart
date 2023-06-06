import 'dart:developer';

import 'package:anime_fandom/constants/constant_data.dart';
import 'package:anime_fandom/features/favourite/model/all_favourite_model.dart';
import 'package:anime_fandom/features/favourite/repository/favourite_repository.dart';
import 'package:anime_fandom/utils/common_methods/file_download_methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool visibleBottomNavBar = true.obs;
  final scrollController = ScrollController().obs;

  Rx<AllFavouriteModel> allFavouriteModel = AllFavouriteModel().obs;

  final favouriteRepository = FavouriteRepository();

  getAllFavourite() async {
    isLoading.value = true;

    final result = await favouriteRepository.getAllFavourite();
    if (result == null) {
      log("null$result");
    } else if (result.success == true) {
      allFavouriteModel.value = result;
    } else {
      log("else");
    }
    isLoading.value = false;
  }

  setFavourite(int index) async {
    bool success = false;
    final postId = allFavouriteModel.value.data![index].id!;
    success = await favouriteRepository.setFavourite(postId);

    return success;
  }

  downloadImage({required String imageURL, bool? save}) async {
    String? path =
        await FileDownloadMethods.downloadImage(path: imageURL, save: save);
    return path;
  }

  // favourite screen methods

  postUserName(int index) {
    String name;
    String firstName = allFavouriteModel.value.data![index].firstName ?? '';
    String lastName = allFavouriteModel.value.data![index].lastName ?? '';
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      name = '$firstName $lastName';
    } else {
      name = firstName + lastName;
    }
    return name;
  }

  postTime(int index, BuildContext context) {
    final utcTime =
        allFavouriteModel.value.data![index].favorites![0].createdAt;
    final localTime = utcTime!.toLocal();
    final now = DateTime.now();
    final dayDiff = now.difference(localTime).inDays;
    String dayDifference;
    if (dayDiff == 0) {
      dayDifference =
          "Saved at ${TimeOfDay.fromDateTime(localTime).format(context)}";
    } else if (dayDiff == 1) {
      dayDifference = 'Saved 1d ago';
    } else if (dayDiff == 2) {
      dayDifference = 'Saved 2d ago';
    } else if (dayDiff == 3) {
      dayDifference = 'Saved 3d ago';
    } else if (dayDiff == 4) {
      dayDifference = 'Saved 4d ago';
    } else if (dayDiff == 5) {
      dayDifference = 'Saved 5d ago';
    } else if (dayDiff == 6) {
      dayDifference = 'Saved 6d ago';
    } else if (dayDiff >= 7 && dayDiff <= 13) {
      dayDifference = 'Saved 1w ago';
    } else if (dayDiff >= 14 && dayDiff <= 20) {
      dayDifference = 'Saved 2w ago';
    } else if (dayDiff >= 21 && dayDiff <= 27) {
      dayDifference = 'Saved 3w ago';
    } else if (dayDiff >= 28 && dayDiff <= 364) {
      String day;
      String month;
      if (localTime.day < 10) {
        day = "0${localTime.day}";
      } else {
        day = localTime.day.toString();
      }

      month = ConstantData.monthName[localTime.month - 1];

      dayDifference = "Saved on $day $month";
    } else if (dayDiff >= 365 && dayDiff <= 730) {
      dayDifference = 'Saved 1y ago';
    } else {
      String day;
      String month;
      if (localTime.day < 10) {
        day = "0${localTime.day}";
      } else {
        day = localTime.day.toString();
      }
      month = ConstantData.monthName[localTime.month - 1];
      dayDifference = "Saved on $day $month ${localTime.year}";
    }

    return dayDifference;
  }

  postDescription(int index) {
    final description =
        allFavouriteModel.value.data![index].description ?? 'Image';
    return description;
  }

  String postImageUrl(int index) {
    String imageUrl;
    if (allFavouriteModel.value.data![index].content == null) {
      imageUrl = allFavouriteModel.value.data![index].avatar ?? '';
    } else {
      imageUrl = allFavouriteModel.value.data![index].content!.url!;
    }
    return imageUrl;
  }
}
