import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/features/chat/views/chat_screen.dart';
import 'package:anime_fandom/features/explore/views/explore_screen.dart';
import 'package:anime_fandom/features/notifications/views/notifications_screen.dart';
import 'package:anime_fandom/features/profile/views/profile_screen.dart';
import 'package:anime_fandom/features/search/views/search_screen.dart';
import 'package:anime_fandom/features/settings/views/settings_screen.dart';
import 'package:anime_fandom/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller:
            ref.watch(homeController.select((value) => value.pageController)),
        physics: const BouncingScrollPhysics(),
        onPageChanged: (value) {
          ref.read(homeController.notifier).onPageChanged(value);
        },
        children: const [
          ChatScreen(),
          SearchScreen(),
          ExploreScreen(),
          NotificationScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColors.bgColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: GNav(
            selectedIndex: ref
                .watch(homeController.select((value) => value.selectedIndex)),
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
                icon: Icons.settings_outlined,
                text: "Settings",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
