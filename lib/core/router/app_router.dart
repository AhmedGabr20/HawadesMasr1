import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/auth/login_screen.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/incidents/create/create_incident_screen.dart';
import '../../presentation/incidents/details/incident_details_screen.dart';
import '../../presentation/incidents/list/incident_list_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(
        path: '/home',
        builder: (_, __) => const HomeScreen(),
        routes: [
          GoRoute(path: 'incidents', builder: (_, __) => const IncidentListScreen()),
          GoRoute(path: 'incidents/new', builder: (_, __) => const CreateIncidentScreen()),
          GoRoute(
            path: 'incidents/:id',
            builder: (_, state) => IncidentDetailsScreen(incidentId: state.pathParameters['id']!),
          ),
        ],
      ),
    ],
  );
});
