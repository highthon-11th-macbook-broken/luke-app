import 'package:flutter/material.dart';
import 'colors.dart';

/// 앱에서 사용되는 모든 텍스트 스타일을 정의하는 클래스
class AppTypography {
  // Splash Screen Typography
  static const TextStyle splashTitle = TextStyle(
    fontFamily: 'Freesentation',
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.0,
    color: AppColors.textPrimary,
  );
  
  // General Typography
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Freesentation',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Freesentation',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontFamily: 'Freesentation',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle body1 = TextStyle(
    fontFamily: 'Freesentation',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle body2 = TextStyle(
    fontFamily: 'Freesentation',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
  
    // Profile Typography (exact Figma specs)
  static const TextStyle profileWelcome = TextStyle(
    fontFamily: 'Freesentation',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.169,
    color: AppColors.profileTextWelcome,
  );

  static const TextStyle profileName = TextStyle(
    fontFamily: 'Freesentation',
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.169,
    color: AppColors.profileTextPrimary,
  );

  static const TextStyle profileEmail = TextStyle(
    fontFamily: 'Freesentation',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.169,
    color: AppColors.profileTextSecondary,
  );

  static const TextStyle profileSectionTitle = TextStyle(
    fontFamily: 'Freesentation',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.169,
    color: AppColors.profileTextPrimary,
  );

  static const TextStyle profileMenuItem = TextStyle(
    fontFamily: 'Freesentation',
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.169,
    color: AppColors.profileTextPrimary,
  );

  static const TextStyle profileButton = TextStyle(
    fontFamily: 'Freesentation',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.169,
    color: AppColors.white,
  );

  static const TextStyle profileButtonSecondary = TextStyle(
    fontFamily: 'Freesentation',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.169,
    color: AppColors.profileButtonSecondary,
  );
}