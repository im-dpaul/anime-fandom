import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/features/dashboard/controllers/home_controller.dart';
import 'package:anime_fandom/features/explore/views/single_post_widget.dart';
import 'package:anime_fandom/routes/app_routes.dart';
import 'package:anime_fandom/utils/common_widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    homeController.addScrollListener();
    super.initState();
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
        body:
            // isLoading
            //     ? const ExploreScreenShimmer()
            //     :
            Padding(
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
