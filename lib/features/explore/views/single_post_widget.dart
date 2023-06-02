// ignore_for_file: use_build_context_synchronously, must_be_immutable
import 'dart:developer';

import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/app_text_styles.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/features/explore/controllers/explore_controller.dart';
import 'package:anime_fandom/utils/common_widgets/custom_dialog_widget.dart';
import 'package:anime_fandom/utils/common_widgets/custom_image_dialog.dart';
import 'package:anime_fandom/utils/common_widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';

class SinglePostWidget extends StatefulWidget {
  int index;
  SinglePostWidget({
    required this.index,
    super.key,
  });

  @override
  State<SinglePostWidget> createState() => _SinglePostWidgetState();
}

class _SinglePostWidgetState extends State<SinglePostWidget> {
  ExploreController exploreController = Get.put(ExploreController());

  @override
  void initState() {
    super.initState();
    // exploreController.utcToLocalTime(widget.index, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.postGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: 8.0 * SizeConfig.heightMultiplier!),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Obx(
                  () {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 14,
                      ),
                      child: exploreController.allPostModel.value
                                  .posts![widget.index].avatar !=
                              null
                          ? GestureDetector(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.grey3,
                                backgroundImage: NetworkImage(
                                  exploreController.allPostModel.value
                                      .posts![widget.index].avatar!,
                                  scale: 0.01,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: const CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.date24,
                                backgroundImage: AssetImage(ImagePath.icUser),
                              ),
                            ),
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () {
                        return GestureDetector(
                          onTap: () {},
                          child: Text(
                            "${exploreController.postUserName(widget.index)}",
                            style: AppTextStyles.f18W600White,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 2 * SizeConfig.heightMultiplier!,
                    ),
                    Obx(
                      () {
                        return Row(
                          children: [
                            Text(
                              "${exploreController.postTime(widget.index, context)}",
                              style: AppTextStyles.f14W400Grey5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Visibility(
                                visible: exploreController.allPostModel.value
                                        .posts![widget.index].location !=
                                    null,
                                child: const CircleAvatar(
                                  radius: 2,
                                  backgroundColor: AppColors.grey5,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: exploreController.allPostModel.value
                                      .posts![widget.index].location !=
                                  null,
                              child: Text(
                                "${exploreController.allPostModel.value.posts![widget.index].location}",
                                style: AppTextStyles.f14W400Grey5,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            if (exploreController.allPostModel.value.posts![widget.index]
                .description!.isNotEmpty)
              Obx(
                () {
                  return Visibility(
                    visible: exploreController.allPostModel.value
                            .posts![widget.index].description !=
                        null,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${exploreController.postDescription(widget.index)}",
                          style: AppTextStyles.f14W700Black.copyWith(),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  );
                },
              ),
            if (exploreController
                    .allPostModel.value.posts![widget.index].content !=
                null)
              Obx(
                () {
                  return Visibility(
                    visible: exploreController
                            .allPostModel.value.posts![widget.index].content !=
                        null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: SizedBox(
                        height: 155 * SizeConfig.heightMultiplier!,
                        width: SizeConfig.screenWidth,
                        child: GestureDetector(
                          onTap: () {
                            customDialogWidget(
                              context,
                              CustomImageDialog(
                                imageURL:
                                    '${exploreController.postImageUrl(widget.index)}',
                              ),
                            );
                          },
                          child: Image.network(
                            "${exploreController.postImageUrl(widget.index)}",
                            fit: BoxFit.fitWidth,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey4,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.asset(
                                        ImagePath.icRefresh,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            Obx(
              () {
                return Visibility(
                  visible: exploreController.postCommentsMap[
                              exploreController.postId(widget.index)] !=
                          0 ||
                      exploreController.postLikesMap[
                              exploreController.postId(widget.index)] !=
                          0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 2,
                      bottom: 2,
                    ),
                    child: SizedBox(
                      height: 18 * SizeConfig.heightMultiplier!,
                      width: SizeConfig.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            visible: exploreController.postLikesMap[
                                    exploreController.postId(widget.index)] !=
                                0,
                            child: Text(
                              "${exploreController.postLikes(widget.index, null)}",
                              style: AppTextStyles.f14W400White,
                            ),
                          ),
                          Visibility(
                            visible: exploreController.postCommentsMap[
                                        exploreController
                                            .postId(widget.index)] !=
                                    0 &&
                                exploreController.postLikesMap[exploreController
                                        .postId(widget.index)] !=
                                    0,
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: CircleAvatar(
                                radius: 2,
                                backgroundColor: AppColors.grey5,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: exploreController.postCommentsMap[
                                    exploreController.postId(widget.index)] !=
                                0,
                            child: Text(
                              "${exploreController.postComments(widget.index)}",
                              style: AppTextStyles.f14W400White,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 4,
                bottom: 4,
              ),
              child: SizedBox(
                height: 28 * SizeConfig.heightMultiplier!,
                width: SizeConfig.screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () {
                        return GestureDetector(
                          onTap: () {
                            exploreController.likePost(widget.index);
                          },
                          child: Image.asset(
                            exploreController.postIsLikedMap[
                                    exploreController.postId(widget.index)]
                                ? ImagePath.icHeartOn
                                : ImagePath.icHeartOff,
                            height: 25,
                            width: 25,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 12 * SizeConfig.widthMultiplier!,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        exploreController.postCommentsMap[
                                    exploreController.postId(widget.index)] !=
                                0
                            ? ImagePath.icCommentOn
                            : ImagePath.icCommentOff,
                        width: exploreController.postCommentsMap[
                                    exploreController.postId(widget.index)] !=
                                0
                            ? 25
                            : 28,
                      ),
                    ),
                    SizedBox(
                      width: 12 * SizeConfig.widthMultiplier!,
                    ),
                    Obx(
                      () {
                        return GestureDetector(
                          onTap: () {
                            exploreController.setFavourite(widget.index);
                          },
                          child: Image.asset(
                            exploreController.postIsFavouriteMap[
                                    exploreController.postId(widget.index)]
                                ? ImagePath.icStarOn
                                : ImagePath.icStarOff,
                            height: 25,
                            width: 25,
                          ),
                        );
                      },
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        String? path;
                        if (exploreController.allPostModel.value
                                .posts![widget.index].content !=
                            null) {
                          final imageURL = exploreController.allPostModel.value
                              .posts![widget.index].content!.url!;
                          path = await exploreController.downloadImage(
                              imageURL: imageURL);
                        }

                        if (path != null) {
                          try {
                            await Share.shareXFiles(
                              [XFile(path)],
                              text: exploreController.allPostModel.value
                                      .posts![widget.index].description ??
                                  '',
                              subject: 'Anime Fandom',
                            );
                          } catch (e) {
                            log("Failed to share post",
                                name: "SinglePostWidget()");
                          }
                        } else if (exploreController.allPostModel.value
                                .posts![widget.index].content ==
                            null) {
                          try {
                            await Share.share(
                              exploreController.allPostModel.value
                                      .posts![widget.index].description ??
                                  '',
                              subject: 'Anime Fandom',
                            );
                          } catch (e) {
                            log("Failed to share post",
                                name: "SinglePostWidget()");
                          }
                        } else {
                          CustomSnackbar.showSnackbar(
                            context: context,
                            backgroundColor: AppColors.red1,
                            message: 'Something went wrong',
                          );
                        }
                      },
                      child: Image.asset(
                        ImagePath.icShareOn,
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
