
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
      );
    }else{
      //android
      return const FirebaseOptions(
        appId: '1:130850188106:android:3183cfc967eb9b89c0efb3',
        apiKey: 'AIzaSyD8dVA2QCJypnZuT5UdcxcjMxZUTCF6tJk',
        projectId:'hilinky-test',
        messagingSenderId: '130850188106',



      );
    }
  }

}
