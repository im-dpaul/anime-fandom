import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  static void showSnackbar(
      {required BuildContext context,
      required String message,
      backgroundColor}) {
    final screenWidth = SizeConfig.screenWidth!;
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      duration: const Duration(milliseconds: 3000),
      backgroundColor: backgroundColor,
      content: Text(
        message,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.f14W500White.copyWith(fontFamily: 'Manrope'),
        textAlign: TextAlign.center,
      ),
      width: screenWidth - 60,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
