import 'user_model.dart';

// This is the interface for the AuthRepository
// It defines the methods that any class implementing this interface must provide.
abstract class AuthRepository {
  // This method is used to sign up a new user
  // It takes the user's full name, email, password, and phone number as parameters
  // and returns a Future<void> indicating the completion of the operation.
  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
  });

  // This method is used to sign in an existing user
  // It takes the user's email and password as parameters
  // and returns a Future<UserModel> representing the signed-in user.
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String verificationId) codeSent,
    required Function(String error) onError,
  });

  // This method is used to verify the OTP code sent to the user's phone
  // It takes the verification ID and the OTP code as parameters
  // and returns a Future<void> indicating the completion of the operation.
  // The verification ID is used to identify the session for the OTP verification.
  Future<void> verifyOtpCode({
    required String verificationId,
    required String smsCode,
  });

  // This method is used to sign in an existing user
  // It takes the user's email and password as parameters
  // and returns a Future<UserModel> representing the signed-in user.
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  // This method to reset the user's password
  // It takes the user's email as a parameter
  // and returns a Future<void> indicating the completion of the operation.
  Future<void> sendPasswordResetEmail(String email);

  // changePassword method to change the user's password
  // It takes the current password and the new password as parameters
  // and returns a Future<void> indicating the completion of the operation.
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  // This method is used to sign out the current user
  // It returns a Future<void> indicating the completion of the operation.
  Future<void> logout();
  // This method is used to get the current user's information
  // It returns a Future<UserModel?> representing the current user.
  // Useful for checking if a user is logged in or not.
  // We will store the user information in the shared preferences
  Stream<UserModel?> authStateChanges();
}
