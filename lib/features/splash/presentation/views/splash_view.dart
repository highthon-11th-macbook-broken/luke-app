import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/util/style/colors.dart';
import '../../../../core/util/style/typography.dart';
import '../viewmodels/splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(SplashViewModel());
    
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.splashBackground,
          child: Stack(
            children: [
              // 텍스트 영역 (피그마 기준: x: 40, y: 100 + SafeArea 상단 여백)
              Positioned(
                left: 40,
                top: 100,
                child: Text(
                  '내 정보를\n안전하게\n보호하는',
                  style: AppTypography.splashTitle,
                  textAlign: TextAlign.left,
                ),
              ),
              
              // LUKE 로고 (텍스트 아래 50 여백)
              Positioned(
                left: 40,
                top: 100 + 128 + 50, // 텍스트 높이(128) + 여백(50)
                child: SvgPicture.asset(
                  'lib/assets/icons/logo.svg',
                  width: 123,
                  height: 42,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              
              // 탐정 아이콘 (피그마 기준: x: 118, y: 481)
              Positioned(
                left: 118,
                top: 481,
                child: Image.asset(
                  'lib/assets/images/detective_icon.png',
                  width: 237,
                  height: 263,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}