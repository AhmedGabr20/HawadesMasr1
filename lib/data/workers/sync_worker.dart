import 'package:workmanager/workmanager.dart';

import '../../di/providers.dart';

const syncTaskName = 'sync-unsynced-incidents';

class SyncWorker {
  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      if (task == syncTaskName) {
        final container = await createContainer();
        await container.read(syncIncidentsUseCaseProvider).call();
      }
      return Future.value(true);
    });
  }

  static Future<void> register() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    await Workmanager().registerPeriodicTask(
      syncTaskName,
      syncTaskName,
      backoffPolicy: BackoffPolicy.exponential,
      frequency: const Duration(minutes: 15),
    );
  }
}
