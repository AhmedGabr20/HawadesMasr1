import '../models/incident.dart';

abstract class IncidentsRepository {
  Future<void> createIncident(Incident incident);
  Future<List<Incident>> getIncidents({
    String? status,
    String? severity,
    String? type,
    int page,
  });
  Future<Incident> getIncident(String id);
  Future<void> changeStatus(String id, String status);
  Future<void> assignInvestigator(String id, String investigatorId);
  Stream<List<Incident>> watchLocalIncidents();
  Future<void> syncPending();
}
