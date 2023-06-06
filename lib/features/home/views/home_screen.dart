import 'package:anime_fandom/features/explore/controllers/explore_controller.dart';
import 'package:anime_fandom/features/home/controllers/home_controller.dart';
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
  final HomeController homeController = Get.put(HomeController());
  final ExploreController exploreController = Get.put(ExploreController());

  @override
  void initState() {
    super.initState();
    exploreController.getAllPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return PageView(
            controller: homeController.pageController.value,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (value) {
              homeController.onPageChanged(value);
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
            visible: homeController.visibleBottomNavBar.value,
            child: const CustomBottomNavBar(),
          );
        },
      ),
    );
  }
}
