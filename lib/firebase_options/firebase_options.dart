
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig{
  static FirebaseOptions get platformOptions{
    if(Platform.isIOS) {
      //ios & mac
      return const FirebaseOptions(
        appId: '1:130850188106:ios:05b1c4c3ba8d019bc0efb3',
        apiKey: 'AIzaSyCNxw5l5UWUxb0WaqaURQgGHvfLYkxoUWs',
        projectId: 'hilinky-test',
        messagingSenderId:'130850188106',
        iosBundleId: 'com.example.hilinkyTest',
        storageBucket: "hilinky-test.appspot.com",
      );
    }else if(Platform.isAndroid) {
      //android
      return const FirebaseOptions(
        appId: '1:130850188106:android:3183cfc967eb9b89c0efb3',
        apiKey: 'AIzaSyD8dVA2QCJypnZuT5UdcxcjMxZUTCF6tJk',
        projectId: 'hilinky-test',
        messagingSenderId: '130850188106',
        storageBucket: "hilinky-test.appspot.com",
      );
    } else{
      //web
      return const FirebaseOptions(
          apiKey: "AIzaSyB7j2HFNE4pU13o9Y0pCgCEtAMvm-2dqzc",
          authDomain: "hilinky-test.firebaseapp.com",
          projectId: "hilinky-test",
          storageBucket: "hilinky-test.appspot.com",
          messagingSenderId: "130850188106",
          appId: "1:130850188106:web:c94f56d874b9ca81c0efb3",
          measurementId: "G-33N6M2M5S9"
      );
    }
  }

}
