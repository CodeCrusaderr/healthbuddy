// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAoOZRtdid0hXlIOmb2xD3oMbQcb2HyX4E',
    appId: '1:861625362829:web:aaa0520ced7ecd500135c4',
    messagingSenderId: '861625362829',
    projectId: 'health-buddy-dba97',
    authDomain: 'health-buddy-dba97.firebaseapp.com',
    storageBucket: 'health-buddy-dba97.appspot.com',
    measurementId: 'G-PC6CT336TN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmfcA9LV375cHWo6z6YJ9qa_PJmuqprus',
    appId: '1:861625362829:android:c85f3bcc7ea2ed680135c4',
    messagingSenderId: '861625362829',
    projectId: 'health-buddy-dba97',
    storageBucket: 'health-buddy-dba97.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyALJdD-xA5U1-TsqiyJ9pXmFH11-z5Z1WE',
    appId: '1:861625362829:ios:8c155f8897626c820135c4',
    messagingSenderId: '861625362829',
    projectId: 'health-buddy-dba97',
    storageBucket: 'health-buddy-dba97.appspot.com',
    iosBundleId: 'com.example.dashboard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyALJdD-xA5U1-TsqiyJ9pXmFH11-z5Z1WE',
    appId: '1:861625362829:ios:5c745b81bb40c1730135c4',
    messagingSenderId: '861625362829',
    projectId: 'health-buddy-dba97',
    storageBucket: 'health-buddy-dba97.appspot.com',
    iosBundleId: 'com.example.dashboard.RunnerTests',
  );
}
