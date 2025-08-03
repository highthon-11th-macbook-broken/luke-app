import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel extends GetxController {
  final RxBool isLoading = false.obs;
  final RxInt currentStep = 0.obs;
  
  @override
  void onInit() {
    super.onInit();
    _initializeSplash();
  }
  
  void _initializeSplash() async {
    isLoading.value = true;
    
    // 기존 토큰 초기화 (새로운 로그인 플로우를 위해)
    await _clearExistingTokens();
    
    // 스플래시 화면이 표시되는 시간 (3초)
    await Future.delayed(const Duration(seconds: 3));
    
    isLoading.value = false;
    
    // 항상 로그인 화면으로 이동 (토큰 초기화 후)
    Get.offAllNamed('/login');
  }
  
  /// 기존 토큰 초기화
  Future<void> _clearExistingTokens() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // 모든 인증 관련 데이터 삭제
      await prefs.remove('access_token');
      await prefs.remove('refresh_token');
      await prefs.remove('user_info');
      
      print('✅ 기존 토큰 초기화 완료');
      print('🔄 새로운 구글 OAuth 로그인 플로우 시작');
    } catch (e) {
      print('❌ 토큰 초기화 실패: $e');
    }
  }
}