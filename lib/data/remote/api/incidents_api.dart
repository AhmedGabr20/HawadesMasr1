import 'package:dio/dio.dart';

class IncidentsApi {
  IncidentsApi(this._dio);
  final Dio _dio;

  Future<Map<String, dynamic>> create(Map<String, dynamic> body) async {
    final res = await _dio.post('/v1/incidents', data: body);
    return res.data as Map<String, dynamic>;
  }

  Future<List<dynamic>> list({int page = 1, String? status, String? severity, String? type}) async {
    final res = await _dio.get('/v1/incidents', queryParameters: {
      'page': page,
      'status': status,
      'severity': severity,
      'type': type,
    });
    return res.data['items'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> details(String id) async {
    final res = await _dio.get('/v1/incidents/$id');
    return res.data as Map<String, dynamic>;
  }

  Future<void> updateStatus(String id, String status) =>
      _dio.post('/v1/incidents/$id/status', data: {'status': status});

  Future<void> assign(String id, String investigatorId) =>
      _dio.post('/v1/incidents/$id/assign', data: {'investigatorId': investigatorId});
}
