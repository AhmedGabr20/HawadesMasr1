import 'package:dio/dio.dart';

class InvestigatorApi {
  InvestigatorApi(this._dio);
  final Dio _dio;

  Future<void> sendLocation({required double lat, required double lng}) async {
    await _dio.post('/v1/investigators/location', data: {'lat': lat, 'lng': lng});
  }
}
