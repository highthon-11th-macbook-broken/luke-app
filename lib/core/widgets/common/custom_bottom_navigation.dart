import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../util/style/colors.dart';

/// 앱 전체에서 사용되는 커스텀 하단 네비게이션 바
class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTap;

  const CustomBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65 + MediaQuery.of(context).padding.bottom,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 박스 아이콘
          GestureDetector(
            onTap: () => onItemTap(0),
            child: _buildNavSvgItem(
              svgPath: 'lib/assets/icons/Box.svg',
              color: selectedIndex == 0 ? AppColors.iconActive : AppColors.iconInactive,
              isActive: selectedIndex == 0,
            ),
          ),
          
          const SizedBox(width: 45),
          
          // 홈 아이콘
          GestureDetector(
            onTap: () => onItemTap(1),
            child: _buildNavSvgItem(
              svgPath: 'lib/assets/icons/home2.svg',
              color: selectedIndex == 1 ? AppColors.iconActive : AppColors.iconInactive,
              isActive: selectedIndex == 1,
            ),
          ),
          
          const SizedBox(width: 45),
          
          // 검색 아이콘
          GestureDetector(
            onTap: () => onItemTap(2),
            child: _buildNavSvgItem(
              svgPath: 'lib/assets/icons/Search.svg',
              color: selectedIndex == 2 ? AppColors.iconActive : AppColors.iconInactive,
              isActive: selectedIndex == 2,
            ),
          ),
          
          const SizedBox(width: 45),
          
          // 프로필 아이콘
          GestureDetector(
            onTap: () => onItemTap(3),
            child: _buildNavSvgItem(
              svgPath: 'lib/assets/icons/profile2.svg',
              color: selectedIndex == 3 ? AppColors.iconActive : AppColors.iconInactive,
              isActive: selectedIndex == 3,
            ),
          ),
        ],
        ),
      ),
    );
  }
  

  Widget _buildNavSvgItem({
    required String svgPath,
    required Color color,
    bool isActive = false,
  }) {
    return SizedBox(
      width: 40,
      height: 44,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
                      SvgPicture.asset(
              svgPath,
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),

        ],
      ),
    );
  }
}