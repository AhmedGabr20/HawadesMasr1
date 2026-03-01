import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'incidents_list_view_model.dart';

class IncidentListScreen extends ConsumerStatefulWidget {
  const IncidentListScreen({super.key});

  @override
  ConsumerState<IncidentListScreen> createState() => _IncidentListScreenState();
}

class _IncidentListScreenState extends ConsumerState<IncidentListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(incidentsListVmProvider.notifier).load());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(incidentsListVmProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('قائمة الحوادث')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(incidentsListVmProvider.notifier).load(),
        child: ListView.builder(
          itemCount: state.items.length,
          itemBuilder: (_, i) {
            final incident = state.items[i];
            return ListTile(
              title: Text(incident.title),
              subtitle: Text('${incident.status.name} • ${incident.severity}'),
              trailing: incident.synced ? const Icon(Icons.cloud_done) : const Icon(Icons.cloud_off),
              onTap: () => context.go('/home/incidents/${incident.id}'),
            );
          },
        ),
      ),
    );
  }
}
