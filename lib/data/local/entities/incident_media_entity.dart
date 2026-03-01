class IncidentMediaEntity {
  IncidentMediaEntity({
    required this.id,
    required this.incidentId,
    required this.localPath,
    required this.remoteUrl,
    required this.mediaType,
    required this.synced,
  });

  final String id;
  final String incidentId;
  final String localPath;
  final String? remoteUrl;
  final String mediaType;
  final bool synced;
}
