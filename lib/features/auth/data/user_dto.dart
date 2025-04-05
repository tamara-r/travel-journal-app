import 'package:travel_journal/features/auth/domain/user_model.dart';

/// user_model.dart	Clean domain model (used everywhere in the app)
/// user_dto.dart	Handles Firebase serialization/deserialization (Map ↔ Object)
/// user_repository.dart	Handles data operations (CRUD) and business logic
/// user_controller.dart	Handles state management and UI interactions
/// user_provider.dart	Provides the repository and controller to the UI

class UserDto {
  final String uid;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? profileImageUrl;
  final String? username;
  final String? bio;

  const UserDto({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.profileImageUrl,
    this.username,
    this.bio,
  });

  /// Convert Firebase data (Map) to UserDto
  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      uid: map['uid'],
      fullName: map['fullName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      profileImageUrl: map['profileImageUrl'],
      username: map['username'],
      bio: map['bio'],
    );
  }

  /// Convert UserDto to a Map (to store in Firebase)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'username': username,
      'bio': bio,
    };
  }

  /// Convert DTO to domain model
  UserModel toDomain() {
    return UserModel(
      uid: uid,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      profileImageUrl: profileImageUrl,
      username: username,
      bio: bio,
    );
  }

  /// Create DTO from domain model
  factory UserDto.fromDomain(UserModel model) {
    return UserDto(
      uid: model.uid,
      fullName: model.fullName,
      email: model.email,
      phoneNumber: model.phoneNumber,
      profileImageUrl: model.profileImageUrl,
      username: model.username,
      bio: model.bio,
    );
  }
}
