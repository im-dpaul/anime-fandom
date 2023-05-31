import 'package:anime_fandom/features/explore/views/explore_screen.dart';
import 'package:anime_fandom/features/favourite/views/favourite_screen.dart';
import 'package:anime_fandom/features/new_post/views/create_post_screen.dart';
import 'package:anime_fandom/features/profile/views/profile_screen.dart';
import 'package:anime_fandom/features/search/views/search_screen.dart';
import 'package:anime_fandom/main.dart';
import 'package:anime_fandom/utils/common_widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          SearchScreen(),
          FavouriteScreen(),
          ExploreScreen(),
          CreatePostScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: ref.watch(
          homeController.select((value) => value.visibleBottomNavBar),
        ),
        child: const CustomBottomNavBar(),
      ),
    );
  }
}
