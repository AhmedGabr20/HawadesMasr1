import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/login_screen.dart';
import 'features/home/home_screen.dart';
import 'features/incident/create_incident_screen.dart';
import 'features/incident/incident_details_screen.dart';
import 'features/profile/profile_screen.dart';

void main() {
  runApp(const HawadesMasrApp());
}

class HawadesMasrApp extends StatelessWidget {
  const HawadesMasrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HawadesMasr',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        CreateIncidentScreen.routeName: (_) => const CreateIncidentScreen(),
        ProfileScreen.routeName: (_) => const ProfileScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == IncidentDetailsScreen.routeName) {
          final incident = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (_) => IncidentDetailsScreen(incident: incident),
          );
        }
        return null;
      },
    );
  }
}
