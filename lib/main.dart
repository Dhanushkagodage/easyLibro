import 'package:easylibro_app/screens/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  //print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  requestNotificationPermissions();

  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // ignore: avoid_print
    print('Got a message whilst in the foreground!');
    // ignore: avoid_print
    print('Message data: ${message.data}');

    if (message.notification != null) {
      // ignore: avoid_print
      print('Message also contained a notification: ${message.notification}');
    }
  });
  final fcmToken = await FirebaseMessaging.instance.getToken();
  if (fcmToken != null) {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setString('token', fcmToken);
  }
  // ignore: avoid_print
  print('Message data: $fcmToken');
  runApp(const MyApp());
}

Future<void> requestNotificationPermissions() async {

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
  // ignore: avoid_print
  print('User granted permission: ${settings.authorizationStatus}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, _) => const MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "EasyLibro APP",
              home: SplashScreen(),
            ),
        designSize: const Size(412, 732));
  }
}
