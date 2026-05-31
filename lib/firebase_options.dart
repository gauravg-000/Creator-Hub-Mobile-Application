import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBrFSe6vFkauEa60wD2JziwyF2L-aY5-rU',
    appId: '1:149781281634:web:fbe85f4b3d8191ec2aca3b',
    messagingSenderId: '149781281634',
    projectId: 'techworldassignment',
    authDomain: 'techworldassignment.firebaseapp.com',
    storageBucket: 'techworldassignment.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDLJeN2BGwjO3R1HVWiF43FNRr8e18yKO0',
    appId: '1:149781281634:android:0a5c5fe1fd7b6e122aca3b',
    messagingSenderId: '149781281634',
    projectId: 'techworldassignment',
    storageBucket: 'techworldassignment.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBF39KZldC34qHHrVntzcoVZBlvUpZ-8KE',
    appId: '1:149781281634:ios:91aeefa351861baf2aca3b',
    messagingSenderId: '149781281634',
    projectId: 'techworldassignment',
    storageBucket: 'techworldassignment.firebasestorage.app',
    iosBundleId: 'com.example.techworldAssignment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBF39KZldC34qHHrVntzcoVZBlvUpZ-8KE',
    appId: '1:149781281634:ios:91aeefa351861baf2aca3b',
    messagingSenderId: '149781281634',
    projectId: 'techworldassignment',
    storageBucket: 'techworldassignment.firebasestorage.app',
    iosBundleId: 'com.example.techworldAssignment',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBrFSe6vFkauEa60wD2JziwyF2L-aY5-rU',
    appId: '1:149781281634:web:f524606c916901c42aca3b',
    messagingSenderId: '149781281634',
    projectId: 'techworldassignment',
    authDomain: 'techworldassignment.firebaseapp.com',
    storageBucket: 'techworldassignment.firebasestorage.app',
  );

}