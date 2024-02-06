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
    apiKey: 'AIzaSyD292WBV3xpkcI4LkekFM4DBsXUdEUVpAI',
    appId: '1:942430095722:web:15e41bb6de8fb660927d13',
    messagingSenderId: '942430095722',
    projectId: 'expense-tracker-000',
    authDomain: 'expense-tracker-000.firebaseapp.com',
    storageBucket: 'expense-tracker-000.appspot.com',
    measurementId: 'G-T6ZQ657N8Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2OoAYCY4sT3ti5y_nuHzMZ2rTClZmjOY',
    appId: '1:942430095722:android:783d32348338e4c5927d13',
    messagingSenderId: '942430095722',
    projectId: 'expense-tracker-000',
    storageBucket: 'expense-tracker-000.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAA3iNs_dYY0w0rBzPnMEMXUr534r07x0w',
    appId: '1:942430095722:ios:b95e729b44c2d0f9927d13',
    messagingSenderId: '942430095722',
    projectId: 'expense-tracker-000',
    storageBucket: 'expense-tracker-000.appspot.com',
    iosBundleId: 'com.example.expenceTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAA3iNs_dYY0w0rBzPnMEMXUr534r07x0w',
    appId: '1:942430095722:ios:a59fc2c339ea35d3927d13',
    messagingSenderId: '942430095722',
    projectId: 'expense-tracker-000',
    storageBucket: 'expense-tracker-000.appspot.com',
    iosBundleId: 'com.example.expenceTracker.RunnerTests',
  );
}