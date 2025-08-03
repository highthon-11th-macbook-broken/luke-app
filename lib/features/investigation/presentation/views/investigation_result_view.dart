import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/util/style/typography.dart';
import '../viewmodels/investigation_result_viewmodel.dart';

/// 조사 결과 페이지
class InvestigationResultView extends StatelessWidget {
  const InvestigationResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<InvestigationResultViewModel>();
    
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/sagunbg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // 어두운 오버레이
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          
          // 메인 컨텐츠 (상단 헤더 제거)
          Center(
            child: Transform.translate(
              offset: const Offset(0, -120), // 전체를 더 위로 이동
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 로딩 텍스트 (애니메이션 점들 포함)
                  Obx(() => _buildAnimatedText(viewModel)),
                  
                  const SizedBox(height: 30),
                  
                  // 로딩 인디케이터 (중간 위치)
                  const SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 4,
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  Text(
                    '전문 조사팀이 귀하의 요청을\n신속히 처리하고 있습니다.',
                    style: AppTypography.body1.copyWith(
                      color: Colors.white.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }

  /// 애니메이션이 적용된 텍스트
  Widget _buildAnimatedText(InvestigationResultViewModel viewModel) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '사건을 찾는중 ',
            style: AppTypography.heading2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: viewModel.animatedDots.value,
            style: AppTypography.heading2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}