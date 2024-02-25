import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';

Future<void> requestPermissionNotification() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

void fanNotification() {
  FirebaseMessaging.onMessage.listen((message) {
    print(
        '=========================================Notification===============================');
    print(message.notification!.title);
    // FlutterRingtonePlayer().playNotification();
    Get.snackbar(message.notification!.title!, message.notification!.body!);
  });
}
