import 'package:get/get.dart';
import '../../domain/entities/case_entity.dart';

/// 사건박스 화면의 상태 관리를 담당하는 ViewModel
class CaseBoxViewModel extends GetxController {
  // 사건 리스트
  final RxList<CaseEntity> _allCases = <CaseEntity>[].obs;
  final RxList<CaseEntity> filteredCases = <CaseEntity>[].obs;
  
  // 필터 상태 (이미지와 맞춘 초기값)
  final RxInt selectedRiskFilter = 1.obs; // 위험도 필터 활성화
  final RxInt selectedDateFilter = 1.obs; // 날짜 필터 활성화
  final RxInt selectedTypeFilter = 0.obs; // 유형 필터 비활성화
  
  // 로딩 상태
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCases();
  }

  /// 사건 데이터 로드
  void loadCases() {
    isLoading.value = true;
    try {
      // 더미 데이터 로드 (실제로는 API 호출)
      _allCases.value = CaseEntity.getDummyData();
      applyFilters();
    } catch (e) {
      Get.snackbar('오류', '사건 데이터를 불러오는데 실패했습니다: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// 위험도 필터 변경
  void onRiskFilterTap() {
    selectedRiskFilter.value = selectedRiskFilter.value == 0 ? 1 : 0;
    applyFilters();
  }

  /// 날짜 필터 변경
  void onDateFilterTap() {
    selectedDateFilter.value = selectedDateFilter.value == 0 ? 1 : 0;
    applyFilters();
  }

  /// 유형 필터 변경
  void onTypeFilterTap() {
    selectedTypeFilter.value = selectedTypeFilter.value == 0 ? 1 : 0;
    applyFilters();
  }

  /// 필터 적용
  void applyFilters() {
    List<CaseEntity> filtered = List.from(_allCases);
    
    // 위험도 필터 적용
    if (selectedRiskFilter.value == 1) {
      filtered.sort((a, b) => b.riskLevel.compareTo(a.riskLevel));
    }
    
    // 날짜 필터 적용
    if (selectedDateFilter.value == 1) {
      filtered.sort((a, b) => b.date.compareTo(a.date));
    }
    
    // 유형 필터는 현재 단순히 선택 상태만 변경
    // 실제로는 특정 유형으로 필터링 로직을 추가할 수 있음
    
    filteredCases.value = filtered;
  }

  /// 사건 조치하기 버튼 탭
  void onCaseActionTap(CaseEntity caseEntity) {
    Get.snackbar(
      '조치 요청', 
      '${caseEntity.name}님의 사건에 대한 조치를 요청했습니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
    
    // TODO: 실제 조치 요청 API 호출
  }

  /// 사건 자세히 보기 버튼 탭
  void onCaseDetailTap(CaseEntity caseEntity) {
    Get.snackbar(
      '상세 정보', 
      '${caseEntity.name}님의 사건 상세 정보를 확인합니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
    
    // TODO: 상세 페이지로 이동
  }

  /// 알림 아이콘 탭
  void onNotificationTap() {
    Get.snackbar('알림', '알림 기능은 준비 중입니다.');
  }

  /// 네비게이션 아이템 탭 처리
  void onNavItemTap(int index) {
    switch (index) {
      case 0:
        // 사건박스 탭 (현재 페이지)
        break;
      case 1:
        // 홈 페이지로 이동
        Get.toNamed('/home');
        break;
      case 2:
        // 조사/정보수집 페이지로 이동
        Get.toNamed('/investigation');
        break;
      case 3:
        // 프로필 페이지로 이동
        Get.toNamed('/profile');
        break;
    }
  }
}