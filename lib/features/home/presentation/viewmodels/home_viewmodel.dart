import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth/domain/entities/auth_entities.dart';

/// 홈 화면의 상태 관리를 담당하는 ViewModel
class HomeViewModel extends GetxController {
  // 현재 선택된 하단 네비게이션 인덱스
  final RxInt selectedNavIndex = 1.obs; // 홈이 기본 선택
  
  // 사용자 정보
  final Rx<UserInfo?> userInfo = Rx<UserInfo?>(null);

  @override
  void onInit() {
    super.onInit();
    loadUserInfo();
  }

  /// 사용자 정보 로드
  Future<void> loadUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userInfoJson = prefs.getString('user_info');
      
      if (userInfoJson != null) {
        final Map<String, dynamic> userInfoMap = json.decode(userInfoJson);
        userInfo.value = UserInfo.fromJson(userInfoMap);
        print('사용자 정보 로드 완료: ${userInfo.value?.name}');
      } else {
        print('저장된 사용자 정보가 없습니다.');
      }
    } catch (e) {
      print('사용자 정보 로드 실패: $e');
    }
  }

  /// 하단 네비게이션 아이템 선택
  void selectNavItem(int index) {
    selectedNavIndex.value = index;
  }

  /// 알림 아이콘 탭 처리
  void onNotificationTap() {
    // TODO: 알림 페이지로 이동 또는 알림 관련 로직 추가
    Get.snackbar('알림', '알림 기능은 준비 중입니다.');
  }

  /// 네비게이션 아이템 탭 처리
  void onNavItemTap(int index) {
    selectNavItem(index);
    
    switch (index) {
      case 0:
        // 사건박스 페이지로 이동
        Get.toNamed('/case-box');
        break;
      case 1:
        // 홈 탭 (현재 페이지)
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

  /// 미제 사건 보관함 탭 처리
  void onCaseArchiveTap() {
    // 사건 보관함 페이지로 이동
    Get.toNamed('/case-box');
  }
}