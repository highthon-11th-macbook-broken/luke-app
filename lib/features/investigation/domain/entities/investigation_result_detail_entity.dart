/// 조사 결과 상세 엔티티
class InvestigationResultDetail {
  final String targetEmail;
  final String targetPhoneNumber;
  final String targetName;
  final List<DetectionResult> detectionResults;

  const InvestigationResultDetail({
    required this.targetEmail,
    required this.targetPhoneNumber,
    required this.targetName,
    required this.detectionResults,
  });
}

/// 탐지 결과 개별 항목
class DetectionResult {
  final String targetValue; // 탐지된 실제 값 (이메일, 전화번호, 이름 등)
  final double riskPercentage;
  final String description;
  final String? imageUrl;

  const DetectionResult({
    required this.targetValue,
    required this.riskPercentage,
    required this.description,
    this.imageUrl,
  });
}