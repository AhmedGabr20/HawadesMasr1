import '../../core/constants/app_constants.dart';

class Incident {
  Incident({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.severity,
    required this.type,
    required this.lat,
    required this.lng,
    required this.address,
    required this.synced,
  });

  final String id;
  final String title;
  final String description;
  final IncidentStatus status;
  final String severity;
  final String type;
  final double lat;
  final double lng;
  final String address;
  final bool synced;
}
