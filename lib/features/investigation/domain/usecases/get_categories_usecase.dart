import '../entities/investigation_entity.dart';

/// 카테고리 목록을 가져오는 UseCase
class GetCategoriesUseCase {
  
  /// 사용 가능한 카테고리 목록을 반환합니다
  Future<List<CategoryOption>> call() async {
    // TODO: 실제 API에서 카테고리를 가져오는 로직 구현
    await Future.delayed(const Duration(milliseconds: 500));
    
    return const [
      CategoryOption(id: 'default', displayName: '카테고리'),
      CategoryOption(id: 'personal', displayName: '개인정보'),
      CategoryOption(id: 'business', displayName: '사업정보'), 
      CategoryOption(id: 'academic', displayName: '학업정보'),
      CategoryOption(id: 'other', displayName: '기타'),
    ];
  }
}