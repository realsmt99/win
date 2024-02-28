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
    apiKey: 'AIzaSyAtX_qtrSOe_AacIHjL5AGLgFBye_U1SvE',
    appId: '1:510165900178:web:2a1e29fd13daa1de49bf4b',
    messagingSenderId: '510165900178',
    projectId: 'hackathonwinnerstelehack',
    authDomain: 'hackathonwinnerstelehack.firebaseapp.com',
    storageBucket: 'hackathonwinnerstelehack.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1RxbKRyPI9wSiF-8Q-X8MFSTg_EwBlvM',
    appId: '1:510165900178:android:28a73eb1328f755649bf4b',
    messagingSenderId: '510165900178',
    projectId: 'hackathonwinnerstelehack',
    storageBucket: 'hackathonwinnerstelehack.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaV0t4owrR6WDYtcTAb_ccIAi8CWf98h0',
    appId: '1:510165900178:ios:cd75dd3606bd66a049bf4b',
    messagingSenderId: '510165900178',
    projectId: 'hackathonwinnerstelehack',
    storageBucket: 'hackathonwinnerstelehack.appspot.com',
    iosBundleId: 'com.example.win',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDaV0t4owrR6WDYtcTAb_ccIAi8CWf98h0',
    appId: '1:510165900178:ios:9abca4e51edc4cd249bf4b',
    messagingSenderId: '510165900178',
    projectId: 'hackathonwinnerstelehack',
    storageBucket: 'hackathonwinnerstelehack.appspot.com',
    iosBundleId: 'com.example.win.RunnerTests',
  );
}