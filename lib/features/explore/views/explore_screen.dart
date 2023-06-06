import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/features/explore/controllers/explore_controller.dart';
import 'package:anime_fandom/features/home/controllers/home_controller.dart';
import 'package:anime_fandom/features/explore/views/single_post_widget.dart';
import 'package:anime_fandom/routes/app_routes.dart';
import 'package:anime_fandom/utils/common_widgets/custom_sliver_app_bar.dart';
import 'package:anime_fandom/utils/shimmers/explore_screen_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final HomeController homeController = Get.put(HomeController());
  final ExploreController exploreController = Get.put(ExploreController());
  @override
  void initState() {
    super.initState();
    homeController.addScrollListener();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        // exploreController.getAllPost();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        controller: homeController.scrollController.value,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            CustomSliverAppBar(
              parentContext: context,
              title: "Anime Fandom",
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.settingsScreen,
                      );
                    },
                    child: Image.asset(
                      ImagePath.icMenu,
                      width: 22,
                    ),
                  ),
                ),
              ],
            ),
          ];
        },
        body: Obx(
          () {
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () async {
                await exploreController.getAllPost();
              },
              child: SizedBox(
                child: exploreController.isLoading.value
                    // &&
                    //         (exploreController.allPostModel == null)
                    ? const ExploreScreenShimmer()
                    : Padding(
                        padding:
                            const EdgeInsets.only(right: 8, left: 8, top: 0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: exploreController
                                    .allPostModel.value.posts!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: SinglePostWidget(
                                      index: index,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            );
          },
        ),
      ),
      // bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
