// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBITr3YQgHb6O8OzjODFdHLdmuLDFKDSL0',
    appId: '1:306141034466:web:1eecb82eeff052a89b6bbb',
    messagingSenderId: '306141034466',
    projectId: 'easylibro-a1e52',
    authDomain: 'easylibro-a1e52.firebaseapp.com',
    databaseURL: 'https://easylibro-a1e52-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'easylibro-a1e52.appspot.com',
    measurementId: 'G-XSZ9T4SWXV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCunv4C55xMYWgPEVY7mEm_BD2gvM5rNok',
    appId: '1:306141034466:android:c3953035241bf8939b6bbb',
    messagingSenderId: '306141034466',
    projectId: 'easylibro-a1e52',
    databaseURL: 'https://easylibro-a1e52-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'easylibro-a1e52.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKSLRXu88He_WQf6-_htk5OlLIcPioZYU',
    appId: '1:306141034466:ios:c59b35172fc15bf29b6bbb',
    messagingSenderId: '306141034466',
    projectId: 'easylibro-a1e52',
    databaseURL: 'https://easylibro-a1e52-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'easylibro-a1e52.appspot.com',
    iosBundleId: 'com.example.easylibroApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCKSLRXu88He_WQf6-_htk5OlLIcPioZYU',
    appId: '1:306141034466:ios:c59b35172fc15bf29b6bbb',
    messagingSenderId: '306141034466',
    projectId: 'easylibro-a1e52',
    databaseURL: 'https://easylibro-a1e52-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'easylibro-a1e52.appspot.com',
    iosBundleId: 'com.example.easylibroApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBITr3YQgHb6O8OzjODFdHLdmuLDFKDSL0',
    appId: '1:306141034466:web:1eecb82eeff052a89b6bbb',
    messagingSenderId: '306141034466',
    projectId: 'easylibro-a1e52',
    authDomain: 'easylibro-a1e52.firebaseapp.com',
    databaseURL: 'https://easylibro-a1e52-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'easylibro-a1e52.appspot.com',
    measurementId: 'G-XSZ9T4SWXV',
  );
}
