import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomDecisionWidget extends StatelessWidget {
  final String? title;
  final String description;
  final String firstButtontitle;
  final String secondButtonTitle;
  final VoidCallback onFirstButtonTap;
  final VoidCallback onSecondButtonTap;
  const CustomDecisionWidget({
    super.key,
    this.title,
    required this.description,
    required this.firstButtontitle,
    required this.secondButtonTitle,
    required this.onFirstButtonTap,
    required this.onSecondButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 24, bottom: 24, top: 32),
              decoration: BoxDecoration(
                  color: AppColors.grey1,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        description,
                        style: AppTextStyles.f14W400White,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32 * SizeConfig.heightMultiplier!,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: onFirstButtonTap,
                        child: Text(
                          firstButtontitle,
                          style: AppTextStyles.f16W400Grey5,
                        ),
                      ),
                      SizedBox(
                        width: 32 * SizeConfig.widthMultiplier!,
                      ),
                      GestureDetector(
                          onTap: onSecondButtonTap,
                          child: Text(secondButtonTitle,
                              style: AppTextStyles.f16W400LightBlue))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
