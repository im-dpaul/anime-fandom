import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final BuildContext parentContext;
  final VoidCallback? onTap;
  const CustomBackButton({super.key, required this.parentContext, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (onTap != null) {
          onTap!();
          return;
        }
        Navigator.pop(parentContext);
      },
      child: Image.asset(
        ImagePath.icBack,
        height: 25 * SizeConfig.heightMultiplier!,
      ),
    );
  }
}
