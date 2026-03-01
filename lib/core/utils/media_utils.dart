import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class MediaUtils {
  static Future<File> compressImage(File file) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      '${file.parent.path}/${file.uri.pathSegments.last}.compressed.jpg',
      quality: 70,
    );
    return File(result!.path);
  }
}
