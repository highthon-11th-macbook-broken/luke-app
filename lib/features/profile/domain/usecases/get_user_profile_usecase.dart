import '../entities/user_entity.dart';

/// 사용자 프로필 정보를 가져오는 유스케이스
class GetUserProfileUseCase {
  
  /// 현재 사용자 프로필 정보 조회
  Future<UserEntity> execute() async {
    try {
      // TODO: 실제 API 호출 또는 로컬 저장소에서 사용자 정보 조회
      
      // 임시 데이터 (Figma 디자인의 데이터와 동일)
      await Future.delayed(const Duration(milliseconds: 300));
      
      return const UserEntity(
        id: 'user_001',
        name: '송유빈',
        email: 'D2308@e-mirim.hs.kr',
        profileImageUrl: null, // 실제 이미지 URL이 있다면 여기에
      );
    } catch (e) {
      throw Exception('사용자 정보를 불러오는데 실패했습니다: ${e.toString()}');
    }
  }
}