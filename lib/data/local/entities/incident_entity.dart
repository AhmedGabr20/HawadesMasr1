import '../../../core/constants/app_constants.dart';

class IncidentEntity {
  IncidentEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.severity,
    required this.status,
    required this.lat,
    required this.lng,
    required this.address,
    required this.synced,
    required this.idempotencyKey,
  });

  final String id;
  final String title;
  final String description;
  final String type;
  final String severity;
  final IncidentStatus status;
  final double lat;
  final double lng;
  final String address;
  final bool synced;
  final String idempotencyKey;
}
