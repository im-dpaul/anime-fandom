// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/app_text_styles.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/features/favourite/controllers/favourite_controller.dart';
import 'package:anime_fandom/utils/common_widgets/custom_bottom_sheet.dart';
import 'package:anime_fandom/utils/common_widgets/custom_decision_widget.dart';
import 'package:anime_fandom/utils/common_widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class SingleFavouriteWidget extends StatelessWidget {
  int index;
  SingleFavouriteWidget({required this.index, super.key});
  final FavouriteController favouriteController =
      Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0 * SizeConfig.heightMultiplier!),
      child: SizedBox(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 82,
                width: 96,
                decoration: BoxDecoration(
                  color: AppColors.grey3,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: favouriteController.postImageUrl(index) == ''
                    ? GestureDetector(
                        onTap: () {},
                        child: const Center(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.grey3,
                            backgroundImage: AssetImage(ImagePath.icUser),
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          favouriteController.postImageUrl(index),
                          fit: BoxFit.cover,
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
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        favouriteController.postDescription(index),
                        style: AppTextStyles.f16W400White,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        favouriteController.postUserName(index),
                        style: AppTextStyles.f12W400Grey5,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      favouriteController.postTime(index, context),
                      style: AppTextStyles.f12W400Grey5,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  backgroundColor: AppColors.bgColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  builder: (context) {
                    return CustomBottomSheet(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                String? path;
                                if (favouriteController.allFavouriteModel.value
                                        .data![index].content !=
                                    null) {
                                  final imageURL = favouriteController
                                      .allFavouriteModel
                                      .value
                                      .data![index]
                                      .content!
                                      .url!;
                                  path = await favouriteController
                                      .downloadImage(imageURL: imageURL);
                                }

                                if (path != null) {
                                  try {
                                    await Share.shareXFiles(
                                      [XFile(path)],
                                      text: favouriteController
                                              .allFavouriteModel
                                              .value
                                              .data![index]
                                              .description ??
                                          '',
                                      subject: 'Anime Fandom',
                                    );
                                  } catch (e) {
                                    log("Failed to share post",
                                        name: "SinglePostWidget()");
                                  }
                                } else if (favouriteController.allFavouriteModel
                                        .value.data![index].content ==
                                    null) {
                                  try {
                                    await Share.share(
                                      favouriteController.allFavouriteModel
                                              .value.data![index].description ??
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
                              child: Row(
                                children: [
                                  Image.asset(
                                    ImagePath.icShareOn,
                                    height: 22,
                                    width: 22,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Text(
                                    "Share",
                                    style: AppTextStyles.f16W300Grey5,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await Clipboard.setData(
                                  const ClipboardData(
                                    text: "your text",
                                  ),
                                ).then(
                                  (_) {
                                    Navigator.pop(context);
                                    CustomSnackbar.showSnackbar(
                                      context: context,
                                      message: 'Copied to Clipboard.',
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    ImagePath.icLink,
                                    height: 25,
                                    width: 25,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Text(
                                    "Copy link",
                                    style: AppTextStyles.f16W300Grey5,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDecisionWidget(
                                      description:
                                          'Are you sure you want to remove this?',
                                      firstButtontitle: 'Cancel',
                                      secondButtonTitle: 'Yes',
                                      onFirstButtonTap: () {
                                        Navigator.pop(context);
                                      },
                                      onSecondButtonTap: () async {
                                        final result = await favouriteController
                                            .setFavourite(index);
                                        if (result) {
                                          await favouriteController
                                              .getAllFavourite();
                                          Navigator.pop(context);
                                          Navigator.pop(context);

                                          CustomSnackbar.showSnackbar(
                                            context: context,
                                            message: 'Removed successfully.',
                                          );
                                        } else {
                                          CustomSnackbar.showSnackbar(
                                            context: context,
                                            message: 'Failed to remove.',
                                          );
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    ImagePath.icDustbin,
                                    height: 25,
                                    width: 25,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Text(
                                    "Remove from favourite",
                                    style: AppTextStyles.f16W300Grey5,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Image.asset(
                ImagePath.icMore,
                width: 20,
                height: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
