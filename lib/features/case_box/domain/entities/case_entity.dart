/// 사건 정보를 담는 엔터티 클래스
class CaseEntity {
  final String id;
  final String name;
  final String phoneNumber;
  final String location;
  final String date;
  final double riskLevel;
  final String type;
  final bool isProcessed;

  const CaseEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.location,
    required this.date,
    required this.riskLevel,
    required this.type,
    this.isProcessed = false,
  });

  /// 테스트용 더미 데이터 생성 (Figma 디자인에 맞춘 데이터)
  static List<CaseEntity> getDummyData() {
    return [
      const CaseEntity(
        id: '1',
        name: '042-518-2153',
        phoneNumber: '042-518-2153',
        location: '',
        date: '2025/8/2',
        riskLevel: 70.0,
        type: '실종',
        isProcessed: false,
      ),
      const CaseEntity(
        id: '2',
        name: '박하은',
        phoneNumber: '2025/8/2',
        location: '',
        date: '2025/8/2',
        riskLevel: 70.0,
        type: '사고',
        isProcessed: false,
      ),
      const CaseEntity(
        id: '3',
        name: '제주도 제주시 진군남....',
        phoneNumber: '2025/8/2',
        location: '제주도 제주시 진군남....',
        date: '2025/8/2',
        riskLevel: 70.0,
        type: '실종',
        isProcessed: true,
      ),
      const CaseEntity(
        id: '4',
        name: '박하은',
        phoneNumber: '042-518-2153',
        location: '',
        date: '2025/8/2',
        riskLevel: 70.0,
        type: '사고',
        isProcessed: false,
      ),
      const CaseEntity(
        id: '5',
        name: '042-518-2153',
        phoneNumber: '042-518-2153',
        location: '',
        date: '2025/8/2',
        riskLevel: 70.0,
        type: '실종',
        isProcessed: false,
      ),
      const CaseEntity(
        id: '6',
        name: '박하은',
        phoneNumber: '042-518-2153',
        location: '제주도 제주시 진군남....',
        date: '2025/8/2',
        riskLevel: 70.0,
        type: '사고',
        isProcessed: true,
      ),
    ];
  }
}