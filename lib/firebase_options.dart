import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCkAtq6G-2wNNcyguA7TNH7MG9yu_pZuHM',
    appId: '1:1013324345184:android:cbe4dfcc23cb6789e8b805',
    messagingSenderId: '1013324345184',
    projectId: 'spalhe-app-prod',
    storageBucket: 'spalhe-app-prod.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDGWWTDQOxBrPOuFds7DhHfda9azI-cOjI',
    appId: '1:1013324345184:ios:93ed2557b7b1fd77e8b805',
    messagingSenderId: '1013324345184',
    projectId: 'spalhe-app-prod',
    storageBucket: 'spalhe-app-prod.appspot.com',
    iosClientId:
        '1013324345184-heod7ohcu8peurlj9864ct8v4fkpi4up.apps.googleusercontent.com',
    iosBundleId: 'com.spalhe',
  );
}
