import '../models/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  LoginUseCase(this._repo);
  final AuthRepository _repo;

  Future<User> call(String email, String password) => _repo.login(email, password);
}
