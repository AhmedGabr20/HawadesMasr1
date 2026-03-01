import 'package:dio/dio.dart';

class AuthApi {
  AuthApi(this._dio);
  final Dio _dio;

  Future<Map<String, dynamic>> login({required String email, required String password}) async {
    final res = await _dio.post('/v1/auth/login', data: {'email': email, 'password': password});
    return res.data as Map<String, dynamic>;
  }
}
