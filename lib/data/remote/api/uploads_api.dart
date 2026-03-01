import 'dart:io';

import 'package:dio/dio.dart';

class UploadsApi {
  UploadsApi(this._dio);
  final Dio _dio;

  Future<String> signedUrl(String fileName, String mime) async {
    final res = await _dio.post('/v1/uploads/signed-url', data: {'fileName': fileName, 'mime': mime});
    return res.data['url'] as String;
  }

  Future<void> uploadToS3(String url, File file, void Function(int, int) onProgress) {
    return _dio.putUri(Uri.parse(url), data: file.openRead(), onSendProgress: onProgress);
  }
}
