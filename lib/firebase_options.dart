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
    apiKey: 'AIzaSyDRTfd8bpIuOjwwHsTAtL_xksBdNGWcCpg',
    appId: '1:736102478882:web:8ae6c07671f05f3809c67b',
    messagingSenderId: '736102478882',
    projectId: 'gym-tracker-narzgul',
    authDomain: 'gym-tracker-narzgul.firebaseapp.com',
    storageBucket: 'gym-tracker-narzgul.appspot.com',
    measurementId: 'G-CCB5JWECP4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYLG-87v72-Mw9T8e8QHI6Jf3NMHIrIx4',
    appId: '1:736102478882:android:b14b95b3de2c281f09c67b',
    messagingSenderId: '736102478882',
    projectId: 'gym-tracker-narzgul',
    storageBucket: 'gym-tracker-narzgul.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFZlZlvIJBZEXDAx2IF6By_tfqIxhSBxY',
    appId: '1:736102478882:ios:5f066372a68a502e09c67b',
    messagingSenderId: '736102478882',
    projectId: 'gym-tracker-narzgul',
    storageBucket: 'gym-tracker-narzgul.appspot.com',
    androidClientId: '736102478882-r5io3fobdj41ts4nenehrs376ocmb9hp.apps.googleusercontent.com',
    iosBundleId: 'com.github.narzgul.gymTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAFZlZlvIJBZEXDAx2IF6By_tfqIxhSBxY',
    appId: '1:736102478882:ios:5f066372a68a502e09c67b',
    messagingSenderId: '736102478882',
    projectId: 'gym-tracker-narzgul',
    storageBucket: 'gym-tracker-narzgul.appspot.com',
    androidClientId: '736102478882-r5io3fobdj41ts4nenehrs376ocmb9hp.apps.googleusercontent.com',
    iosBundleId: 'com.github.narzgul.gymTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDRTfd8bpIuOjwwHsTAtL_xksBdNGWcCpg',
    appId: '1:736102478882:web:a91bf2336f9e288309c67b',
    messagingSenderId: '736102478882',
    projectId: 'gym-tracker-narzgul',
    authDomain: 'gym-tracker-narzgul.firebaseapp.com',
    storageBucket: 'gym-tracker-narzgul.appspot.com',
    measurementId: 'G-GK8400WC1J',
  );

}