import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  Future<void> init() async {
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();

    FirebaseMessaging.onMessage.listen((message) {
      // Display local notification banner if needed.
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // Deep-link to /home/incidents/{id}.
    });
  }
}
