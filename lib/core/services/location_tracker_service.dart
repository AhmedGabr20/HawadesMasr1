import 'package:geolocator/geolocator.dart';

import '../../data/remote/api/investigator_api.dart';

class LocationTrackerService {
  LocationTrackerService(this._api);
  final InvestigatorApi _api;

  Stream<Position> stream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      ),
    );
  }

  Future<void> pushLocation(Position p) {
    return _api.sendLocation(lat: p.latitude, lng: p.longitude);
  }
}
