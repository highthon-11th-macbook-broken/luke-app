import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/usecases/google_sign_in_usecase.dart';
import '../../data/services/auth_api_service.dart';

class LoginViewModel extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  
  late final GoogleSignInUseCase _googleSignInUseCase;
  
  @override
  void onInit() {
    super.onInit();
    _googleSignInUseCase = GoogleSignInUseCase(AuthApiService());
  }
  
  void googleLogin() async {
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      print('Google 로그인 시작...');
      
      // Google 로그인 실행
      final authResponse = await _googleSignInUseCase.execute();
      
      print('Google 로그인 성공, 토큰 저장 중...');
      
      // 토큰 저장
      await _saveTokens(authResponse.accessToken, authResponse.refreshToken);
      
      print('토큰 저장 완료, 홈 화면으로 이동...');
      
      // 로그인 성공 시 다음 화면으로 이동
      _navigateToNextScreen();
    } catch (e) {
      print('로그인 에러 상세: $e');
      errorMessage.value = e.toString();
      
      // 에러가 발생해도 홈 화면으로 이동 (테스트용)
      print('에러 발생했지만 테스트를 위해 홈 화면으로 이동...');
      _navigateToNextScreen();
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);
      await prefs.setString('refresh_token', refreshToken);
      print('토큰 저장 완료');
    } catch (e) {
      print('토큰 저장 에러: $e');
    }
  }
  
  void _navigateToNextScreen() {
    // 로그인 성공 후 홈 화면으로 이동
    Get.offAllNamed('/home');
  }
} 