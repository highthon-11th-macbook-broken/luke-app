import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/util/style/colors.dart';
import '../../../../core/util/style/typography.dart';
import '../../../../core/widgets/common/custom_bottom_navigation.dart';
import '../viewmodels/profile_viewmodel.dart';

/// 프로필 페이지 뷰 (배경 이미지 기반)
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              // 배경 이미지
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/images/프로필_01.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // 상단바 오버레이
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _buildTopBar(context),
              ),
              
              // 구글 프로필 이미지 오버레이 (원본 이미지의 프로필 사진 위치에)
              Positioned(
                top: 141, // 이미지에서 프로필 사진 위치
                left: 20,
                child: _buildProfileImageOverlay(controller),
              ),
              
              // 구글 로그인 정보 오버레이 (원본 이미지의 해당 위치에)
              Positioned(
                top: 150, // 이미지에서 프로필 정보가 있는 위치 조정
                left: 90,
                right: 20,
                child: _buildUserInfoOverlay(controller),
              ),
              
              // 하단 네비게이션 오버레이
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CustomBottomNavigation(
                  selectedIndex: 3, // 프로필 탭
                  onItemTap: (index) {
                    switch (index) {
                      case 0:
                        Get.toNamed('/case-box');
                        break;
                      case 1:
                        Get.toNamed('/home');
                        break;
                      case 2:
                        // 조사/정보수집 페이지로 이동
                        Get.toNamed('/investigation');
                        break;
                      case 3:
                        // 현재 페이지 (프로필)
                        break;
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 상단바 위젯 (오버레이)
  Widget _buildTopBar(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          // LUKE 로고
          SvgPicture.asset(
            'lib/assets/icons/luke.svg',
            width: 123,
            height: 40,
            colorFilter: const ColorFilter.mode(
              AppColors.profileTextWelcome,
              BlendMode.srcIn,
            ),
          ),
          
          const Spacer(),
          
          // 알림 아이콘
          SvgPicture.asset(
            'lib/assets/icons/alarm.svg',
            width: 32,
            height: 32,
            colorFilter: const ColorFilter.mode(
              AppColors.profileTextWelcome,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }

  /// 프로필 이미지 오버레이 (구글 프로필 사진)
  Widget _buildProfileImageOverlay(ProfileViewModel controller) {
    return Obx(() {
      final userInfo = controller.userInfo;
      return Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.borderLight,
        ),
        child: ClipOval(
          child: userInfo?.photoUrl != null
              ? Image.network(
                  userInfo!.photoUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.borderLight,
                      child: const Icon(
                        Icons.person,
                        size: 30,
                        color: AppColors.profileTextSecondary,
                      ),
                    );
                  },
                )
              : Container(
                  color: AppColors.borderLight,
                  child: const Icon(
                    Icons.person,
                    size: 30,
                    color: AppColors.profileTextSecondary,
                  ),
                ),
        ),
      );
    });
  }

  /// 사용자 정보 오버레이 (구글 로그인 정보)
  Widget _buildUserInfoOverlay(ProfileViewModel controller) {
    return Obx(() {
      final userInfo = controller.userInfo;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 환영 인사와 이름 (구글 displayName 사용)
          Row(
            children: [
              Text(
                '환영합니다! ',
                style: AppTypography.profileWelcome,
              ),
              Text(
                '${userInfo?.name ?? '사용자'}님',
                style: AppTypography.profileName,
              ),
            ],
          ),
          
          const SizedBox(height: 5),
          
          // 이메일 (구글 계정 이메일)
          Text(
            userInfo?.email ?? '',
            style: AppTypography.profileEmail,
          ),
        ],
      );
    });
  }




}