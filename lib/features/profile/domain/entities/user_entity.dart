/// 사용자 정보를 나타내는 엔티티
class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? profileImageUrl;
  
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl,
  });
  
  /// 엔티티를 복사하면서 일부 필드를 업데이트
  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImageUrl,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is UserEntity &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.profileImageUrl == profileImageUrl;
  }
  
  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        profileImageUrl.hashCode;
  }
  
  @override
  String toString() {
    return 'UserEntity(id: $id, name: $name, email: $email, profileImageUrl: $profileImageUrl)';
  }
}