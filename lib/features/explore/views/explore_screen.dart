import 'dart:developer';

import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/features/explore/views/single_post_widget.dart';
import 'package:anime_fandom/main.dart';
import 'package:anime_fandom/utils/common_widgets/custom_app_bar.dart';
import 'package:anime_fandom/utils/common_widgets/custom_bottom_nav_bar.dart';
import 'package:anime_fandom/utils/common_widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  addListener() {
    ref
        .read(exploreController.select((value) => value.scrollController))
        .addListener(
      () {
        if (ref
                .watch(
                    exploreController.select((value) => value.scrollController))
                .position
                .userScrollDirection ==
            ScrollDirection.reverse) {
          // ref.read(exploreController.notifier).setBottomNavBarVisibility(false);
          log("false ok");
        }
        if (ref
                .watch(
                    exploreController.select((value) => value.scrollController))
                .position
                .userScrollDirection ==
            ScrollDirection.forward) {
          log("true ok");
          // ref.read(exploreController.notifier).setBottomNavBarVisibility(true);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    addListener();

    return Scaffold(
      // appBar: CustomAppBar(
      //   parentContext: context,
      //   title: "Anime Fandom",
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 16.0),
      //       child: GestureDetector(
      //         onTap: () {},
      //         child: Image.asset(
      //           ImagePath.icMenu,
      //           // height: 22,
      //           width: 22,
      //         ),
      //         // child: const CircleAvatar(
      //         //   backgroundColor: AppColors.date15,
      //         //   radius: 16,
      //         // ),
      //       ),
      //     ),
      //   ],
      // ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        controller: ref
            .watch(exploreController.select((value) => value.scrollController)),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            CustomSliverAppBar(
              parentContext: context,
              title: "Anime Fandom",
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      ImagePath.icMenu,
                      // height: 22,
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
            // SliverAppBar(
            //   title: const Text("Anime Fandom"),
            //   backgroundColor: AppColors.bgColor,
            //   actions: [
            //     Padding(
            //       padding: const EdgeInsets.only(right: 16.0),
            //       child: GestureDetector(
            //         onTap: () {},
            //         child: Image.asset(
            //           ImagePath.icMenu,
            //           // height: 22,
            //           width: 22,
            //         ),
            //         // child: const CircleAvatar(
            //         //   backgroundColor: AppColors.date15,
            //         //   radius: 16,
            //         // ),
            //       ),
            //     ),
            //   ],
            //   floating: true,
            //   snap: true,
            // ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.only(right: 8, left: 8, top: 0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: SinglePostWidget(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
