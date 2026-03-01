class IncidentEventEntity {
  IncidentEventEntity({
    required this.id,
    required this.incidentId,
    required this.action,
    required this.actor,
    required this.createdAt,
  });

  final String id;
  final String incidentId;
  final String action;
  final String actor;
  final DateTime createdAt;
}
