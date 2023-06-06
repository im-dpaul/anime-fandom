import 'package:anime_fandom/features/favourite/controllers/favourite_controller.dart';
import 'package:anime_fandom/features/favourite/views/empty_favourite_screen.dart';
import 'package:anime_fandom/features/favourite/views/single_favourite_widget.dart';
import 'package:anime_fandom/utils/common_widgets/custom_app_bar.dart';
import 'package:anime_fandom/utils/shimmers/favourite_screen_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final FavouriteController favouriteController =
      Get.put(FavouriteController());

  @override
  void initState() {
    super.initState();
    favouriteController.getAllFavourite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        parentContext: context,
        title: "My Favourites",
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 16.0),
        //     child: GestureDetector(
        //       onTap: () {},
        //       child: Image.asset(
        //         ImagePath.icMenu,
        //         height: 22,
        //         width: 22,
        //       ),
        //       // child: const CircleAvatar(
        //       //   backgroundColor: AppColors.date15,
        //       //   radius: 16,
        //       // ),
        //     ),
        //   ),
        // ],
      ),
      body: Obx(
        () {
          return SizedBox(
            child: favouriteController.isLoading.value
                ? const FavouriteScreenShimmer()
                : favouriteController.allFavouriteModel.value.data!.isEmpty
                    ? const EmptyFavouriteScreen()
                    : Padding(
                        padding:
                            const EdgeInsets.only(right: 8, left: 8, top: 10),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: favouriteController
                                    .allFavouriteModel.value.data!.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return SingleFavouriteWidget(
                                    index: index,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
          );
        },
      ),
    );
  }
}
