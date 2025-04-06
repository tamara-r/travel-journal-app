import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_journal/features/auth/data/user_dto.dart';
import 'package:travel_journal/features/auth/domain/user_model.dart';

class UserRepository {
  final _users = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel user) async {
    final dto = UserDto.fromDomain(user);
    await _users.doc(user.uid).set(dto.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _users.doc(uid).get();
    if (doc.exists) {
      return UserDto.fromMap(doc.data()!).toDomain();
    }
    return null;
  }
}
