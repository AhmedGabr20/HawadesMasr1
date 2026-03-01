import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/incident.dart';
import '../../../di/providers.dart';

class IncidentsListState {
  const IncidentsListState({this.items = const [], this.loading = false});
  final List<Incident> items;
  final bool loading;

  IncidentsListState copyWith({List<Incident>? items, bool? loading}) =>
      IncidentsListState(items: items ?? this.items, loading: loading ?? this.loading);
}

class IncidentsListViewModel extends StateNotifier<IncidentsListState> {
  IncidentsListViewModel(this.ref) : super(const IncidentsListState());
  final Ref ref;

  Future<void> load() async {
    state = state.copyWith(loading: true);
    final items = await ref.read(incidentsRepositoryProvider).getIncidents(page: 1);
    state = state.copyWith(items: items, loading: false);
  }
}

final incidentsListVmProvider = StateNotifierProvider<IncidentsListViewModel, IncidentsListState>(
  IncidentsListViewModel.new,
);
