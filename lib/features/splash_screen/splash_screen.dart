import 'dart:async';

import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/app_text_styles.dart';
import 'package:anime_fandom/core/hive_services.dart';
import 'package:anime_fandom/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var duration = const Duration(seconds: 3);
    Timer(
      duration,
      () => Navigator.pushNamedAndRemoveUntil(
        context,
        HiveServices.getToken() != null
            ? AppRoutes.homeScreen
            : AppRoutes.signinOtpScreen,
        (val) => false,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // SvgPicture.asset(
            //   ImagePath.icSplash,
            //   height: 128 * SizeConfig.heightMultiplier!,
            //   width: 128 * SizeConfig.widthMultiplier!,
            // ),
            Text(
              "Wellcome!!",
              style: AppTextStyles.f16W700White,
            ),
          ],
        ),
      ),
    );
  }
}
