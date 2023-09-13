import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hilinky_test/screens/create_card/create_card.dart';
import 'package:hilinky_test/screens/profilePage/ProfilePage.dart';

import 'package:line_icons/line_icons.dart';


import '../API/notifications.dart';
import '../auth.dart';
import 'create_post.dart';
import 'login_screen.dart';
import 'myProfile/myProfile.dart';
import 'my_card/myCard.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;  Widget currentScreen = HomeScreen();
  late DocumentSnapshot<Map<String, dynamic>> userData;
  late QuerySnapshot<Map<String, dynamic>> postsDocs;


  var userId = FirebaseAuth.instance.currentUser!.uid;

  var name = '';


  void getuser() async{
    var user = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    setState(() {
      name = user.data()!['sUserName'];
    });
  }



  @override
  void initState() {
    super.initState();

    getuser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(LineIcons.bell, size: 30.0, color: Colors.black,),
            onPressed: () {
              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                builder: (BuildContext context) => NotificationsPage(),
              ));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Start your journey by creating your card",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // Add some spacing
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    builder: (BuildContext context) => CreateCard(),));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade800,
              ),
              child: Text("Create Card"),

            ),
          ],
        ),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 50.0),
              child: Text(
                " Hi " + name + "\n"+ FirebaseAuth.instance.currentUser!.email!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(
                LineIcons.home,
                color: Colors.amber,
              ),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => Auth()));
              },
            ),
            ListTile(
              leading: Icon(
                LineIcons.edit,
                color: Colors.amber,
              ),
              title: Text(
                "Posts",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => Feeds()));
                Navigator.pushNamed(context,'feeds');
              },
            ),
            ListTile(
                leading: Icon(
                  LineIcons.cogs,
                  color: Colors.amber,
                ),
                title: Text(
                  'My card',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => MyCard()));
                }),

            ListTile(
                leading: Icon(
                  LineIcons.cogs,
                  color: Colors.amber,
                ),
                title: Text(
                  'My profile',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => MyProfile()));
                }),
            ListTile(

                leading: Icon(LineIcons.user, color: Colors.amber),
                title: Text(
                  "Logout",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  print('Signing Out User.....');
                  try {
                    await FirebaseAuth.instance.signOut().then((metaData) {
                      print('SignOut Completed...');
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => LoginScreen()));
                    });
                  } catch (e) {
                    print('An error occur during signing user out.');
                  }
                }),
          ],

        ),
      ),

      /////////////////////
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        _currentIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          LineIcons.home,
                          color: _currentIndex == 0 ? Colors.amber[500] : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: _currentIndex == 0 ? Colors.amber[500] : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 75,
                    onPressed: () {
                      Navigator.pushNamed(context, 'SearchPagePremiumScreen');
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    padding: EdgeInsets.only(left: 25, right: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          LineIcons.search,
                          color: _currentIndex == 1 ? Colors.amber[500] : Colors.grey,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                            color: _currentIndex == 1 ? Colors.amber[500] : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 1,
                    onPressed: () {
                      Navigator.pushNamed(context, 'QRScannerPage');
                      setState(() {
                        _currentIndex = 2;
                      });
                      // Navigator.pushNamed(context, 'createPostViewRoute');
                    },
                    padding: EdgeInsets.only(left: 50, right: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          LineIcons.qrcode,
                          color: _currentIndex == 2 ? Colors.amber[500] : Colors.grey,
                        ),
                        Text(
                          'Scan',
                          style: TextStyle(
                            color: _currentIndex == 2 ? Colors.amber[500] : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

///////////

      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber.shade800,
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (BuildContext context) => CreatePost()));
          }

        //  },
      ),

    );

  }

}
