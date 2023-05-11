import 'package:anime_fandom/constants/app_colors.dart';
import 'package:flutter/material.dart';

Future<bool?> customDialogWidget(BuildContext context, Widget child) async {
  return showGeneralDialog<bool>(
    context: context,
    barrierLabel: "Dialog",
    barrierDismissible: true,
    barrierColor: AppColors.grey2.withOpacity(0.01),
    pageBuilder: (_, __, ___) {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: child),
            ],
          ),
        ),
      );
    },
  );
}
