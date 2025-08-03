/// 조사 정보 수집을 위한 엔티티 클래스
class InvestigationInfo {
  final String category;
  final String name;
  final String email;
  final String phoneNumber;
  final List<String> additionalInfo;

  const InvestigationInfo({
    required this.category,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.additionalInfo,
  });

  InvestigationInfo copyWith({
    String? category,
    String? name,
    String? email,
    String? phoneNumber,
    List<String>? additionalInfo,
  }) {
    return InvestigationInfo(
      category: category ?? this.category,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }
}

/// 카테고리 옵션을 위한 엔티티
class CategoryOption {
  final String id;
  final String displayName;

  const CategoryOption({
    required this.id,
    required this.displayName,
  });
}