import 'package:flutter/material.dart';
import '../../util/style/colors.dart';
import '../../util/style/typography.dart';

/// 커스텀 드롭다운 위젯
class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String hint;
  final bool enabled;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hint = '선택해주세요',
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.borderLight,
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          onChanged: enabled ? onChanged : null,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              hint,
              style: AppTypography.body1.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          icon: const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.iconInactive,
            ),
          ),
          isExpanded: true,
          items: items,
          dropdownColor: AppColors.white,
          style: AppTypography.body1.copyWith(
            color: AppColors.textDark,
          ),
        ),
      ),
    );
  }
}