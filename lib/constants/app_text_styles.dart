import 'package:alarmapp/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  static const TextStyle locationTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
  );

  static const TextStyle locationAddress = TextStyle(
    fontSize: 16,
    color: AppColors.secondaryText,
    height: 1.4,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static const TextStyle sectionHeading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  static const TextStyle alarmTime = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryText,
  );

  static const TextStyle alarmDate = TextStyle(
    fontSize: 14,
    color: AppColors.secondaryText,
  );
}