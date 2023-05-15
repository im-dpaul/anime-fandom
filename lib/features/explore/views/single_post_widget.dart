// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/app_text_styles.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/main.dart';
import 'package:anime_fandom/utils/common_widgets/custom_dialog_widget.dart';
import 'package:anime_fandom/utils/common_widgets/custom_image_dialog.dart';
import 'package:anime_fandom/utils/common_widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class SinglePostWidget extends ConsumerWidget {
  const SinglePostWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool heart = true;
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 14,
                  ),
                  child: heart
                      ? GestureDetector(
                          onTap: () {},
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundColor: AppColors.date24,
                            backgroundImage: //AssetImage(ImagePath.icUser),
                                NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/1/10/Zayn_Wiki_%28cropped%29.jpg',
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
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Deb",
                        style: AppTextStyles.f18W600White,
                      ),
                    ),
                    SizedBox(
                      height: 2 * SizeConfig.heightMultiplier!,
                    ),
                    Row(
                      children: const [
                        Text(
                          "2h",
                          style: AppTextStyles.f14W400Grey5,
                        ),
                        Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Visibility(
                            visible: true,
                            child: CircleAvatar(
                              radius: 2,
                              backgroundColor: AppColors.grey5,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: true,
                          child: Text(
                            "Brentford",
                            style: AppTextStyles.f14W400Grey5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Visibility(
              visible: true,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "One Direction, often shortened to 1D, are an English-Irish pop boy band formed in London in 2010. The group is composed of Niall Horan, Liam Payne, Harry Styles, Louis Tomlinson, and previously Zayn Malik until his departure from the group in March 2015.",
                  style: AppTextStyles.f14W700Black,
                ),
              ),
            ),
            Visibility(
              visible: true,
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
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0sLS2SqBx7sXmD1focHt76O0YCHwK2nYRA-jre3x8BcYaNu1iRXywYC_4tiI6tzan58M&usqp=CAU',
                          // 'https://i.pinimg.com/originals/b1/6f/17/b16f17057928954c7b93772a92b37e36.jpg',
                        ),
                      );
                    },
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0sLS2SqBx7sXmD1focHt76O0YCHwK2nYRA-jre3x8BcYaNu1iRXywYC_4tiI6tzan58M&usqp=CAU",
                      fit: BoxFit.none,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: true,
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
                    children: const [
                      Visibility(
                        visible: true,
                        child: Text(
                          "32k loves",
                          style: AppTextStyles.f14W400White,
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: Padding(
                          padding: EdgeInsets.all(6.0),
                          child: CircleAvatar(
                            radius: 2,
                            backgroundColor: AppColors.grey5,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: Text(
                          "237 comments",
                          style: AppTextStyles.f14W400White,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                    GestureDetector(
                      onTap: () {
                        heart = !heart;
                      },
                      child: Image.asset(
                        heart ? ImagePath.icHeartOn : ImagePath.icHeartOff,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    SizedBox(
                      width: 12 * SizeConfig.widthMultiplier!,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        ImagePath.icCommentOn,
                        height: heart ? 25 : 28,
                        width: heart ? 25 : 28,
                      ),
                    ),
                    SizedBox(
                      width: 12 * SizeConfig.widthMultiplier!,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        heart ? ImagePath.icStarOn : ImagePath.icStarOff,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        String? path = await ref
                            .read(exploreController.notifier)
                            .downloadImage(
                                imageURL:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0sLS2SqBx7sXmD1focHt76O0YCHwK2nYRA-jre3x8BcYaNu1iRXywYC_4tiI6tzan58M&usqp=CAU');
                        if (path != null) {
                          try {
                            await Share.shareXFiles(
                              [XFile(path)],
                              text:
                                  'One Direction, often shortened to 1D, are an English-Irish pop boy band formed in London in 2010. The group is composed of Niall Horan, Liam Payne, Harry Styles, Louis Tomlinson, and previously Zayn Malik until his departure from the group in March 2015.',
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
