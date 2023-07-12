import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('title:${message.notification?.title}');
  print('Body:${message.notification?.body}');
  print('Payload:${message.data}');
}

class FirebaseMessageApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    final settings = await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final fCMToken = await _firebaseMessaging.getToken();
      print('Token: $fCMToken');
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    } else {
      print('Permission not granted');
    }
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
  }
}
