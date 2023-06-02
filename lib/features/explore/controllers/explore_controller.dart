import 'dart:developer';

import 'package:anime_fandom/features/explore/models/all_post_model.dart';
import 'package:anime_fandom/features/explore/repository/explore_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool visibleBottomNavBar = true.obs;
  final scrollController = ScrollController().obs;

  RxMap postLikesMap = {}.obs;
  RxMap postCommentsMap = {}.obs;
  RxMap postIsLikedMap = {}.obs;
  RxMap postIsFavouriteMap = {}.obs;
  Rx<AllPostModel> allPostModel = AllPostModel().obs;

  final exploreRepository = ExploreRepository();

  getAllPost() async {
    isLoading.value = true;
    final result = await exploreRepository.getAllPost();
    if (result == null) {
      log("null$result");
    } else if (result.success == true) {
      allPostModel.value = result;
      allPostModel.value.posts?.forEach((post) {
        postLikesMap[post.id] = post.numOfLikes;
        postCommentsMap[post.id] = post.numOfComments;
        postIsLikedMap[post.id] = post.isLiked;
        postIsFavouriteMap[post.id] = post.isFavorites;
      });
    } else {
      log("else");
    }
    isLoading.value = false;
  }

  likePost(int index) async {
    final postId = allPostModel.value.posts![index].id!;

    postIsLikedMap[postId] = !postIsLikedMap[postId];
    postLikes(index, postIsLikedMap[postId]);
    final success = await exploreRepository.likePost(postId);
    if (!success) {
      postIsLikedMap[postId] = !postIsLikedMap[postId];
      postLikes(index, postIsLikedMap[postId]);
    }
  }

  setFavourite(int index) async {
    final postId = allPostModel.value.posts![index].id!;
    postIsFavouriteMap[postId] = !postIsFavouriteMap[postId];
    final success = await exploreRepository.setFavourite(postId);
    if (!success) {
      postIsFavouriteMap[postId] = !postIsFavouriteMap[postId];
    }
  }

  // sharePost({required String imageURL}) async {
  //   String? path = await exploreRepository.downloadImage(path: imageURL);
  // }

  downloadImage({required String imageURL, bool? save}) async {
    String? path =
        await exploreRepository.downloadImage(path: imageURL, save: save);
    return path;
  }

  // functions for UI

  postId(int index) {
    final postId = allPostModel.value.posts![index].id;
    return postId;
  }

  postUserName(int index) {
    String name;
    String firstName = allPostModel.value.posts![index].firstName ?? '';
    String lastName = allPostModel.value.posts![index].lastName ?? '';
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      name = '$firstName $lastName';
    } else {
      name = firstName + lastName;
    }
    return name;
  }

  postTime(int index, BuildContext context) {
    final utcTime = allPostModel.value.posts![index].createdAt;
    final localTime = utcTime!.toLocal();
    final now = DateTime.now();
    final dayDiff = now.difference(localTime).inDays;
    String dayDifference;
    if (dayDiff == 0) {
      dayDifference = TimeOfDay.fromDateTime(localTime).format(context);
    } else if (dayDiff == 1) {
      dayDifference = 'Yesterday';
    } else if (dayDiff == 2) {
      dayDifference = '2 days ago';
    } else if (dayDiff == 3) {
      dayDifference = '3 days ago';
    } else if (dayDiff == 4) {
      dayDifference = '4 days ago';
    } else if (dayDiff == 5) {
      dayDifference = '5 days ago';
    } else if (dayDiff == 6) {
      dayDifference = '6 days ago';
    } else if (dayDiff >= 7 && dayDiff <= 13) {
      dayDifference = '1 week ago';
    } else if (dayDiff >= 14 && dayDiff <= 20) {
      dayDifference = '2 weeks ago';
    } else if (dayDiff >= 21 && dayDiff <= 27) {
      dayDifference = '3 weeks ago';
    } else if (dayDiff >= 28 && dayDiff <= 59) {
      dayDifference = '1 month ago';
    } else if (dayDiff >= 60 && dayDiff <= 89) {
      dayDifference = '2 months ago';
    } else if (dayDiff >= 90 && dayDiff <= 119) {
      dayDifference = '3 months ago';
    } else if (dayDiff >= 180 && dayDiff <= 364) {
      dayDifference = '6 months ago';
    } else if (dayDiff >= 365 && dayDiff <= 730) {
      dayDifference = '1 year ago';
    } else {
      String day;
      String month;
      if (localTime.day < 10) {
        day = "0${localTime.day}";
      } else {
        day = localTime.day.toString();
      }
      if (localTime.month < 10) {
        month = "0${localTime.month}";
      } else {
        month = localTime.month.toString();
      }
      dayDifference = "$day.$month.${localTime.year}";
    }

    return dayDifference;
  }

  postDescription(int index) {
    final description = allPostModel.value.posts![index].description ?? '';
    return description;
  }

  postImageUrl(int index) {
    final imageUrl = allPostModel.value.posts![index].content!.url;
    return imageUrl;
  }

  postLikes(int index, bool? val) {
    int like;
    final pId = postId(index);
    if (val == null) {
    } else if (val) {
      postLikesMap[pId] = postLikesMap[pId] + 1;
    } else {
      postLikesMap[pId] = postLikesMap[pId] - 1;
    }
    like = postLikesMap[pId];

    String likes;
    if (like == 0) {
      likes = '';
    } else if (like == 1) {
      likes = '1 like';
    } else if (like > 1 && like < 1000) {
      likes = '$like likes';
    } else if (like >= 1000 && like < 2000) {
      likes = '1k likes';
    } else if (like >= 2000 && like < 3000) {
      likes = '2k likes';
    } else if (like >= 3000 && like < 4000) {
      likes = '3k likes';
    } else if (like >= 4000 && like < 5000) {
      likes = '4k likes';
    } else if (like >= 5000 && like < 10000) {
      likes = '5k+ likes';
    } else if (like >= 10000 && like < 50000) {
      likes = '10k+ likes';
    } else if (like >= 50000 && like < 100000) {
      likes = '50k+ likes';
    } else {
      likes = '100k+ likes';
    }

    return likes;
  }

  postComments(int index) {
    final pId = postId(index);
    int comment = postCommentsMap[pId];
    String comments;
    if (comment == 0) {
      comments = '';
    } else if (comment == 1) {
      comments = '1 comment';
    } else if (comment > 1 && comment < 1000) {
      comments = '$comment comments';
    } else if (comment >= 1000 && comment < 2000) {
      comments = '1k comments';
    } else if (comment >= 2000 && comment < 3000) {
      comments = '2k comments';
    } else if (comment >= 3000 && comment < 4000) {
      comments = '3k comments';
    } else if (comment >= 4000 && comment < 5000) {
      comments = '4k comments';
    } else if (comment >= 5000 && comment < 10000) {
      comments = '5k+ comments';
    } else if (comment >= 10000 && comment < 50000) {
      comments = '10k+ comments';
    } else if (comment >= 50000 && comment < 100000) {
      comments = '50k+ comments';
    } else {
      comments = '100k+ comments';
    }

    return comments;
  }
}
