import 'dart:async';

import 'package:uuid/uuid.dart';

import '../../core/constants/app_constants.dart';

import '../../domain/models/incident.dart';
import '../../domain/repositories/incidents_repository.dart';
import '../local/dao/incident_dao.dart';
import '../remote/api/incidents_api.dart';

class IncidentsRepositoryImpl implements IncidentsRepository {
  IncidentsRepositoryImpl(this._api, this._dao);

  final IncidentsApi _api;
  final IncidentDao _dao;
  final _controller = StreamController<List<Incident>>.broadcast();

  @override
  Future<void> createIncident(Incident incident) async {
    await _dao.upsert(incident.id, {
      'id': incident.id,
      'title': incident.title,
      'description': incident.description,
      'status': incident.status.name,
      'severity': incident.severity,
      'type': incident.type,
      'lat': incident.lat,
      'lng': incident.lng,
      'address': incident.address,
      'synced': false,
      'idempotencyKey': const Uuid().v4(),
    });
    _emitLocal();
  }

  @override
  Future<List<Incident>> getIncidents({String? status, String? severity, String? type, int page = 1}) async {
    final remote = await _api.list(page: page, status: status, severity: severity, type: type);
    return remote
        .map(
          (e) => Incident(
            id: e['id'] as String,
            title: e['title'] as String,
            description: e['description'] as String,
            status: _parseStatus(e['status'] as String),
            severity: e['severity'] as String,
            type: e['type'] as String,
            lat: (e['lat'] as num).toDouble(),
            lng: (e['lng'] as num).toDouble(),
            address: e['address'] as String,
            synced: true,
          ),
        )
        .toList();
  }

  @override
  Future<Incident> getIncident(String id) async {
    final e = await _api.details(id);
    return Incident(
      id: e['id'] as String,
      title: e['title'] as String,
      description: e['description'] as String,
      status: _parseStatus(e['status'] as String),
      severity: e['severity'] as String,
      type: e['type'] as String,
      lat: (e['lat'] as num).toDouble(),
      lng: (e['lng'] as num).toDouble(),
      address: e['address'] as String,
      synced: true,
    );
  }

  @override
  Future<void> changeStatus(String id, String status) => _api.updateStatus(id, status);

  @override
  Future<void> assignInvestigator(String id, String investigatorId) => _api.assign(id, investigatorId);

  @override
  Stream<List<Incident>> watchLocalIncidents() => _controller.stream;

  @override
  Future<void> syncPending() async {
    for (final local in _dao.unsynced()) {
      await _api.create(local.cast<String, dynamic>());
      await _dao.upsert(local['id'] as String, {...local, 'synced': true});
    }
    _emitLocal();
  }

  void _emitLocal() {
    final incidents = _dao
        .all()
        .map(
          (e) => Incident(
            id: e['id'] as String,
            title: e['title'] as String,
            description: e['description'] as String,
            status: _parseStatus(e['status'] as String),
            severity: e['severity'] as String,
            type: e['type'] as String,
            lat: (e['lat'] as num).toDouble(),
            lng: (e['lng'] as num).toDouble(),
            address: e['address'] as String,
            synced: e['synced'] as bool,
          ),
        )
        .toList();
    _controller.add(incidents);
  }

  IncidentStatus _parseStatus(String s) {
    switch (s) {
      case 'assigned':
        return IncidentStatus.assigned;
      case 'inProgress':
        return IncidentStatus.inProgress;
      case 'closed':
        return IncidentStatus.closed;
      default:
        return IncidentStatus.open;
    }
  }
}
