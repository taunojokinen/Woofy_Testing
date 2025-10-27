class User {
  final String id;
  final String user; // Username field
  final String email;
  final int mobileNumber;
  final String password; // Note: In production, never store passwords in plain text
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    required this.user,
    required this.email,
    required this.mobileNumber,
    required this.password,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    String? id,
    String? user,
    String? email,
    int? mobileNumber,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      user: user ?? this.user,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'User(id: $id, user: $user, email: $email, mobile: $mobileNumber)';
  }
}