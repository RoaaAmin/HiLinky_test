import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../main.dart';
import '../screens/home_screen.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  QuerySnapshot<Map<String, dynamic>>? notifications;

  @override
  void initState() {
    getNotifications();
    super.initState();
  }

  getNotifications() async {
    Future.delayed(Duration(seconds: 1), () async {
      await FirebaseFirestore.instance
          .collection('Notifications')
          .where('ToUID', isEqualTo: sUserID)
          .get()
          .then((value) async {
        setState(() {
          notifications = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: notificationFlowList(context),
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                LineIcons.arrowLeft,
                size: 30.0,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                  builder: (BuildContext context) => HomeScreen(),
                ));
              },
            )));
  }

  Widget notificationFlowList(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    if (notifications != null) {
      return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 15.0, left: 15),
              child: Text(
                "Notifications",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 40.0,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: notifications?.docs.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Card(
                      elevation: 3,
                      color: i % 2 == 0
                          ? Colors.grey.shade50
                          : Colors.grey.shade100,
                      child: ListTile(
                        title: Text(
                          notifications?.docs[i].data()['Title'],
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 3),
                          child: Text(
                            notifications?.docs[i].data()['Body'],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(
          top: 70.0,
          left: 30.0,
          right: 30.0,
          bottom: 30.0,
        ),
        height: deviceHeight,
        width: deviceWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 1.0, bottom: 30.0),
              child: Text(
                "Notifications",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 40.0,
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/empty.png',
                  //"empty.png"
                ),
                Container(
                  padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                  child: Text(
                    "No New Notification",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0),
                  ),
                ),
                Text(
                  "You currently do not have any unread notifications.",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: Colors.grey.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ],
        ),
      );
    }
  }
}
