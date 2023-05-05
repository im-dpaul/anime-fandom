import 'package:anime_fandom/features/explore/views/explore_screen.dart';
import 'package:anime_fandom/features/profile/views/profile_screen.dart';
import 'package:anime_fandom/features/settings/views/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  int _page = 2;

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: PageView(
        controller: pageController,
        physics: const BouncingScrollPhysics(),
        children: [
          SettingsScreen(),
          ExploreScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
