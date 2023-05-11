// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/features/explore/repository/explore_repository.dart';
import 'package:anime_fandom/main.dart';
import 'package:anime_fandom/utils/common_widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class CustomImageDialog extends ConsumerStatefulWidget {
  String imageURL;
  CustomImageDialog({required this.imageURL, super.key});

  @override
  ConsumerState<CustomImageDialog> createState() => _CustomImageDialogState();
}

class _CustomImageDialogState extends ConsumerState<CustomImageDialog> {
  @override
  void initState() {
    super.initState();
  }

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
                          String? path = await ref
                              .read(exploreController.notifier)
                              .downloadImage(
                                  imageURL: widget.imageURL, save: true);
                          if (path != null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("success"),
                              backgroundColor: AppColors.green2,
                            ));
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
                          String? path = await ref
                              .read(exploreController.notifier)
                              .downloadImage(imageURL: widget.imageURL);
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
                    widget.imageURL,
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
