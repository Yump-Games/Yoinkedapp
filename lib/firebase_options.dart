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
    apiKey: 'AIzaSyCku2zIDHrUWCNEsY2ao6rQPq6cJAZZlRc',
    appId: '1:29420653037:web:3f36226c9c4450eab07fe4',
    messagingSenderId: '29420653037',
    projectId: 'yoinked-app',
    authDomain: 'yoinked-app.firebaseapp.com',
    storageBucket: 'yoinked-app.appspot.com',
    measurementId: 'G-L1ELH9LE4B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTp7ol8ay5RpWRK8_KhKT8QoYxNNUmNhM',
    appId: '1:29420653037:android:bce62c7a8d4d1a13b07fe4',
    messagingSenderId: '29420653037',
    projectId: 'yoinked-app',
    storageBucket: 'yoinked-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfrqJZ34S2MWcEpowWJje5UtiSDcQeHas',
    appId: '1:29420653037:ios:aeb4e89e3b3e8b2eb07fe4',
    messagingSenderId: '29420653037',
    projectId: 'yoinked-app',
    storageBucket: 'yoinked-app.appspot.com',
    iosBundleId: 'com.example.yoinkedapp',
  );
}
