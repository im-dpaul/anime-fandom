import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavBar extends ConsumerStatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  ConsumerState<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends ConsumerState<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: GNav(
          selectedIndex:
              ref.watch(homeController.select((value) => value.selectedIndex)),
          onTabChange: (index) {
            ref.read(homeController
                .select((value) => value.pageController.jumpToPage(index)));
            ref.read(homeController.notifier).onPageChanged(index);
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
          padding:
              const EdgeInsets.only(top: 12, bottom: 12, left: 14, right: 8),
          tabs: const [
            GButton(
              icon: Icons.message_outlined,
              text: "Chats",
            ),
            GButton(
              icon: Icons.search_outlined,
              text: "Search",
            ),
            GButton(
              icon: Icons.explore_outlined,
              text: "Explore",
            ),
            GButton(
              icon: Icons.notifications_active_outlined,
              text: "Notifications",
            ),
            GButton(
              icon: Icons.person_3_outlined,
              text: "Deb",
            ),
          ],
        ),
      ),
    );
  }
}
