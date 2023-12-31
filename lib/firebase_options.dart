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
    apiKey: 'AIzaSyCINGbILdQShLN8Nj10A-dipb1uVc2arrw',
    appId: '1:204496913997:web:ddcf050c7698ca50bffe04',
    messagingSenderId: '204496913997',
    projectId: 'fastfueltag-1ae14',
    authDomain: 'fastfueltag-1ae14.firebaseapp.com',
    storageBucket: 'fastfueltag-1ae14.appspot.com',
    measurementId: 'G-GZ77KBF37E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBo01pFYzVWX_oQElW8D-w4PHyBkiVh6-0',
    appId: '1:204496913997:android:d561a9ead93b087cbffe04',
    messagingSenderId: '204496913997',
    projectId: 'fastfueltag-1ae14',
    storageBucket: 'fastfueltag-1ae14.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOJRMuZcguGTuP-RuHBWHnYG0GydBT4Lw',
    appId: '1:204496913997:ios:27aef9677399193ebffe04',
    messagingSenderId: '204496913997',
    projectId: 'fastfueltag-1ae14',
    storageBucket: 'fastfueltag-1ae14.appspot.com',
    iosBundleId: 'in.autoinnotech.fastfueltag',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCOJRMuZcguGTuP-RuHBWHnYG0GydBT4Lw',
    appId: '1:204496913997:ios:64174dfd1e0d9115bffe04',
    messagingSenderId: '204496913997',
    projectId: 'fastfueltag-1ae14',
    storageBucket: 'fastfueltag-1ae14.appspot.com',
    iosBundleId: 'in.autoinnotech.fastfueltag.RunnerTests',
  );
}
