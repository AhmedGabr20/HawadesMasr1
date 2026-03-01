import '../../../core/constants/app_constants.dart';

class UserEntity {
  UserEntity({required this.id, required this.email, required this.role});

  final String id;
  final String email;
  final UserRole role;
}
