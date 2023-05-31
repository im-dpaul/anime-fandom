import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        parentContext: context,
        title: "Create Post",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                ImagePath.icMenu,
                height: 22,
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
      body: const Center(
        child: Text("Create Post"),
      ),
      // bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
