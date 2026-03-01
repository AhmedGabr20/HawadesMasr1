import '../../core/constants/app_constants.dart';
import '../../core/security/secure_storage_service.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../remote/api/auth_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._api, this._storage);

  final AuthApi _api;
  final SecureStorageService _storage;

  static const _tokenKey = 'auth_tokens';
  static const _userKey = 'auth_user';

  @override
  Future<User> login(String email, String password) async {
    final data = await _api.login(email: email, password: password);
    await _storage.writeJson(_tokenKey, {
      'accessToken': data['accessToken'],
      'refreshToken': data['refreshToken'],
    });
    await _storage.writeJson(_userKey, data['user'] as Map<String, dynamic>);
    return User(
      id: data['user']['id'] as String,
      email: data['user']['email'] as String,
      role: UserRole.values.byName(data['user']['role'] as String),
    );
  }

  @override
  Future<String?> getAccessToken() async => (await _storage.readJson(_tokenKey))?['accessToken'] as String?;

  @override
  Future<bool> refreshToken() async {
    // Replace with /refresh endpoint in backend.
    final payload = await _storage.readJson(_tokenKey);
    if (payload == null || payload['refreshToken'] == null) return false;
    return true;
  }

  @override
  Future<void> logout() => _storage.clearAll();

  @override
  Future<User?> currentUser() async {
    final user = await _storage.readJson(_userKey);
    if (user == null) return null;
    return User(
      id: user['id'] as String,
      email: user['email'] as String,
      role: UserRole.values.byName(user['role'] as String),
    );
  }
}
