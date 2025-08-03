import 'package:flutter/material.dart';
import '../../util/style/colors.dart';
import '../../util/style/typography.dart';

/// 필터 버튼 컴포넌트
class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showArrow;
  final double? width;

  const FilterButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.showArrow = true,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderLight,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppTypography.body2.copyWith(
                color: isSelected ? AppColors.white : AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (showArrow) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: isSelected ? AppColors.white : AppColors.iconInactive,
              ),
            ],
          ],
        ),
      ),
    );
  }
}