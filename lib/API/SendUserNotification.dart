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


  Future<bool> sendToSpecificUser(BuildContext context, String userID) async {
    bool isNotificationSent = false;
    try {
      final userData = await FirebaseFirestore.instance.collection('Users').doc(userID).get();
      if (userData.data()?['FBNotificationToken'] != null) {
        isNotificationSent = await sendNotification(context, userData.data()?['FBNotificationToken']);
        await FirebaseFirestore.instance.collection('Notifications').add({
          'ToUID': userID.toString(),
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
          final value = await sendNotification(context, users.docs[i].data()['FBNotificationToken']);
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


/*class SendNotification {
  final String title;
  final String body;
  SendNotification({required this.body,required this.title});

  Future <bool> sendToSpecificUser(BuildContext context,String UserID)async{
    bool isNotificationSent;
    await FirebaseFirestore.instance.collection('Users').doc(UserID).get().then((userData) async{
      if(userData.data()?['FBNotificationToken']!=null){
        await sendNotification(context,userData.data()?['FBNotificationToken']).then((value) async{
          isNotificationSent=value;
          await FirebaseFirestore.instance.collection('Notifications').add({
            'ToUID':UserID.toString(),
            'Title':title.toString(),
            'Body':body.toString(),
            'TimeSent':DateTime.now(),
          });
        });
      }
    });
    return isNotificationSent;
  }

  Future <bool> sendToAllAuthorities(BuildContext context)async{
    bool isNotificationSent;
    await FirebaseFirestore.instance.collection('Users')
        .where('UserType',isEqualTo: 'Authority')
        .get().then((authoritiesDocs) async{
      if(authoritiesDocs!=null){
        for(int i=0;i<authoritiesDocs.docs.length;i++){
          await sendNotification(context,authoritiesDocs.docs[i].data()['FBNotificationToken']).then((value) async{
            isNotificationSent=value;
            await FirebaseFirestore.instance.collection('Notifications').add({
              'ToUID':authoritiesDocs.docs[i].id.toString(),
              'Title':title.toString(),
              'Body':body.toString(),
              'TimeSent':DateTime.now(),
            });
          });
        }
      }
    });
    return isNotificationSent;
  }

  Future <bool> sendToAllUsers(BuildContext context)async{
    bool isNotificationSent;
    await FirebaseFirestore.instance.collection('Users')
        .get().then((users) async{
      if(users!=null){
        for(int i=0;i<users.docs.length;i++){
          await sendNotification(context,users.docs[i].data()['FBNotificationToken']).then((value) async{
            isNotificationSent=value;
            await FirebaseFirestore.instance.collection('Notifications').add({
              'ToUID':users.docs[i].id.toString(),
              'Title':title.toString(),
              'Body':body.toString(),
              'TimeSent':DateTime.now(),
            });
          });
        }

      }
    });
    return isNotificationSent;
  }

  Future<bool> sendNotification(BuildContext context,String tokenNo)async{
    bool isNotificationSent;
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
      'Authorization': 'key=AAAAooWYE7c:APA91bHL_A9lFl6L1Ad38NQ3gexgo1CSuXHCpcAGrcJD4ioxtoiyaIYYlAgujkctlFPzaVkV6ZDhSogSlVe1zIBz66N4PHMT2JBfNFjTukchMdXm3FtapI_02D14ez__1PkDExl1UF3Y'
    };
    BaseOptions options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
    );
    try {
      final response = await Dio(options).post('https://fcm.googleapis.com/fcm/send', data: data);
      if (response.statusCode == 200) {
        isNotificationSent=true;
      } else {
        isNotificationSent=false;
        // on failure do sth
      }
    }
    catch(e){
      isNotificationSent=false;
      print('exception $e');
    }
    return isNotificationSent;
  }
}

 */