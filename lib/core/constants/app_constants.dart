class AppConstants {
  static const baseUrl = 'https://api.hawadesmasr.com';
  static const connectTimeoutMs = 20000;
  static const receiveTimeoutMs = 30000;
  static const locationIntervalSeconds = 30;
}

enum UserRole { reporter, investigator, manager, admin }

enum IncidentStatus { open, assigned, inProgress, closed }
