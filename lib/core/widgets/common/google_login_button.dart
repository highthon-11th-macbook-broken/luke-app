import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../util/style/colors.dart';
import '../../util/style/typography.dart';

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const GoogleLoginButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFEAE4E4),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(30),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Google 아이콘
                SvgPicture.asset(
                  'lib/assets/icons/google.svg',
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 10),
                // 텍스트
                Flexible(
                  child: Text(
                    'google로 로그인하기',
                    style: const TextStyle(
                      fontFamily: 'Freesentation',
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C2C2F),
                      height: 1.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 