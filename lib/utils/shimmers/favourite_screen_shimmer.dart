import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FavouriteScreenShimmer extends StatelessWidget {
  const FavouriteScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, top: 10),
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.0 * SizeConfig.heightMultiplier!),
        child: Shimmer.fromColors(
          baseColor: AppColors.grey3,
          highlightColor: AppColors.grey5Opacity25,
          direction: ShimmerDirection.ltr,
          loop: 0,
          period: const Duration(milliseconds: 2000),
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 82,
                        width: 96,
                        decoration: BoxDecoration(
                          color: AppColors.grey3,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 5, bottom: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth,
                                height: 16,
                                color: AppColors.grey3,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                width: 180,
                                height: 16,
                                color: AppColors.grey3,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 60,
                                height: 12,
                                color: AppColors.grey3,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Container(
                                width: 40,
                                height: 12,
                                color: AppColors.grey3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          ImagePath.icMore,
                          width: 20,
                          height: 24,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
