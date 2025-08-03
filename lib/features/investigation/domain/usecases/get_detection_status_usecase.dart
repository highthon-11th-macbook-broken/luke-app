import '../../data/services/detection_api_service.dart';

/// 탐지 상태 조회 Use Case
class GetDetectionStatusUseCase {
  final DetectionApiService _apiService;
  
  GetDetectionStatusUseCase(this._apiService);
  
  /// 탐지 요청 상태를 조회
  Future<DetectionRequestResponse?> call(int requestId) async {
    try {
      print('🔍 UseCase: 탐지 상태 조회 시작 (ID: $requestId)');
      final response = await _apiService.getDetectionRequest(requestId);
      print('✅ UseCase: API 서비스에서 응답 받음');
      return response;
    } catch (e) {
      print('❌ UseCase: 탐지 상태 조회 실패: $e');
      return null;
    }
  }
}