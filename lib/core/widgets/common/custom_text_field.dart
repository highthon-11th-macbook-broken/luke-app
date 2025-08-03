import 'package:flutter/material.dart';
import '../../util/style/colors.dart';
import '../../util/style/typography.dart';

/// 커스텀 텍스트 입력 필드 위젯
class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final bool enabled;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: AppTypography.body1.copyWith(
              color: AppColors.textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.borderLight,
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: controller,
            initialValue: controller == null ? initialValue : null,
            onChanged: onChanged,
            keyboardType: keyboardType,
            enabled: enabled,
            maxLines: maxLines,
            style: AppTypography.body1.copyWith(
              color: AppColors.textDark,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTypography.body1.copyWith(
                color: AppColors.textSecondary,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}