import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/util/style/colors.dart';
import '../../../../core/util/style/typography.dart';
import '../../../../core/widgets/common/custom_bottom_navigation.dart';
import '../viewmodels/investigation_results_viewmodel.dart';

/// 조사 결과 목록 페이지
class InvestigationResultsView extends StatelessWidget {
  const InvestigationResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<InvestigationResultsViewModel>();
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        final detail = viewModel.resultDetail.value;
        if (detail == null) {
          return const Center(child: CircularProgressIndicator());
        }
        
        return Column(
          children: [
            // 상단 Safe Area
            SizedBox(height: MediaQuery.of(context).padding.top),
            
            // 상단 영역 (로고 + 알림) - 다른 페이지와 동일
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                    onTap: () {
                      // 알림 클릭 처리
                    },
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
            ),
            
            // 스크롤 가능한 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    
                    // 탐지 대상 섹션
                    _buildTargetSection(detail),
                    
                    const SizedBox(height: 40),
                    
                    // 탐지 결과 섹션
                    _buildResultsSection(detail, viewModel),
                    
                    const SizedBox(height: 100), // 하단 네비게이션 여백
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: 2,
        onItemTap: (index) {
          // 네비게이션 처리는 각 페이지의 viewModel에서 처리
        },
      ),
    );
  }



  /// 탐지 대상 섹션
  Widget _buildTargetSection(detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '탐지 대상',
          style: AppTypography.heading1.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2C2C2F),
            fontFamily: 'Freesentation',
          ),
        ),
        
        const SizedBox(height: 20),
        
        Text(
          '이메일 : ${detail.targetEmail}\n전화번호 : ${detail.targetPhoneNumber}\n이름 : ${detail.targetName}',
          style: AppTypography.body1.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF2C2C2F),
            fontFamily: 'Freesentation-4Regular',
            height: 1.17,
          ),
        ),
      ],
    );
  }

  /// 탐지 결과 섹션
  Widget _buildResultsSection(detail, InvestigationResultsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '탐지 결과',
          style: AppTypography.heading1.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2C2C2F),
            fontFamily: 'Freesentation',
          ),
        ),
        
        const SizedBox(height: 20),
        
        // 결과 카드들을 2x2 그리드로 배치
        _buildResultGrid(detail.detectionResults, viewModel),
      ],
    );
  }

  /// 결과 카드 그리드
  Widget _buildResultGrid(List<dynamic> results, InvestigationResultsViewModel viewModel) {
    if (results.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.security,
                size: 64,
                color: AppColors.primary.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                '탐지된 유출 정보가 없습니다',
                style: AppTypography.heading3.copyWith(
                  color: AppColors.primary.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '안전한 개인정보 관리가 확인되었습니다',
                style: AppTypography.body2.copyWith(
                  color: AppColors.primary.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    return Column(
      children: [
        // 결과 개수 표시
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '총 ${results.length}개의 탐지 결과',
              style: AppTypography.body2.copyWith(
                color: AppColors.primary.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '위험도 순',
              style: AppTypography.body2.copyWith(
                color: AppColors.primary.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // 2개씩 가로 배치하는 그리드
        ...List.generate((results.length / 2).ceil(), (rowIndex) {
          final startIndex = rowIndex * 2;
          final endIndex = (startIndex + 2).clamp(0, results.length);
          final rowResults = results.sublist(startIndex, endIndex);
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                // 첫 번째 카드
                Expanded(
                  child: _buildResultCard(rowResults[0], startIndex, viewModel),
                ),
                
                const SizedBox(width: 10),
                
                // 두 번째 카드 (마지막 행에서 홀수 개일 때는 빈 공간)
                Expanded(
                  child: rowResults.length > 1 
                      ? _buildResultCard(rowResults[1], startIndex + 1, viewModel)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  /// 개별 결과 카드
  Widget _buildResultCard(dynamic result, int index, InvestigationResultsViewModel viewModel) {
    // 위험도에 따른 색상과 레벨 결정
    final riskColor = _getRiskColor(result.riskPercentage);
    final riskLevel = _getRiskLevel(result.riskPercentage);
    
    return Container(
      height: 210,
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
      child: Column(
        children: [
          // 위험도 표시 영역 (상단) - 스크린샷 대신
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: riskColor.withOpacity(0.15),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Stack(
              children: [
                // 배경 그라데이션 효과
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        riskColor.withOpacity(0.2),
                        riskColor.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
                
                // 위험도 정보 중앙 배치
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 위험도 아이콘
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: riskColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: riskColor.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          _getRiskIcon(result.riskPercentage),
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // 위험도 레벨 텍스트
                      Text(
                        riskLevel,
                        style: AppTypography.heading3.copyWith(
                          color: riskColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      
                      const SizedBox(height: 2),
                      
                      // 위험도 퍼센트
                      Text(
                        '${result.riskPercentage.toStringAsFixed(1)}%',
                        style: AppTypography.body2.copyWith(
                          color: riskColor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // 정보 영역 (하단)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 탐지 대상
                  Text(
                    result.targetValue,
                    style: AppTypography.body1.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // 설명
                  Text(
                    result.description,
                    style: AppTypography.body2.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                      height: 1.17,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const Spacer(),
                  
                  // 하단 정보 (위험도, 자세히 보기)
                  Row(
                    children: [
                      Text(
                        '위험도 ${result.riskPercentage.toStringAsFixed(1)}%',
                        style: AppTypography.body2.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: AppColors.primary,
                        ),
                      ),
                      
                      const SizedBox(width: 8),
                      
                      // 화살표 아이콘
                      Icon(
                        Icons.keyboard_arrow_up,
                        size: 10,
                        color: AppColors.primary,
                      ),
                      
                      const Spacer(),
                      
                      // 자세히 보기 버튼
                      GestureDetector(
                        onTap: () => viewModel.onDetailTap(index),
                        child: Text(
                          '자세히 보기',
                          style: AppTypography.body2.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 4),
                      
                      Icon(
                        Icons.keyboard_arrow_up,
                        size: 10,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 위험도에 따른 색상 반환
  Color _getRiskColor(double riskPercentage) {
    if (riskPercentage >= 80) {
      return Colors.red; // 높음 - 빨간색
    } else if (riskPercentage >= 50) {
      return Colors.orange; // 중간 - 주황색
    } else if (riskPercentage >= 20) {
      return Colors.yellow.shade700; // 낮음 - 노란색
    } else {
      return Colors.green; // 안전 - 초록색
    }
  }

  /// 위험도에 따른 레벨 텍스트 반환
  String _getRiskLevel(double riskPercentage) {
    if (riskPercentage >= 80) {
      return '매우 높음';
    } else if (riskPercentage >= 50) {
      return '높음';
    } else if (riskPercentage >= 20) {
      return '보통';
    } else {
      return '낮음';
    }
  }

  /// 위험도에 따른 아이콘 반환
  IconData _getRiskIcon(double riskPercentage) {
    if (riskPercentage >= 80) {
      return Icons.warning; // 매우 높음 - 경고 아이콘
    } else if (riskPercentage >= 50) {
      return Icons.error_outline; // 높음 - 에러 아이콘
    } else if (riskPercentage >= 20) {
      return Icons.info_outline; // 보통 - 정보 아이콘
    } else {
      return Icons.check_circle_outline; // 낮음 - 체크 아이콘
    }
  }
}