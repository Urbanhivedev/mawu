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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAdF0x0UldWU9dSvppRzyuYF2F57Scx1LU',
    appId: '1:812106625364:web:32187bbdda82931654d8c1',
    messagingSenderId: '812106625364',
    projectId: 'mawu-b6634',
    authDomain: 'mawu-b6634.firebaseapp.com',
    storageBucket: 'mawu-b6634.appspot.com',
    measurementId: 'G-6SH9XM0T89',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBH5z0MQQkr5uwb0Hq6OreKqXCR-cuyXhQ',
    appId: '1:812106625364:android:19adb8afac55475754d8c1',
    messagingSenderId: '812106625364',
    projectId: 'mawu-b6634',
    storageBucket: 'mawu-b6634.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJHFb04Mx5aBJMmCGrcr8y5vs4dkAIW04',
    appId: '1:812106625364:ios:5e6c77d6042209da54d8c1',
    messagingSenderId: '812106625364',
    projectId: 'mawu-b6634',
    storageBucket: 'mawu-b6634.appspot.com',
    iosClientId:
        '812106625364-cif97917nkcf0ot9j0qc0ch69hal8l2q.apps.googleusercontent.com',
    iosBundleId: 'com.urbanHive.mawu',
  );
}