import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:easylibro_app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi{
  //create an instance of firebase messaging
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize notifications
  Future<void> initNotifications() async {
    //request permision from user (will prompt user)
    await _firebaseMessaging.requestPermission();

    //fetch the FCM token for this device
    final fCMToken = await _firebaseMessaging.getToken();

    print('Token: $fCMToken');
  }
}