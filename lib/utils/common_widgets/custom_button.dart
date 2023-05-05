import 'package:anime_fandom/config/size_config.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color color;
  final TextStyle textStyle;
  final VoidCallback onTap;
  final Widget? icon;
  final double borderRadius;
  final EdgeInsets padding;
  final LinearGradient? gradient;
  final double? width;
  final double? height;
  const CustomButton({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
    required this.textStyle,
    this.icon,
    this.height,
    this.width,
    this.borderRadius = 10,
    this.padding = const EdgeInsets.all(12),
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: gradient,
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (icon != null)
                  ? Row(
                      children: [
                        icon!,
                        SizedBox(width: 8 * SizeConfig.widthMultiplier!),
                      ],
                    )
                  : const SizedBox.shrink(),
              Text(
                title,
                style: textStyle.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
