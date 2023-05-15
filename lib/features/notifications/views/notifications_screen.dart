import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/utils/common_widgets/custom_app_bar.dart';
import 'package:anime_fandom/utils/common_widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        parentContext: context,
        title: "Notifications",
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
        child: Text("Notifiactions"),
      ),
      // bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
