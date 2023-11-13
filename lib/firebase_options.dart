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
    apiKey: 'AIzaSyAZpoQ9dBrL_Crv9P1UBq9w18VMjJXRP3w',
    appId: '1:834530792592:web:72da5cb834ded3bba93415',
    messagingSenderId: '834530792592',
    projectId: 'joiner-e8e40',
    authDomain: 'joiner-e8e40.firebaseapp.com',
    storageBucket: 'joiner-e8e40.appspot.com',
    measurementId: 'G-LD6EFYN9HF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrRxzBrQ17562dlfjfCWQCc96UR0Pxxr0',
    appId: '1:834530792592:android:78bafb82b53079ffa93415',
    messagingSenderId: '834530792592',
    projectId: 'joiner-e8e40',
    storageBucket: 'joiner-e8e40.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4l1CkIKJUjMEc8zW-QArs2cEWT-Ul4p0',
    appId: '1:834530792592:ios:d5723f56e416c5cca93415',
    messagingSenderId: '834530792592',
    projectId: 'joiner-e8e40',
    storageBucket: 'joiner-e8e40.appspot.com',
    iosBundleId: 'com.mycompany.joiner1',
  );
}
