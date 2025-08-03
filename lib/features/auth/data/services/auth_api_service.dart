import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/auth_entities.dart';

class AuthApiService {
  static const String baseUrl = 'http://10.10.6.61:8080';
  
  // Google 로그인
  Future<AuthResponse> googleSignIn(String idToken) async {
    try {
      print('API 호출 시작: $baseUrl/auth/sign-in');
      print('요청 데이터: ${jsonEncode(GoogleSignInRequest(idToken: idToken).toJson())}');
      
      final response = await http.post(
        Uri.parse('$baseUrl/auth/sign-in'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(GoogleSignInRequest(idToken: idToken).toJson()),
      );

      print('응답 상태 코드: ${response.statusCode}');
      print('응답 바디: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('성공 응답 파싱: $responseData');
        return AuthResponse.fromJson(responseData);
      } else {
        print('에러 응답 파싱 시도...');
        final errorData = jsonDecode(response.body);
        print('에러 데이터: $errorData');
        final errorResponse = ErrorResponse.fromJson(errorData);
        throw Exception('서버 에러 (${errorResponse.status}): ${errorResponse.message}');
      }
    } catch (e) {
      print('API 호출 에러: $e');
      if (e is FormatException) {
        throw Exception('서버 응답 형식이 올바르지 않습니다: $e');
      }
      throw Exception('로그인 중 오류가 발생했습니다: $e');
    }
  }

  // 토큰 재발급
  Future<RefreshTokenResponse> refreshToken(String refreshToken) async {
    try {
      print('토큰 재발급 API 호출: $baseUrl/auth/refresh');
      
      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(RefreshTokenRequest(refreshToken: refreshToken).toJson()),
      );

      print('토큰 재발급 응답 상태 코드: ${response.statusCode}');
      print('토큰 재발급 응답 바디: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return RefreshTokenResponse.fromJson(responseData);
      } else {
        final errorData = jsonDecode(response.body);
        final errorResponse = ErrorResponse.fromJson(errorData);
        throw Exception('토큰 재발급 실패 (${errorResponse.status}): ${errorResponse.message}');
      }
    } catch (e) {
      print('토큰 재발급 API 에러: $e');
      throw Exception('토큰 재발급 중 오류가 발생했습니다: $e');
    }
  }
} 