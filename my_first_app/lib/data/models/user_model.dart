import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.user,
    required super.email,
    required super.mobileNumber,
    required super.password,
    super.createdAt,
    super.updatedAt,
  });

  // Convert from Firebase document to UserModel
  factory UserModel.fromFirestore(Map<String, dynamic> doc, String docId) {
    return UserModel(
      id: docId,
      user: doc['Name'] ?? '', // Changed from 'User' to 'Name'
      email: doc['Email'] ?? '',
      mobileNumber: doc['MobileNumber'] ?? 0,
      password: doc['Password'] ?? '', // Note: Handle password security properly
      createdAt: doc['createdAt']?.toDate(),
      updatedAt: doc['updatedAt']?.toDate(),
    );
  }

  // Convert UserModel to Firebase document format
  Map<String, dynamic> toFirestore() {
    return {
      'Name': user, // Changed from 'User' to 'Name'
      'Email': email,
      'MobileNumber': mobileNumber,
      'Password': password, // Note: In production, hash passwords!
      'createdAt': createdAt,
      'updatedAt': updatedAt ?? DateTime.now(),
    };
  }

  // Convert from JSON (for API responses)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      user: json['Name'] ?? json['User'] ?? '', // Support both field names
      email: json['Email'] ?? '',
      mobileNumber: json['MobileNumber'] ?? 0,
      password: json['Password'] ?? '',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'User': user,
      'Email': email,
      'MobileNumber': mobileNumber,
      'Password': password,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  UserModel copyWith({
    String? id,
    String? user,
    String? email,
    int? mobileNumber,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      user: user ?? this.user,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}