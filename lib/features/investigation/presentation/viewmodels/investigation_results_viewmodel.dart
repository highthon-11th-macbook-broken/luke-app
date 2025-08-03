import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../domain/entities/investigation_result_detail_entity.dart';
import '../../../../core/util/style/typography.dart';

/// 조사 결과 목록 페이지의 상태를 관리하는 ViewModel
class InvestigationResultsViewModel extends GetxController {
  
  // 조사 결과 상세 데이터
  final Rx<InvestigationResultDetail?> resultDetail = Rx<InvestigationResultDetail?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    
    // Get.arguments에서 결과 데이터를 받아옴
    print('📋 결과 페이지 초기화 시작...');
    if (Get.arguments != null && Get.arguments is InvestigationResultDetail) {
      final receivedData = Get.arguments as InvestigationResultDetail;
      resultDetail.value = receivedData;
      
      print('✅ 결과 데이터 수신 완료:');
      print('  - 대상: ${receivedData.targetName} (${receivedData.targetEmail})');
      print('  - 전화번호: ${receivedData.targetPhoneNumber}');
      print('  - 탐지 결과 수: ${receivedData.detectionResults.length}');
      
      if (receivedData.detectionResults.isNotEmpty) {
        print('📊 개별 탐지 결과:');
        for (int i = 0; i < receivedData.detectionResults.length; i++) {
          final result = receivedData.detectionResults[i];
          print('  [$i] 위험도: ${result.riskPercentage}%, 설명: ${result.description}');
        }
      } else {
        print('⚠️ 탐지 결과가 비어있음!');
      }
    } else {
      print('❌ 결과 데이터가 없거나 타입이 맞지 않음');
      print('  - arguments: ${Get.arguments}');
      print('  - 타입: ${Get.arguments.runtimeType}');
      
      // 결과 데이터가 없으면 오류 처리
      Get.snackbar('오류', '탐지 결과 데이터가 없습니다.');
      Get.back();
    }
  }



  /// 자세히 보기 버튼 클릭
  void onDetailTap(int index) {
    if (resultDetail.value != null && 
        index < resultDetail.value!.detectionResults.length) {
      final result = resultDetail.value!.detectionResults[index];
      _showDetailPopup(result);
    }
  }
  
  /// 상세 정보 팝업 표시
  void _showDetailPopup(DetectionResult result) {
    Get.dialog(
      _DetailPopupDialog(result: result),
      barrierDismissible: true,
    );
  }

  /// 뒤로가기
  void onBackTap() {
    Get.back();
  }
}

/// 상세 정보 팝업 다이얼로그
class _DetailPopupDialog extends StatelessWidget {
  final DetectionResult result;
  
  const _DetailPopupDialog({required this.result});
  
  /// 탐지 설명에서 아이콘 결정
  IconData _getDetectionIcon(String description) {
    if (description.contains('LeakCheck.io')) {
      return Icons.security;
    } else if (description.contains('Pastebin')) {
      return Icons.content_paste;
    } else if (description.contains('OSINT')) {
      return Icons.search;
    } else if (description.contains('데이터베이스')) {
      return Icons.storage;
    } else if (description.contains('Google')) {
      return Icons.search;
    } else {
      return Icons.warning;
    }
  }

  /// 탐지 설명에서 소스명 추출
  String _getDetectionSource(String description) {
    if (description.contains('LeakCheck.io')) {
      return 'LeakCheck.io';
    } else if (description.contains('Pastebin')) {
      return 'Pastebin';
    } else if (description.contains('OSINT')) {
      return 'OSINT';
    } else if (description.contains('데이터베이스')) {
      return 'Database';
    } else if (description.contains('Google')) {
      return 'Google';
    } else {
      return '탐지';
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white.withOpacity(0.7),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: 350,
            height: 400,
            child: Stack(
              children: [
                // file.svg를 흰색으로 변경
                SvgPicture.asset(
                  'lib/assets/icons/file.svg',
                  width: 350,
                  height: 400,
                  fit: BoxFit.fill,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                // 내용
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                // 상단 X 버튼
                Container(
                  padding: const EdgeInsets.all(4),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 24,
                      height: 24,
                      child: const Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                
                // 탐지 대상
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      result.targetValue,
                      style: AppTypography.heading2.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 4),

                // 상세 설명
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      result.description,
                      style: AppTypography.body1.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 4),

                // 사이트 주소 링크 (출처 URL이 있을 때만 표시)
                if (result.imageUrl != null && result.imageUrl!.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          // URL 열기 처리 (url_launcher 패키지 필요)
                          print('출처 URL 클릭: ${result.imageUrl}');
                        },
                        child: Text(
                          '출처: ${result.imageUrl}',
                          style: AppTypography.body1.copyWith(
                            fontSize: 14,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
                
                const SizedBox(height: 6),

                // 구글 검색 결과 이미지
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A3A4A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      // 탐지 소스 표시
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 탐지 타입에 따른 아이콘
                            Icon(
                              _getDetectionIcon(result.description),
                              color: Colors.white,
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _getDetectionSource(result.description),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: 200,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // 위험도 표시
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '위험도 ${result.riskPercentage.toStringAsFixed(1)}%',
                            style: AppTypography.body1.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                        const SizedBox(height: 5),
                      ],
                    ),
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

