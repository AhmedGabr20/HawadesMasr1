import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../core/constants/app_constants.dart';
import '../core/network/dio_client.dart';
import '../core/security/secure_storage_service.dart';
import '../core/services/upload_service.dart';
import '../data/local/dao/incident_dao.dart';
import '../data/local/db/local_db.dart';
import '../data/remote/api/auth_api.dart';
import '../data/remote/api/incidents_api.dart';
import '../data/remote/api/investigator_api.dart';
import '../data/remote/api/uploads_api.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/incidents_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/incidents_repository.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/sync_incidents_usecase.dart';

Future<void> bootstrapDependencies() async {
  final db = LocalDb();
  await db.init();
}

Future<ProviderContainer> createContainer() async {
  await bootstrapDependencies();
  return ProviderContainer();
}

final flutterSecureStorageProvider = Provider((_) => const FlutterSecureStorage());
final secureStorageServiceProvider = Provider(
  (ref) => SecureStorageService(ref.watch(flutterSecureStorageProvider)),
);

final dioProvider = Provider<Dio>((ref) {
  final secure = ref.watch(secureStorageServiceProvider);
  return createDio(
    getAccessToken: () async => (await secure.readJson('auth_tokens'))?['accessToken'] as String?,
    refreshToken: () async => true,
    logout: () => secure.clearAll(),
  );
});

final authDioProvider = Provider<Dio>(
  (_) => Dio(BaseOptions(baseUrl: AppConstants.baseUrl, headers: {'Content-Type': 'application/json'})),
);

final authApiProvider = Provider((ref) => AuthApi(ref.watch(authDioProvider)));
final incidentsApiProvider = Provider((ref) => IncidentsApi(ref.watch(dioProvider)));
final investigatorApiProvider = Provider((ref) => InvestigatorApi(ref.watch(dioProvider)));
final uploadsApiProvider = Provider((ref) => UploadsApi(ref.watch(dioProvider)));

final _incidentBoxProvider = Provider<Box<Map>>((_) => Hive.box<Map>('incidents'));
final incidentDaoProvider = Provider((ref) => IncidentDao(ref.watch(_incidentBoxProvider)));

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.watch(authApiProvider), ref.watch(secureStorageServiceProvider)),
);

final incidentsRepositoryProvider = Provider<IncidentsRepository>(
  (ref) => IncidentsRepositoryImpl(ref.watch(incidentsApiProvider), ref.watch(incidentDaoProvider)),
);

final loginUseCaseProvider = Provider((ref) => LoginUseCase(ref.watch(authRepositoryProvider)));
final syncIncidentsUseCaseProvider = Provider((ref) => SyncIncidentsUseCase(ref.watch(incidentsRepositoryProvider)));

final uploadServiceProvider = Provider((ref) => UploadService(ref.watch(uploadsApiProvider)));
