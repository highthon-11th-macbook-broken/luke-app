import '../entities/investigation_entity.dart';
import '../../data/services/detection_api_service.dart';

/// 조사 정보를 제출하는 UseCase
class SubmitInvestigationUseCase {
  final DetectionApiService _apiService;
  
  SubmitInvestigationUseCase(this._apiService);
  
  /// 조사 정보를 제출하고 요청 ID를 반환합니다
  Future<int?> call(InvestigationInfo investigationInfo) async {
    try {
      // 검증 로직
      if (investigationInfo.email.isEmpty || investigationInfo.phoneNumber.isEmpty) {
        return null;
      }
      
      // 실제 API 호출
      final response = await _apiService.createDetectionRequest(
        email: investigationInfo.email,
        phone: investigationInfo.phoneNumber,
        name: investigationInfo.name,
      );
      
      return response.id;
    } catch (e) {
      print('탐지 요청 생성 실패: $e');
      rethrow; // 예외를 다시 던져서 상위에서 처리하도록 함
    }
  }
}