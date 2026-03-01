import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key, required this.current});
  final LatLng current;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تتبع المحقق')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: current, zoom: 16),
        markers: {Marker(markerId: const MarkerId('me'), position: current)},
      ),
    );
  }
}
