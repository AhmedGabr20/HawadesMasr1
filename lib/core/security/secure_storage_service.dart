import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Lightweight encrypted storage abstraction.
/// Flutter uses platform keystore/Keychain through [FlutterSecureStorage].
/// We add an AES layer for defense-in-depth for token payloads.
class SecureStorageService {
  SecureStorageService(this._storage)
      : _crypter = encrypt.Encrypter(
          encrypt.AES(
            encrypt.Key.fromUtf8('16charslongkey!!'),
            mode: encrypt.AESMode.cbc,
          ),
        ),
        _iv = encrypt.IV.fromLength(16);

  final FlutterSecureStorage _storage;
  final encrypt.Encrypter _crypter;
  final encrypt.IV _iv;

  Future<void> writeEncrypted(String key, String value) async {
    final encrypted = _crypter.encrypt(value, iv: _iv).base64;
    await _storage.write(key: key, value: encrypted);
  }

  Future<String?> readEncrypted(String key) async {
    final encryptedValue = await _storage.read(key: key);
    if (encryptedValue == null) return null;
    return _crypter.decrypt64(encryptedValue, iv: _iv);
  }

  Future<void> writeJson(String key, Map<String, dynamic> value) async {
    await writeEncrypted(key, jsonEncode(value));
  }

  Future<Map<String, dynamic>?> readJson(String key) async {
    final plain = await readEncrypted(key);
    return plain == null ? null : jsonDecode(plain) as Map<String, dynamic>;
  }

  Future<void> clearAll() => _storage.deleteAll();
}
