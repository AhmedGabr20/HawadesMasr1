import 'package:hive/hive.dart';

class IncidentDao {
  IncidentDao(this._box);
  final Box<Map> _box;

  Future<void> upsert(String id, Map<String, dynamic> incident) => _box.put(id, incident);

  List<Map<String, dynamic>> all() => _box.values.cast<Map<String, dynamic>>().toList();

  List<Map<String, dynamic>> unsynced() =>
      all().where((i) => (i['synced'] as bool? ?? false) == false).toList();
}
