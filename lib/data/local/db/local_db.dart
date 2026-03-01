import 'package:hive_flutter/hive_flutter.dart';

class LocalDb {
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<Map>('incidents');
    await Hive.openBox<Map>('users');
    await Hive.openBox<Map>('events');
    await Hive.openBox<Map>('media');
  }
}
