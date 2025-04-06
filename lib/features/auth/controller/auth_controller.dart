import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/features/auth/domain/auth_repository.dart';
import 'package:travel_journal/features/auth/domain/provider/user_provider.dart';
import 'package:travel_journal/features/auth/domain/user_model.dart';
import 'package:travel_journal/features/auth/domain/provider/auth_provider.dart';

/// This controller manages the authentication state of the user.
/// It uses the AuthRepository to perform authentication operations
/// and notifies the UI about the changes in the authentication state.
/// It extends StateNotifier to manage the state of the authentication process.
/// The state is represented by an AsyncValue<UserModel?>,
/// which can be in a loading, data, or error state.
/// The AsyncValue class is a wrapper that can hold either a value or an error,
/// making it easier to handle asynchronous operations in Flutter.
final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<UserModel?>>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthController(ref, repository);
});

/// The AuthController class is responsible for managing the authentication state
/// and performing authentication operations.
class AuthController extends StateNotifier<AsyncValue<UserModel?>> {
  /// The constructor takes a Ref and an AuthRepository as parameters.
  // ignore: unused_field
  final Ref _ref;
  final AuthRepository _authRepository;

  AuthController(this._ref, this._authRepository)
      : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _authRepository.authStateChanges().listen((user) {
      state = AsyncValue.data(user);
    });
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _authRepository.signUp(
        fullName: fullName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userModel = UserModel(
          uid: currentUser.uid,
          fullName: fullName,
          email: email,
          phoneNumber: phoneNumber,
          profileImageUrl: null,
        );
        await _ref.read(userRepositoryProvider).createUser(userModel);
        state = AsyncValue.data(userModel);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      final user =
          await _authRepository.signIn(email: email, password: password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);

      /// rethrow the error to be handled in the UI
      rethrow;
    }
  }

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String verificationId) codeSent,
    required Function(String error) onError,
  }) async {
    await _authRepository.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: codeSent,
      onError: onError,
    );
  }

  Future<void> verifyOtpCode({
    required String verificationId,
    required String smsCode,
  }) async {
    await _authRepository.verifyOtpCode(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _authRepository.sendPasswordResetEmail(email);
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _authRepository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = const AsyncValue.data(null);
  }
}
