import 'package:anime_fandom/constants/constant_data.dart';
import 'package:flutter/material.dart';

class PostMethods {
  static postTime({required BuildContext context, required DateTime utcTime}) {
    final localTime = utcTime.toLocal();
    final now = DateTime.now();
    final dayDiff = now.difference(localTime).inDays;
    String dayDifference;
    if (dayDiff == 0) {
      dayDifference = TimeOfDay.fromDateTime(localTime).format(context);
    } else if (dayDiff == 1) {
      dayDifference = '1d';
    } else if (dayDiff == 2) {
      dayDifference = '2d';
    } else if (dayDiff == 3) {
      dayDifference = '3d';
    } else if (dayDiff == 4) {
      dayDifference = '4d';
    } else if (dayDiff == 5) {
      dayDifference = '5d';
    } else if (dayDiff == 6) {
      dayDifference = '6d';
    } else if (dayDiff >= 7 && dayDiff <= 13) {
      dayDifference = '1w';
    } else if (dayDiff >= 14 && dayDiff <= 20) {
      dayDifference = '2w';
    } else if (dayDiff >= 21 && dayDiff <= 27) {
      dayDifference = '3w';
    } else if (dayDiff >= 28 && dayDiff <= 364) {
      String day;
      String month;
      if (localTime.day < 10) {
        day = "0${localTime.day}";
      } else {
        day = localTime.day.toString();
      }

      month = ConstantData.monthName[localTime.month - 1];

      dayDifference = "$day $month";
    } else if (dayDiff >= 365 && dayDiff <= 730) {
      dayDifference = '1y';
    } else {
      String day;
      String month;
      if (localTime.day < 10) {
        day = "0${localTime.day}";
      } else {
        day = localTime.day.toString();
      }
      month = ConstantData.monthName[localTime.month - 1];
      dayDifference = "$day $month ${localTime.year}";
    }

    return dayDifference;
  }
}
