import 'dart:convert';
import 'package:http/http.dart' as http;

/// 탐지 API 서비스
class DetectionApiService {
  // API 베이스 URL (실제 서버 주소로 변경 필요)
  static const String baseUrl = 'http://localhost:8000';
  
  /// 탐지 요청 생성
  /// POST /detection/detect
  Future<DetectionRequestResponse> createDetectionRequest({
    required String email,
    required String phone,
    required String name,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/detection/detect'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'phone': phone,
          'name': name,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DetectionRequestResponse.fromJson(data);
      } else {
        throw Exception('탐지 요청 생성 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('탐지 요청 생성 실패: $e');
      throw Exception('서버 연결에 실패했습니다: $e');
    }
  }

  /// 탐지 요청 조회
  /// GET /detection/requests/{request_id}
  Future<DetectionRequestResponse> getDetectionRequest(int requestId) async {
    try {
      final url = '$baseUrl/detection/requests/$requestId';
      print('🌐 API 호출: GET $url');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('📡 HTTP 응답 상태: ${response.statusCode}');
      print('📄 응답 본문: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ JSON 파싱 성공');
        print('📊 파싱된 데이터: $data');
        
        final result = DetectionRequestResponse.fromJson(data);
        print('🎯 모델 변환 완료: ${result.status}, 결과 수: ${result.results.length}');
        
        return result;
      } else {
        print('❌ HTTP 오류: ${response.statusCode} - ${response.body}');
        throw Exception('탐지 요청 조회 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('💥 API 호출 중 예외 발생: $e');
      if (e is FormatException) {
        print('🔧 JSON 파싱 오류: ${e.message}');
      }
      throw Exception('서버 연결에 실패했습니다: $e');
    }
  }

  /// 탐지 요청 목록 조회
  /// GET /detection/requests
  Future<List<DetectionRequestResponse>> getDetectionRequests({
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/detection/requests?skip=$skip&limit=$limit'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => DetectionRequestResponse.fromJson(item)).toList();
      } else {
        throw Exception('탐지 요청 목록 조회 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('탐지 요청 목록 조회 실패: $e');
      throw Exception('서버 연결에 실패했습니다: $e');
    }
  }

  /// 탐지 요약 정보 조회
  /// GET /detection/summary
  Future<DetectionSummary> getDetectionSummary() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/detection/summary'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DetectionSummary.fromJson(data);
      } else {
        throw Exception('탐지 요약 조회 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('탐지 요약 조회 실패: $e');
      throw Exception('서버 연결에 실패했습니다: $e');
    }
  }
}

/// 탐지 요청 응답 모델
class DetectionRequestResponse {
  final int id;
  final int userId;
  final String targetEmail;
  final String targetPhone;
  final String targetName;
  final String status; // "pending", "processing", "completed", "failed"
  final DateTime createdAt;
  final DateTime? completedAt;
  final List<DetectionResultModel> results;

  DetectionRequestResponse({
    required this.id,
    required this.userId,
    required this.targetEmail,
    required this.targetPhone,
    required this.targetName,
    required this.status,
    required this.createdAt,
    this.completedAt,
    required this.results,
  });

  factory DetectionRequestResponse.fromJson(Map<String, dynamic> json) {
    return DetectionRequestResponse(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      targetEmail: json['target_email'] ?? '',
      targetPhone: json['target_phone'] ?? '',
      targetName: json['target_name'] ?? '',
      status: json['status'] ?? 'pending',
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      completedAt: json['completed_at'] != null 
          ? DateTime.parse(json['completed_at']) 
          : null,
      results: (json['results'] as List<dynamic>?)
          ?.map((item) => DetectionResultModel.fromJson(item))
          .toList() ?? [],
    );
  }
}

/// 탐지 결과 모델
class DetectionResultModel {
  final int id;
  final int requestId;
  final String detectionType; // "free_leakcheck_io", "static_db", "osint_crawl", etc.
  final String targetValue;
  final bool isLeaked;
  final double riskScore; // 0.0 - 1.0 (서버는 0-1 스케일)
  final String? evidence;
  final String? sourceUrl;
  final DateTime detectedAt;

  DetectionResultModel({
    required this.id,
    required this.requestId,
    required this.detectionType,
    required this.targetValue,
    required this.isLeaked,
    required this.riskScore,
    this.evidence,
    this.sourceUrl,
    required this.detectedAt,
  });

  factory DetectionResultModel.fromJson(Map<String, dynamic> json) {
    return DetectionResultModel(
      id: json['id'] ?? 0,
      requestId: json['request_id'] ?? 0,
      detectionType: json['detection_type'] ?? '',
      targetValue: json['target_value'] ?? '',
      isLeaked: json['is_leaked'] ?? false,
      riskScore: (json['risk_score'] ?? 0.0).toDouble(),
      evidence: json['evidence'],
      sourceUrl: json['source_url'],
      detectedAt: json['detected_at'] != null 
          ? DateTime.parse(json['detected_at'])
          : DateTime.now(),
    );
  }
}

/// 탐지 요약 모델
class DetectionSummary {
  final int totalRequests;
  final int completedRequests;
  final int leakedCount;
  final int highRiskCount;
  final int unsolvedCases;

  DetectionSummary({
    required this.totalRequests,
    required this.completedRequests,
    required this.leakedCount,
    required this.highRiskCount,
    required this.unsolvedCases,
  });

  factory DetectionSummary.fromJson(Map<String, dynamic> json) {
    return DetectionSummary(
      totalRequests: json['total_requests'] ?? 0,
      completedRequests: json['completed_requests'] ?? 0,
      leakedCount: json['leaked_count'] ?? 0,
      highRiskCount: json['high_risk_count'] ?? 0,
      unsolvedCases: json['unsolved_cases'] ?? 0,
    );
  }
}