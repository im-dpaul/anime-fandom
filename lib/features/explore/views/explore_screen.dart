import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/features/explore/views/single_post_widget.dart';
import 'package:anime_fandom/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
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
    );
  }
}
