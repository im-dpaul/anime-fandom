import 'package:anime_fandom/features/dashboard/controllers/home_screen_controller.dart';
import 'package:anime_fandom/features/explore/views/explore_screen.dart';
import 'package:anime_fandom/features/favourite/views/favourite_screen.dart';
import 'package:anime_fandom/features/new_post/views/create_post_screen.dart';
import 'package:anime_fandom/features/profile/views/profile_screen.dart';
import 'package:anime_fandom/features/search/views/search_screen.dart';
import 'package:anime_fandom/utils/common_widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return PageView(
            controller: homeScreenController.pageController.value,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (value) {
              homeScreenController.onPageChanged(value);
            },
            children: const [
              SearchScreen(),
              FavouriteScreen(),
              ExploreScreen(),
              CreatePostScreen(),
              ProfileScreen(),
            ],
          );
        },
      ),
      bottomNavigationBar: Obx(
        () {
          return Visibility(
            visible: homeScreenController.visibleBottomNavBar.value,
            child: const CustomBottomNavBar(),
          );
        },
      ),
    );
  }
}
