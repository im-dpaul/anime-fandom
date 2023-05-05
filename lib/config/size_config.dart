import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeConfig {
  static double? screenWidth;
  static double? screenHeight;
  static double _blockSizeHorizontal = 0;
  static double _blockSizeVertical = 0;
  static double? textMultiplier;
  static double? imageSizeMultiplier;
  static double? heightMultiplier;
  static double? widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;
  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (screenWidth! < 450) {
        isMobilePortrait = true;
      }
    } else {
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }
    _blockSizeHorizontal = screenWidth! / 100;
    _blockSizeVertical = screenHeight! / 100;
    // textMultiplier = _blockSizeVertical / 6.4;
    // imageSizeMultiplier = _blockSizeHorizontal / 3.6;
    // heightMultiplier = _blockSizeVertical / 6.4;
    // widthMultiplier = _blockSizeHorizontal / 3.6;
    textMultiplier = 1.sp;
    imageSizeMultiplier = 1;
    heightMultiplier = 1.h;
    widthMultiplier = 1.w;
  }
}
