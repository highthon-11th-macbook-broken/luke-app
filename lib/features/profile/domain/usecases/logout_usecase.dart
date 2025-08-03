import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// 사용자 로그아웃을 처리하는 유스케이스
class LogoutUseCase {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  /// 로그아웃 실행
  Future<void> execute() async {
    try {
      print('로그아웃 시작...');
      
      // SharedPreferences에서 사용자 정보 및 토큰 삭제
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_info');
      await prefs.remove('access_token');
      await prefs.remove('refresh_token');
      print('로컬 데이터 삭제 완료');
      
      // 구글 로그아웃
      await _googleSignIn.signOut();
      print('구글 로그아웃 완료');
      
      // 로그인 페이지로 이동
      Get.offAllNamed('/login');
      
      // 성공 메시지
      Get.snackbar(
        '로그아웃',
        '성공적으로 로그아웃되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('로그아웃 실패: $e');
      // 로그아웃 실패 시 에러 처리
      Get.snackbar(
        '오류',
        '로그아웃 중 문제가 발생했습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}