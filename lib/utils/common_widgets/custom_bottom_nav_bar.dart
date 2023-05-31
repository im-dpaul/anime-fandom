import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/features/dashboard/controllers/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          color: AppColors.bgColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: GNav(
              selectedIndex: homeScreenController.selectedIndex.value,
              // ref.watch(homeController.select((value) => value.selectedIndex)),
              onTabChange: (index) {
                homeScreenController.pageController.value.jumpToPage(index);
                homeScreenController.onPageChanged(index);
              },
              gap: 6,
              iconSize: 24,
              color: AppColors.black1,
              activeColor: AppColors.white,
              backgroundColor: AppColors.bgColor,
              tabBackgroundColor: AppColors.grey2,
              curve: Curves.easeInQuad,
              style: GnavStyle.google,
              duration: const Duration(milliseconds: 800),
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 14, right: 8),
              tabs: const [
                GButton(
                  icon: Icons.search_outlined,
                  text: "Search",
                ),
                GButton(
                  icon: Icons.star_border_outlined,
                  text: "Favourite",
                ),
                GButton(
                  icon: Icons.explore_outlined,
                  text: "Explore",
                ),
                GButton(
                  icon: Icons.add_box_outlined,
                  text: "Create Post",
                ),
                GButton(
                  icon: Icons.person_3_outlined,
                  text: "Deb",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
