import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/features/auth/data/auth_repository_impl.dart';
import 'package:travel_journal/features/auth/domain/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});
