import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInRequest {
  final String idToken;

  GoogleSignInRequest({required this.idToken});

  Map<String, dynamic> toJson() {
    return {
      'idToken': idToken,
    };
  }
}

class AuthResponse {
  final String accessToken;
  final String refreshToken;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}

class UserInfo {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;

  UserInfo({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  factory UserInfo.fromGoogleUser(GoogleSignInAccount googleUser) {
    return UserInfo(
      id: googleUser.id,
      name: googleUser.displayName ?? '',
      email: googleUser.email,
      photoUrl: googleUser.photoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'],
    );
  }
}

class RefreshTokenRequest {
  final String refreshToken;

  RefreshTokenRequest({required this.refreshToken});

  Map<String, dynamic> toJson() {
    return {
      'refreshToken': refreshToken,
    };
  }
}

class RefreshTokenResponse {
  final String accessToken;

  RefreshTokenResponse({required this.accessToken});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      accessToken: json['accessToken'] ?? '',
    );
  }
}

class ErrorResponse {
  final int status;
  final String message;

  ErrorResponse({
    required this.status,
    required this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      status: json['status'] is int ? json['status'] : int.tryParse(json['status'].toString()) ?? 0,
      message: json['message'] ?? '',
    );
  }
} 