import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/util/style/colors.dart';
import '../../../../core/util/style/typography.dart';
import '../../../../core/widgets/common/custom_bottom_navigation.dart';
import '../viewmodels/home_viewmodel.dart';

class HomeView extends GetView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // 메인 콘텐츠 영역 (스크롤 가능)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 배경 이미지 영역
                  _buildBackgroundSection(context),
                  
                  // 메인 컨텐츠 영역
                  _buildMainContentSection(),
                ],
              ),
            ),
          ),
          
          // 하단 네비게이션 바 (SafeArea 적용)
          Obx(() => CustomBottomNavigation(
            selectedIndex: controller.selectedNavIndex.value,
            onItemTap: controller.onNavItemTap,
          )),
        ],
      ),
    );
  }

  Widget _buildBackgroundSection(BuildContext context) {
    return Container(
      height:320 + MediaQuery.of(context).padding.top, // 상태바 높이 포함 (420->350으로 줄임)
      width: double.infinity,
      child: Stack(
        children: [
          // 배경 이미지 전체 영역
          Container(
            width: double.infinity,
            height: double.infinity,
            child: ClipRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/homebg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // 블루 오버레이
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF6494DB).withOpacity(0.61), // 정확한 색상과 투명도
            ),
          ),
          
          // 그라데이션 오버레이 (하단)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200, // 높이 증가
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF999999).withOpacity(0), // 0%
                    const Color(0xFFD9D9D9).withOpacity(0.631), // 63.1%
                    const Color(0xFFEFEFEF).withOpacity(0.8441), // 84.41%
                    const Color(0xFFFFFFFF), // 100%
                  ],
                  stops: const [0, 0.631, 0.8441, 1.0],
                ),
              ),
            ),
          ),
          
          // 상단바
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: _buildTopBar(),
          ),
          
          // 사용자 정보 카드
          Positioned(
            left: 20,
            top: MediaQuery.of(context).padding.top + 66 + 147, // 상태바 + 상단바 + 100px 여백 (147->100으로 줄임)
            right: 20,
            child: _buildUserInfoCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0), // 사건박스와 동일한 패딩
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LUKE 로고
          SvgPicture.asset(
            'lib/assets/icons/logo_blue.svg',
            width: 123,
            height: 40,
          ),
          // 알림 아이콘
          GestureDetector(
            onTap: controller.onNotificationTap,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: SvgPicture.asset(
                'lib/assets/icons/alarm.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(AppColors.logoBlue, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoCard() {
    return Obx(() {
      final user = controller.userInfo.value;
      return Container(
        height: 82,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // 프로필 이미지
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: user?.photoUrl != null 
                        ? NetworkImage(user!.photoUrl!) 
                        : const AssetImage('lib/assets/images/detective_icon.png') as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // 사용자 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user != null ? '환영합니다! ${user.name}님' : '환영합니다!',
                      style: AppTypography.heading3.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.email ?? '로그인이 필요합니다',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.iconInactive,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildMainContentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 1), // 환영합니다 카드 바로 아래에 배치
          
          // AI 스토리 요약 & 최근 유출 요약 카드들
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  title: '최근 유출 요약',
                  content: '대통령의 선거에 관한 사항은 법률로 정한다. 저작자·발명가·과학기술자와 예술가의 권리는 법률로써 보호한다.',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSummaryCard(
                  title: 'AI 스토리 요약',
                  content: '대통령의 선거에 관한 사항은 법률로 정한다. 저작자·발명가·과학기술자와 예술가의 권리는 법률로써 보호한다.',
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 30), // AI 스토리 요약과 미제 사건 보관함 30px 여백
          
          // 미제 사건 보관함 카드
          _buildCaseArchiveCard(),
          
          const SizedBox(height: 30), // 하단 여백
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String content,
  }) {
    return Container(
      height: 150, // 높이 증가
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Text(
              title,
              style: AppTypography.heading3.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            // 내용
            Expanded(
              child: Text(
                content,
                style: AppTypography.body2.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  height: 1.4,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaseArchiveCard() {
    return GestureDetector(
      onTap: controller.onCaseArchiveTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              // 배경 이미지 (블러 처리)
              Container(
                width: double.infinity,
                height: double.infinity,
                child: ClipRect(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/assets/images/mijaebg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              // 다크 오버레이
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF15376C).withOpacity(0.6),
                ),
              ),
              
              // 텍스트 내용
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '미제 사건 보관함',
                      style: AppTypography.heading3.copyWith(
                        color: AppColors.background,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        '대통령의 선거에 관한 사항은 법률로 정한다. 저작자·발명가·과학기술자와 예술가의 권리는 법률로써 보호한다.',
                        style: AppTypography.body2.copyWith(
                          color: const Color(0xFFD1D1D7),
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 