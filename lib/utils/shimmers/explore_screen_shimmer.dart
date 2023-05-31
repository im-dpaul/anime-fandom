import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ExploreScreenShimmer extends StatefulWidget {
  const ExploreScreenShimmer({super.key});

  @override
  State<ExploreScreenShimmer> createState() => _ExploreScreenShimmerState();
}

class _ExploreScreenShimmerState extends State<ExploreScreenShimmer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.postGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Shimmer.fromColors(
                  baseColor: AppColors.grey3,
                  highlightColor: AppColors.grey5Opacity25,
                  direction: ShimmerDirection.ltr,
                  loop: 0,
                  period: const Duration(milliseconds: 2000),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0 * SizeConfig.heightMultiplier!),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 14,
                              ),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.date24,
                                backgroundImage: AssetImage(ImagePath.icUser),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 145,
                                  height: 16,
                                  color: AppColors.grey3,
                                ),
                                SizedBox(
                                  height: 3 * SizeConfig.heightMultiplier!,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 46,
                                      height: 16,
                                      color: AppColors.grey3,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Visibility(
                                        visible: true,
                                        child: CircleAvatar(
                                          radius: 2,
                                          backgroundColor: AppColors.grey3,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 46,
                                      height: 16,
                                      color: AppColors.grey3,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth,
                                height: 16,
                                color: AppColors.grey3,
                              ),
                              SizedBox(
                                height: 3 * SizeConfig.heightMultiplier!,
                              ),
                              Container(
                                width: SizeConfig.screenWidth,
                                height: 16,
                                color: AppColors.grey3,
                              ),
                              SizedBox(
                                height: 3 * SizeConfig.heightMultiplier!,
                              ),
                              Container(
                                width: SizeConfig.screenWidth,
                                height: 16,
                                color: AppColors.grey3,
                              ),
                              SizedBox(
                                height: 3 * SizeConfig.heightMultiplier!,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 220 * SizeConfig.widthMultiplier!,
                                  height: 16,
                                  color: AppColors.grey3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
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
                                Container(
                                  width: 66,
                                  height: 16,
                                  color: AppColors.grey3,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: CircleAvatar(
                                    radius: 2,
                                    backgroundColor: AppColors.grey3,
                                  ),
                                ),
                                Container(
                                  width: 66,
                                  height: 16,
                                  color: AppColors.grey3,
                                ),
                              ],
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
                                Image.asset(
                                  ImagePath.icHeartOff,
                                  height: 28,
                                  width: 28,
                                ),
                                SizedBox(
                                  width: 12 * SizeConfig.widthMultiplier!,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    ImagePath.icCommentOff,
                                    height: 28,
                                    width: 28,
                                  ),
                                ),
                                SizedBox(
                                  width: 12 * SizeConfig.widthMultiplier!,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    ImagePath.icStarOff,
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    ImagePath.icShareOff,
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.postGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Shimmer.fromColors(
                  baseColor: AppColors.grey3,
                  highlightColor: AppColors.grey5Opacity25,
                  direction: ShimmerDirection.ltr,
                  loop: 0,
                  period: const Duration(milliseconds: 2000),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0 * SizeConfig.heightMultiplier!),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 14,
                              ),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.date24,
                                backgroundImage: AssetImage(ImagePath.icUser),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 145,
                                  height: 16,
                                  color: AppColors.grey3,
                                ),
                                SizedBox(
                                  height: 3 * SizeConfig.heightMultiplier!,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 46,
                                      height: 16,
                                      color: AppColors.grey3,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Visibility(
                                        visible: true,
                                        child: CircleAvatar(
                                          radius: 2,
                                          backgroundColor: AppColors.grey3,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 46,
                                      height: 16,
                                      color: AppColors.grey3,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth,
                                height: 16,
                                color: AppColors.grey3,
                              ),
                              SizedBox(
                                height: 3 * SizeConfig.heightMultiplier!,
                              ),
                              Container(
                                width: SizeConfig.screenWidth,
                                height: 16,
                                color: AppColors.grey3,
                              ),
                              SizedBox(
                                height: 3 * SizeConfig.heightMultiplier!,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 220 * SizeConfig.widthMultiplier!,
                                  height: 16,
                                  color: AppColors.grey3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Container(
                            height: 155 * SizeConfig.heightMultiplier!,
                            width: SizeConfig.screenWidth,
                            color: AppColors.grey3,
                          ),
                        ),
                        Padding(
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
                                Container(
                                  width: 66,
                                  height: 16,
                                  color: AppColors.grey3,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: CircleAvatar(
                                    radius: 2,
                                    backgroundColor: AppColors.grey3,
                                  ),
                                ),
                                Container(
                                  width: 66,
                                  height: 16,
                                  color: AppColors.grey3,
                                ),
                              ],
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
                                Image.asset(
                                  ImagePath.icHeartOff,
                                  height: 28,
                                  width: 28,
                                ),
                                SizedBox(
                                  width: 12 * SizeConfig.widthMultiplier!,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    ImagePath.icCommentOff,
                                    height: 28,
                                    width: 28,
                                  ),
                                ),
                                SizedBox(
                                  width: 12 * SizeConfig.widthMultiplier!,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    ImagePath.icStarOff,
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    ImagePath.icShareOff,
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.postGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Shimmer.fromColors(
                  baseColor: AppColors.grey3,
                  highlightColor: AppColors.grey5Opacity25,
                  direction: ShimmerDirection.ltr,
                  loop: 0,
                  period: const Duration(milliseconds: 2000),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0 * SizeConfig.heightMultiplier!),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 14,
                              ),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.date24,
                                backgroundImage: AssetImage(ImagePath.icUser),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 145,
                                  height: 16,
                                  color: AppColors.grey3,
                                ),
                                SizedBox(
                                  height: 3 * SizeConfig.heightMultiplier!,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 46,
                                      height: 16,
                                      color: AppColors.grey3,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Visibility(
                                        visible: true,
                                        child: CircleAvatar(
                                          radius: 2,
                                          backgroundColor: AppColors.grey3,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 46,
                                      height: 16,
                                      color: AppColors.grey3,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Container(
                            height: 155 * SizeConfig.heightMultiplier!,
                            width: SizeConfig.screenWidth,
                            color: AppColors.grey3,
                          ),
                        ),
                        Padding(
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
                                Container(
                                  width: 66,
                                  height: 16,
                                  color: AppColors.grey3,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: CircleAvatar(
                                    radius: 2,
                                    backgroundColor: AppColors.grey3,
                                  ),
                                ),
                                Container(
                                  width: 66,
                                  height: 16,
                                  color: AppColors.grey3,
                                ),
                              ],
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
                                Image.asset(
                                  ImagePath.icHeartOff,
                                  height: 28,
                                  width: 28,
                                ),
                                SizedBox(
                                  width: 12 * SizeConfig.widthMultiplier!,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    ImagePath.icCommentOff,
                                    height: 28,
                                    width: 28,
                                  ),
                                ),
                                SizedBox(
                                  width: 12 * SizeConfig.widthMultiplier!,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    ImagePath.icStarOff,
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    ImagePath.icShareOff,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
