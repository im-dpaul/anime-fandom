// ignore_for_file: use_build_context_synchronously, must_be_immutable
import 'dart:developer';

import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/features/explore/controllers/explore_controller.dart';
import 'package:anime_fandom/utils/common_methods/notification_controller.dart';
import 'package:anime_fandom/utils/common_widgets/custom_snackbar.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class CustomImageDialog extends StatelessWidget {
  final String imageURL;
  CustomImageDialog({required this.imageURL, super.key});

  ExploreController exploreController = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: AppColors.black1.withOpacity(0.88),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: () async {
                          String? path = await exploreController.downloadImage(
                              imageURL: imageURL, save: true);

                          if (path != null) {
                            final img = path.split('/')[6];
                            await NotificationController().showNotification(
                              id: 1,
                              title: img,
                              body: 'Download complete.',
                              bigPicture:
                                  imageURL, //'asset://assets/frediLogoSlogan.png',
                              largeIcon: imageURL,
                              notificationLayout: NotificationLayout.BigPicture,
                              category: NotificationCategory.Promo,
                              hideLargeIconOnExpand: true,
                            );
                            CustomSnackbar.showSnackbar(
                              context: context,
                              backgroundColor: AppColors.green2,
                              message: 'Image downloaded successfully',
                            );
                          } else {
                            CustomSnackbar.showSnackbar(
                              context: context,
                              backgroundColor: AppColors.red1,
                              message: 'Failed to download image',
                            );
                          }
                        },
                        child: Image.asset(
                          ImagePath.icDownload,
                          height: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () async {
                          String? path = await exploreController.downloadImage(
                              imageURL: imageURL);
                          if (path != null) {
                            try {
                              await Share.shareXFiles(
                                [XFile(path)],
                              );
                            } catch (e) {
                              log("message");
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
                          width: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          ImagePath.icCancel,
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network(
                    imageURL,
                    fit: BoxFit.contain,
                    // height: SizeConfig.screenHeight! * 0.9,
                    width: SizeConfig.screenWidth,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
