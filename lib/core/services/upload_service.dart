import 'dart:io';

import '../../data/remote/api/uploads_api.dart';

class UploadService {
  UploadService(this._api);
  final UploadsApi _api;

  Future<void> uploadWithSignedUrl(
    File file, {
    required String mime,
    required void Function(double) onProgress,
  }) async {
    final url = await _api.signedUrl(file.uri.pathSegments.last, mime);
    await _api.uploadToS3(url, file, (sent, total) {
      onProgress(total == 0 ? 0 : sent / total);
    });
  }
}
