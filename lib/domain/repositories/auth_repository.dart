import '../models/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<String?> getAccessToken();
  Future<bool> refreshToken();
  Future<void> logout();
  Future<User?> currentUser();
}
