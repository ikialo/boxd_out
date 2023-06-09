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
    apiKey: 'AIzaSyAterdwg-gohpUNFsW9QfGD6KZR9GCxaPA',
    appId: '1:1008421143476:web:b8417476dedc62a482a8e1',
    messagingSenderId: '1008421143476',
    projectId: 'takabox-1ecac',
    authDomain: 'takabox-1ecac.firebaseapp.com',
    storageBucket: 'takabox-1ecac.appspot.com',
    measurementId: 'G-BY453ML0NZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBKYTflYOXx8NRjtO_jcSs80OIcHcT_JNY',
    appId: '1:1008421143476:android:60e31a1168f21be582a8e1',
    messagingSenderId: '1008421143476',
    projectId: 'takabox-1ecac',
    storageBucket: 'takabox-1ecac.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmhw_aRsNGJ4Y4KIKw13SLJGqthUvNgw4',
    appId: '1:1008421143476:ios:bb40b407d8dd77eb82a8e1',
    messagingSenderId: '1008421143476',
    projectId: 'takabox-1ecac',
    storageBucket: 'takabox-1ecac.appspot.com',
    iosClientId: '1008421143476-1ri0jgkgbutsjfi0hck8h23ino5rnmm1.apps.googleusercontent.com',
    iosBundleId: 'com.example.takaBox',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmhw_aRsNGJ4Y4KIKw13SLJGqthUvNgw4',
    appId: '1:1008421143476:ios:bb40b407d8dd77eb82a8e1',
    messagingSenderId: '1008421143476',
    projectId: 'takabox-1ecac',
    storageBucket: 'takabox-1ecac.appspot.com',
    iosClientId: '1008421143476-1ri0jgkgbutsjfi0hck8h23ino5rnmm1.apps.googleusercontent.com',
    iosBundleId: 'com.example.takaBox',
  );
}
