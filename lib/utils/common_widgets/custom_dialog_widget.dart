import 'dart:developer';

import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_core/theme.dart';

Future<bool?> customDialogWidget(BuildContext context, Widget child) async {
  return showGeneralDialog<bool>(
    context: context,
    barrierLabel: "Prompt",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.01),
    pageBuilder: (_, __, ___) {
      return SizedBox(
        // width: 320 * SizeConfig.widthMultiplier!,
        // height: 450,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: child,
            ),
          ],
        ),
      );
    },
  );
}
