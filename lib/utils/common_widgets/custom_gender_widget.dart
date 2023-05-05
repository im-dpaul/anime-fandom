import 'package:anime_fandom/config/size_config.dart';
import 'package:flutter/material.dart';

class CustomGenderWidget extends StatefulWidget {
  final String icon;
  final String title;
  final Color color;
  final TextStyle textStyle;
  final VoidCallback onTap;
  const CustomGenderWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap,
      required this.color,
      required this.textStyle});

  @override
  State<CustomGenderWidget> createState() => _CustomGenderWidgetState();
}

class _CustomGenderWidgetState extends State<CustomGenderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 21, horizontal: 24),
                height: 90 * SizeConfig.heightMultiplier!,
                width: 90 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Image.asset(
                  widget.icon,
                  height: 33 * SizeConfig.heightMultiplier!,
                  width: 33 * SizeConfig.widthMultiplier!,
                ),
              ),
              SizedBox(
                height: 16 * SizeConfig.heightMultiplier!,
              ),
              Text(
                widget.title,
                style: widget.textStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
