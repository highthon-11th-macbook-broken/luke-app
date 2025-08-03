import 'dart:async';
import 'package:get/get.dart';
import '../../domain/entities/investigation_result_entity.dart';
import '../../domain/entities/investigation_result_detail_entity.dart';
import '../../domain/usecases/get_detection_status_usecase.dart';
import '../../data/services/detection_api_service.dart';

/// 조사 결과 페이지의 상태를 관리하는 ViewModel
class InvestigationResultViewModel extends GetxController {
  final GetDetectionStatusUseCase _getDetectionStatusUseCase;
  
  // 조사 결과 데이터
  final Rx<InvestigationResult?> investigationResult = Rx<InvestigationResult?>(null);
  final RxBool isLoading = true.obs;
  
  // 애니메이션 점들
  final RxString animatedDots = ''.obs;
  Timer? _dotsTimer;
  Timer? _pollingTimer;

  InvestigationResultViewModel(this._getDetectionStatusUseCase);

  @override
  void onInit() {
    super.onInit();
    
    // Get.arguments에서 결과 데이터를 받아옴
    if (Get.arguments != null && Get.arguments is InvestigationResult) {
      investigationResult.value = Get.arguments as InvestigationResult;
    }
    
    // 점 애니메이션 시작
    _startDotsAnimation();
    
    // 실제 탐지 상태 폴링 시작
    _startPolling();
  }

  @override
  void onClose() {
    _dotsTimer?.cancel();
    _pollingTimer?.cancel();
    super.onClose();
  }

  /// 점들이 순차적으로 나타나는 애니메이션 시작
  void _startDotsAnimation() {
    int dotCount = 0;
    
    _dotsTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      switch (dotCount % 4) {
        case 0:
          animatedDots.value = '';
          break;
        case 1:
          animatedDots.value = '.';
          break;
        case 2:
          animatedDots.value = '. .';
          break;
        case 3:
          animatedDots.value = '. . .';
          break;
      }
      dotCount++;
    });
  }

  /// 실제 탐지 상태 폴링 시작
  void _startPolling() {
    final result = investigationResult.value;
    if (result?.requestId == null) {
      // 요청 ID가 없으면 오류 처리
      Get.snackbar('오류', '탐지 요청 ID가 없습니다. 다시 시도해주세요.');
      Get.back();
      return;
    }

    // 3초마다 상태 확인
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await _checkDetectionStatus(result!.requestId!);
    });
    
    // 첫 번째 상태 확인
    _checkDetectionStatus(result!.requestId!);
  }

  /// 탐지 상태 확인
  Future<void> _checkDetectionStatus(int requestId) async {
    try {
      print('📡 탐지 상태 확인 요청: $requestId');
      final response = await _getDetectionStatusUseCase(requestId);
      
      if (response != null) {
        print('✅ API 응답 받음:');
        print('  - 상태: ${response.status}');
        print('  - 대상 이메일: ${response.targetEmail}');
        print('  - 대상 전화번호: ${response.targetPhone}');  
        print('  - 대상 이름: ${response.targetName}');
        print('  - 결과 개수: ${response.results.length}');
        
        if (response.results.isNotEmpty) {
          print('📊 탐지 결과 상세:');
          for (int i = 0; i < response.results.length; i++) {
            final result = response.results[i];
            print('  [$i] 타입: ${result.detectionType}, 대상: ${result.targetValue}, 유출: ${result.isLeaked}, 위험도: ${result.riskScore}, 증거: ${result.evidence}');
          }
        } else {
          print('⚠️ 탐지 결과가 비어있음!');
        }
        
        if (response.status == 'completed') {
          // 완료된 경우 결과 페이지로 이동
          _pollingTimer?.cancel();
          print('🚀 결과 페이지로 이동 시작...');
          _moveToResultsWithApiData(response);
        } else if (response.status == 'failed') {
          // 실패한 경우 에러 처리
          _pollingTimer?.cancel();
          Get.snackbar('오류', '탐지 중 문제가 발생했습니다.');
          Get.back();
        }
        // 'pending' 또는 'processing' 상태면 계속 폴링
      } else {
        print('❌ API 응답이 null');
      }
    } catch (e) {
      print('상태 확인 중 오류: $e');
      // API 서버 오류시 계속 재시도 (더미 데이터 사용 금지)
      if (_pollingTimer != null && _pollingTimer!.tick > 10) {
        // 10번 시도 후 오류 메시지 표시
        _pollingTimer?.cancel();
        Get.snackbar('오류', '서버 연결에 실패했습니다. 나중에 다시 시도해주세요.');
        Get.back();
      }
    }
  }

  /// API 데이터로 결과 페이지 이동
  void _moveToResultsWithApiData(DetectionRequestResponse response) {
    print('🔄 결과 데이터 변환 시작...');
    
    final results = response.results.map((apiResult) => DetectionResult(
      targetValue: apiResult.targetValue, // 실제 탐지된 값 사용
      riskPercentage: (apiResult.riskScore * 100).toDouble(), // 0-1 스케일을 0-100으로 변환
      description: apiResult.evidence ?? '${apiResult.detectionType}에서 탐지됨',
      imageUrl: apiResult.sourceUrl, // sourceUrl을 imageUrl로 매핑
    )).toList();

    print('✅ 변환된 결과 개수: ${results.length}');
    for (int i = 0; i < results.length; i++) {
      final result = results[i];
      print('  [$i] 탐지대상: ${result.targetValue}, 위험도: ${result.riskPercentage.toStringAsFixed(1)}%, 설명: ${result.description}');
    }

    final resultDetail = InvestigationResultDetail(
      targetEmail: response.targetEmail,
      targetPhoneNumber: response.targetPhone,
      targetName: response.targetName,
      detectionResults: results,
    );

    print('📄 최종 결과 상세:');
    print('  - 대상: ${resultDetail.targetName} (${resultDetail.targetEmail})');
    print('  - 전화번호: ${resultDetail.targetPhoneNumber}');
    print('  - 탐지 결과 수: ${resultDetail.detectionResults.length}');

    print('🚀 결과 페이지로 이동...');
    Get.offAndToNamed('/investigation-results', arguments: resultDetail);
  }



  /// 결과 데이터 설정
  void setResult(InvestigationResult result) {
    investigationResult.value = result;
  }

  /// 홈으로 돌아가기
  void goToHome() {
    Get.offAllNamed('/home');
  }
}