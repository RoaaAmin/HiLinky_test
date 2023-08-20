import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';


class SendNotification {

  final String title;
  final String body;
  SendNotification({required this.body, required this.title});
  /// to print Token and engage test
  /*
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token:$fCMToken");
  }

   */


  Future<bool> sendToSpecificUser(BuildContext context, String sUserID) async {
    bool isNotificationSent = false;
    try {
      final userData = await FirebaseFirestore.instance.collection('Users').doc(sUserID).get();
      if (userData.data()?['sUserNotificationToken'] != null) {
        isNotificationSent = await sendNotification(context, userData.data()?['sUserNotificationToken']);
        await FirebaseFirestore.instance.collection('Notifications').add({
          'ToUID': sUserID.toString(),
          'Title': title.toString(),
          'Body': body.toString(),
          'TimeSent': DateTime.now(),
        });
      }
    } catch (e) {
      isNotificationSent = false;
      print('exception $e');
    }
    return isNotificationSent;
  }


  Future<bool> sendToAllUsers(BuildContext context) async {
    bool isNotificationSent = false;
    try {
      final users = await FirebaseFirestore.instance.collection('Users').get();
      if (users != null) {
        for (int i = 0; i < users.docs.length; i++) {
          final value = await sendNotification(context, users.docs[i].data()['sUserNotificationToken']);
          isNotificationSent = value;
          await FirebaseFirestore.instance.collection('Notifications').add({
            'ToUID': users.docs[i].id.toString(),
            'Title': title.toString(),
            'Body': body.toString(),
            'TimeSent': DateTime.now(),
          });
        }
      }
    } catch (e) {
      isNotificationSent = false;
      print('exception $e');
    }
    return isNotificationSent;
  }

  Future<bool> sendNotification(BuildContext context, String tokenNo) async {
    bool isNotificationSent = false;
    final data = {
      "notification": {
        "body": "$body",
        "title": "$title",
        "sound": "default",
        "badge": "1",
      },
      "priority": "high",
      "to": "$tokenNo"
    };
    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=cmQUwZcwQV-rl4lOTWTKB4:APA91bH2b65VUqMyq6w4FVp06tKBwRV81ytdhxFBlPG8t0FQM-Uv5oy_g9Bc9GMlOuBKbbpoBO9pVYl53vCC82D4uSYmAdSTqLDYLpVvK5AZ98y_Jm4mHox21ueTrUrsO94PeU3TFumg'

    };
    BaseOptions options = BaseOptions(
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 3000),
      headers: headers,
    );
    try {
      final response = await Dio(options).post('https://fcm.googleapis.com/fcm/send', data: data);
      if (response.statusCode == 200) {
        isNotificationSent = true;
      } else {
        isNotificationSent = false;
        // on failure do sth
      }
    } catch (e) {
      isNotificationSent = false;
      print('exception $e');
    }
    return isNotificationSent;
  }
}
