import 'package:anime_fandom/constants/app_text_styles.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:flutter/material.dart';

class EmptyFavouriteScreen extends StatelessWidget {
  const EmptyFavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImagePath.icFallingStar,
            height: 95,
            width: 95,
          ),
          const SizedBox(height: 25),
          const Center(
            child: Text(
              "Empty Favourites list.",
              style: AppTextStyles.f14W400Gray5,
            ),
          )
        ],
      ),
    );
  }
}
