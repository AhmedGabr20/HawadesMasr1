import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_constants.dart';
import '../../../domain/models/incident.dart';
import '../../../di/providers.dart';

class CreateIncidentScreen extends ConsumerStatefulWidget {
  const CreateIncidentScreen({super.key});

  @override
  ConsumerState<CreateIncidentScreen> createState() => _CreateIncidentScreenState();
}

class _CreateIncidentScreenState extends ConsumerState<CreateIncidentScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  String _type = 'Traffic';
  String _severity = 'High';

  Future<void> _submit() async {
    final pos = await Geolocator.getCurrentPosition();
    final places = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    final place = places.first;
    final address = '${place.street}, ${place.locality}';

    final incident = Incident(
      id: const Uuid().v4(),
      title: _title.text,
      description: _description.text,
      status: IncidentStatus.open,
      severity: _severity,
      type: _type,
      lat: pos.latitude,
      lng: pos.longitude,
      address: address,
      synced: false,
    );
    await ref.read(incidentsRepositoryProvider).createIncident(incident);
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم الحفظ محلياً وسيتم المزامنة تلقائياً')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة حادث')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(controller: _title, decoration: const InputDecoration(labelText: 'العنوان')),
          TextField(controller: _description, decoration: const InputDecoration(labelText: 'الوصف')),
          DropdownButtonFormField<String>(
            value: _type,
            items: const ['Traffic', 'Fire', 'Crime'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => _type = v ?? _type),
            decoration: const InputDecoration(labelText: 'النوع'),
          ),
          DropdownButtonFormField<String>(
            value: _severity,
            items: const ['Low', 'Medium', 'High'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => _severity = v ?? _severity),
            decoration: const InputDecoration(labelText: 'الخطورة'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _submit, child: const Text('حفظ وإرسال')),
        ],
      ),
    );
  }
}
