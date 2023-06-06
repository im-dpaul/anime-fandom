// ignore_for_file: use_build_context_synchronously

import 'package:anime_fandom/constants/app_text_styles.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/core/hive_services.dart';
import 'package:anime_fandom/routes/app_routes.dart';
import 'package:anime_fandom/utils/common_widgets/custom_app_bar.dart';
import 'package:anime_fandom/utils/common_widgets/custom_decision_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        parentContext: context,
        title: "Menu",
        isBack: true,
        leadingIconWidth: 28,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) => CustomDecisionWidget(
                    description: "Are you sure you want to log out?",
                    firstButtontitle: "Cancel",
                    secondButtonTitle: "Log Out",
                    onFirstButtonTap: () {
                      Navigator.pop(context);
                    },
                    onSecondButtonTap: () async {
                      FirebaseAuth.instance.signOut();
                      await HiveServices.clearHive();
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.signinOtpScreen, (route) => false);
                    },
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset(
                    ImagePath.icLogout,
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Log out",
                    style: AppTextStyles.f16W400Red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
