import '../repositories/incidents_repository.dart';

class SyncIncidentsUseCase {
  SyncIncidentsUseCase(this._repo);
  final IncidentsRepository _repo;

  Future<void> call() => _repo.syncPending();
}
