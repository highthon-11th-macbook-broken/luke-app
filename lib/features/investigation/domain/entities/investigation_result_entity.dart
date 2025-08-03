/// 조사 결과를 나타내는 엔티티
class InvestigationResult {
  final String resultId;
  final String category;
  final String name;
  final String email;
  final String phoneNumber;
  final List<String> additionalInfo;
  final DateTime submittedAt;
  final String status;
  final int? requestId; // API 요청 ID 추가

  const InvestigationResult({
    required this.resultId,
    required this.category,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.additionalInfo,
    required this.submittedAt,
    required this.status,
    this.requestId, // API 요청 ID
  });

  InvestigationResult copyWith({
    String? resultId,
    String? category,
    String? name,
    String? email,
    String? phoneNumber,
    List<String>? additionalInfo,
    DateTime? submittedAt,
    String? status,
    int? requestId,
  }) {
    return InvestigationResult(
      resultId: resultId ?? this.resultId,
      category: category ?? this.category,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      submittedAt: submittedAt ?? this.submittedAt,
      status: status ?? this.status,
      requestId: requestId ?? this.requestId,
    );
  }
}