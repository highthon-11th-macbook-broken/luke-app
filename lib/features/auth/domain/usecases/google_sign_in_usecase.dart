import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/services/auth_api_service.dart';
import '../entities/auth_entities.dart';

class GoogleSignInUseCase {
  final AuthApiService _authApiService;
  late final GoogleSignIn _googleSignIn;

  GoogleSignInUseCase(this._authApiService) {
    _googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
      clientId: '717262627248-u9e5cokdnajdjctji7di4f8hbkea5i9j.apps.googleusercontent.com',
    );
  }

  Future<AuthResponse> execute() async {
    try {
      print('Google 로그인 시작...');
      print('GoogleSignIn 객체 생성 완료');
      
      // 기존 로그인 상태 확인
      print('기존 로그인 상태 확인...');
      final GoogleSignInAccount? currentUser = _googleSignIn.currentUser;
      if (currentUser != null) {
        print('기존 로그인된 사용자 발견: ${currentUser.email}');
        await _googleSignIn.signOut();
        print('기존 로그인 해제 완료');
      }
      
      // Google 로그인 실행
      print('Google 로그인 팝업 표시...');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        print('Google 로그인이 취소됨');
        throw Exception('Google 로그인이 취소되었습니다.');
      }

      print('Google 사용자 정보 획득: ${googleUser.email}');
      print('사용자 ID: ${googleUser.id}');
      print('사용자 이름: ${googleUser.displayName}');

      // ID 토큰 가져오기
      print('Google 인증 정보 요청 중...');
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        print('ID 토큰이 null임');
        throw Exception('ID 토큰을 가져올 수 없습니다.');
      }

      print('ID 토큰 획득 완료: ${idToken.substring(0, 20)}...');
      print('Access Token: ${googleAuth.accessToken?.substring(0, 20) ?? "null"}...');

      // 서버에 로그인 요청
      print('백엔드 API 호출 시작...');
      final authResponse = await _authApiService.googleSignIn(idToken);
      
      print('백엔드 로그인 성공');
      
      // 사용자 정보 저장
      await _saveUserInfo(googleUser);
      
      // 토큰 저장
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', authResponse.accessToken);
      await prefs.setString('refresh_token', authResponse.refreshToken);
      print('토큰 저장 완료');
      
      return authResponse;
    } catch (e) {
      print('GoogleSignInUseCase 에러: $e');
      throw Exception('Google 로그인 중 오류가 발생했습니다: $e');
    }
  }

  Future<void> _saveUserInfo(GoogleSignInAccount googleUser) async {
    try {
      final userInfo = UserInfo.fromGoogleUser(googleUser);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_info', json.encode(userInfo.toJson()));
      print('사용자 정보 저장 완료: ${userInfo.name}, ${userInfo.email}');
    } catch (e) {
      print('사용자 정보 저장 실패: $e');
    }
  }
} 