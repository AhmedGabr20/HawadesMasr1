import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../di/providers.dart';

class IncidentDetailsScreen extends ConsumerWidget {
  const IncidentDetailsScreen({super.key, required this.incidentId});
  final String incidentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(incidentsRepositoryProvider).getIncident(incidentId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final incident = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: Text(incident.title)),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(incident.description),
              Text('الحالة: ${incident.status.name}'),
              Text('المحقق المكلف: غير محدد'),
              const SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(target: LatLng(incident.lat, incident.lng), zoom: 15),
                  markers: {
                    Marker(markerId: const MarkerId('incident'), position: LatLng(incident.lat, incident.lng)),
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text('السجل الزمني', style: TextStyle(fontWeight: FontWeight.bold)),
              const ListTile(title: Text('Created'), subtitle: Text('تم إنشاء الحادث')),
              const ListTile(title: Text('Status Changed'), subtitle: Text('Open → Assigned')),
              const ListTile(title: Text('Comment Added'), subtitle: Text('تم إضافة تعليق')),
            ],
          ),
        );
      },
    );
  }
}
