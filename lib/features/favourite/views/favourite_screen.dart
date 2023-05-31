import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/utils/common_widgets/custom_app_bar.dart';
import 'package:anime_fandom/utils/shimmers/explore_screen_shimmer.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        parentContext: context,
        title: "Favourites",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                ImagePath.icMenu,
                height: 22,
                width: 22,
              ),
              // child: const CircleAvatar(
              //   backgroundColor: AppColors.date15,
              //   radius: 16,
              // ),
            ),
          ),
        ],
      ),
      body: const ExploreScreenShimmer(),
      // bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
