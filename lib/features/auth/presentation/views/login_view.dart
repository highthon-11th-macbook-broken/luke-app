import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/util/style/colors.dart';
import '../../../../core/widgets/common/google_login_button.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(LoginViewModel());
    
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.white,
        child: Stack(
          children: [
            // 배경 이미지
            Positioned(
              left: 78,
              top: 142,
              child: Image.asset(
                'lib/assets/images/login_background.png',
                width: 237,
                height: 263,
              ),
            ),
            
            // 상단바 (시스템 상태바)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 46,
                color: AppColors.white,
                child: SafeArea(
                  child: Container(),
                ),
              ),
            ),
            
            // 하단바 (홈 인디케이터)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 34,
                color: AppColors.white,
                child: Center(
                  child: Container(
                    width: 139.36,
                    height: 5.31,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2F),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
              ),
            ),
            
            // LUKE 로고 (중앙)
            Positioned(
              left: 133,
              top: 425,
              child: SvgPicture.asset(
                'lib/assets/icons/logo.svg',
                width: 123,
                height: 42,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF2C2C2F),
                  BlendMode.srcIn,
                ),
              ),
            ),
            
            // Google 로그인 버튼 (하단)
            Positioned(
              left: 20,
              bottom: 197, // 844 - 60 - 587
              child: Obx(() => GoogleLoginButton(
                onPressed: viewModel.googleLogin,
                isLoading: viewModel.isLoading.value,
              )),
            ),
          ],
        ),
      ),
    );
  }
} 