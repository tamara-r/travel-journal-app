import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/features/auth/data/user_repository.dart';
import 'package:travel_journal/features/auth/domain/user_model.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final userByIdProvider = FutureProvider.family<UserModel?, String>((ref, uid) {
  final repo = ref.watch(userRepositoryProvider);
  return repo.getUser(uid);
});
