import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth/domain/entities/auth_entities.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

/// 프로필 페이지의 상태 관리를 담당하는 ViewModel
class ProfileViewModel extends GetxController {
  // Dependencies
  final GetUserProfileUseCase _getUserProfileUseCase;
  final LogoutUseCase _logoutUseCase;
  
  ProfileViewModel(
    this._getUserProfileUseCase,
    this._logoutUseCase,
  );
  
  // Reactive variables
  final _userInfo = Rx<UserInfo?>(null);
  final _isLoading = false.obs;
  final _isLogoutLoading = false.obs;
  
  // Getters
  UserInfo? get userInfo => _userInfo.value;
  bool get isLoading => _isLoading.value;
  bool get isLogoutLoading => _isLogoutLoading.value;
  
  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }
  
  /// 구글 로그인 사용자 정보 로드
  Future<void> loadUserProfile() async {
    try {
      _isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final userInfoJson = prefs.getString('user_info');
      
      if (userInfoJson != null) {
        final Map<String, dynamic> userInfoMap = json.decode(userInfoJson);
        _userInfo.value = UserInfo.fromJson(userInfoMap);
        print('프로필 정보 로드 완료: ${_userInfo.value?.name}');
      } else {
        print('저장된 사용자 정보가 없습니다.');
        // 로그인 페이지로 리다이렉트
        Get.offAllNamed('/login');
      }
    } catch (e) {
      Get.snackbar(
        '오류',
        '프로필 정보를 불러오는데 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }
  
  /// 개인정보 수정 페이지로 이동
  void navigateToEditProfile() {
    // TODO: 개인정보 수정 페이지 구현 후 활성화
    Get.snackbar(
      '알림',
      '개인정보 수정 기능은 준비 중입니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  /// 로그아웃 확인 요청 (View에서 호출)
  Future<void> requestLogout() async {
    try {
      _isLogoutLoading.value = true;
      await _logoutUseCase.execute();
    } catch (e) {
      Get.snackbar(
        '오류',
        '로그아웃 중 문제가 발생했습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLogoutLoading.value = false;
    }
  }
  
  /// 로그아웃 로딩 상태 리셋
  void resetLogoutLoading() {
    _isLogoutLoading.value = false;
  }
  
  /// 기본 정보 내역 페이지로 이동
  void navigateToBasicInfo() {
    Get.snackbar(
      '알림',
      '기본 정보 내역 기능은 준비 중입니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  /// 사건 내역 페이지로 이동
  void navigateToCaseHistory() {
    Get.snackbar(
      '알림',
      '사건 내역 기능은 준비 중입니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  /// 사건 접수 내역 페이지로 이동
  void navigateToCaseSubmissionHistory() {
    Get.snackbar(
      '알림',
      '사건 접수 내역 기능은 준비 중입니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  /// 개인정보 처리 방침 페이지로 이동
  void navigateToPrivacyPolicy() {
    Get.snackbar(
      '알림',
      '개인정보 처리 방침 기능은 준비 중입니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  /// 서비스 이용 약관 페이지로 이동
  void navigateToTermsOfService() {
    Get.snackbar(
      '알림',
      '서비스 이용 약관 기능은 준비 중입니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  /// 고객센터 페이지로 이동
  void navigateToCustomerService() {
    Get.snackbar(
      '알림',
      '고객센터 기능은 준비 중입니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  /// 설정 페이지로 이동
  void navigateToSettings() {
    Get.snackbar(
      '알림',
      '설정 기능은 준비 중입니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}