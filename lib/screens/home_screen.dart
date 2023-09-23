import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilinky_test/components/context.dart';
import 'package:hilinky_test/screens/create_card/create_card.dart';
import 'package:hilinky_test/screens/create_post.dart';
import 'package:hilinky_test/subscription/my_subscription.dart';
import 'package:line_icons/line_icons.dart';

import '../API/notifications.dart';
import '../auth.dart';
import 'login_screen.dart';
import 'myProfile/myProfile.dart';
import 'my_card/myCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _currentIndex = 0;
  Widget currentScreen = const HomeScreen();
  late DocumentSnapshot<Map<String, dynamic>> userData;
  late QuerySnapshot<Map<String, dynamic>> postsDocs;

  var userId = FirebaseAuth.instance.currentUser!.uid;

  var name = '';
  Map<String, dynamic> Links = {};

  void getuser() async {
    var user =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    setState(() {
      name = user.data()!['sUserName'];
    });
  }

  @override
  void initState() {
    super.initState();
    getLinks();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // flexibleSpace: ,

        elevation: 3,
        leading: const CircleAvatar(
          minRadius: 1,
          backgroundColor: Color.fromARGB(255, 128, 148, 158),
        ),
        title: Image.asset(
          "assets/images/HilinkyLogo.png",
          scale: 20,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              LineIcons.bell,
              size: 30.0,
              color: Colors.black,
            ),
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
          //   crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Start your journey by creating your card",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context.pushPage(CreateCard());
              },
              style: ElevatedButton.styleFrom(
                // shape: const (),
                padding: const EdgeInsets.all(5),
                backgroundColor: const Color.fromARGB(255, 2, 84, 86),
                fixedSize: const Size(178, 59),
                elevation: 0,
              ),
              //  style: const ButtonStyle( B elevation: 0.2, ),
              child: const Text(
                'Create Card',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        onPressed: () {
          context.pushPage(CreatePost());
        },
        child: const Icon(Icons.add),
      ),

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       const Text(
      //         "Start your journey by creating your card",
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //       ),
      //       const SizedBox(height: 20), // Add some spacing
      //       ElevatedButton(
      //         onPressed: () {
      //           Navigator.of(context).pushReplacement(CupertinoPageRoute(
      //             builder: (BuildContext context) => CreateCard(),
      //           ));
      //         },
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.amber.shade800,
      //         ),
      //         child: const Text("Create Card"),
      //       ),
      //     ],
      //   ),
      // ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 50.0),
              child: Text(
                " Hi $name\n${FirebaseAuth.instance.currentUser!.email!}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(
                LineIcons.home,
                color: Colors.amber,
              ),
              title: const Text(
                "Home",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    builder: (BuildContext context) => const Auth()));
              },
            ),
            ListTile(
              leading: const Icon(
                LineIcons.edit,
                color: Colors.amber,
              ),
              title: const Text(
                "Posts",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => Feeds()));
                Navigator.pushNamed(context, 'feeds');
              },
            ),
            ListTile(
                leading: const Icon(
                  LineIcons.cogs,
                  color: Colors.amber,
                ),
                title: const Text(
                  'My card',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (BuildContext context) => MyCard()));
                }),
            ListTile(
                leading: const Icon(
                  LineIcons.cogs,
                  color: Colors.amber,
                ),
                title: const Text(
                  'My profile',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) => MyProfile(
                        Links: Links,
                      ),
                    ),
                  );
                }),
            ListTile(
                leading: const Icon(
                  Icons.subscriptions_sharp,
                  color: Colors.amber,
                ),
                title: const Text(
                  'My Subscription',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                        builder: (BuildContext context) => my_subscription()),
                  );
                }),
            ListTile(
                leading: const Icon(LineIcons.user, color: Colors.amber),
                title: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  print('Signing Out User.....');
                  try {
                    await FirebaseAuth.instance.signOut().then((metaData) {
                      print('SignOut Completed...');
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                    });
                  } catch (e) {
                    print('An error occur during signing user out.');
                  }
                }),
          ],
        ),
      ),

      // /////////////////////
      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   notchMargin: 8,
      //   child: SizedBox(
      //     height: 60,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: <Widget>[
      //         Row(
      //           children: <Widget>[
      //             MaterialButton(
      //               minWidth: 40,
      //               onPressed: () {
      //                 setState(() {
      //                   currentScreen = const HomeScreen();
      //                   _currentIndex = 0;
      //                 });
      //               },
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: <Widget>[
      //                   Icon(
      //                     LineIcons.home,
      //                     color: _currentIndex == 0
      //                         ? Colors.amber[500]
      //                         : Colors.grey,
      //                   ),
      //                   Text(
      //                     'Home',
      //                     style: TextStyle(
      //                       color: _currentIndex == 0
      //                           ? Colors.amber[500]
      //                           : Colors.grey,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             MaterialButton(
      //               minWidth: 75,
      //               onPressed: () {
      //                 Navigator.pushNamed(context, 'SearchPagePremiumScreen');
      //                 setState(() {
      //                   _currentIndex = 1;
      //                 });
      //               },
      //               padding: const EdgeInsets.only(left: 25, right: 0),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: <Widget>[
      //                   Icon(
      //                     LineIcons.search,
      //                     color: _currentIndex == 1
      //                         ? Colors.amber[500]
      //                         : Colors.grey,
      //                   ),
      //                   Text(
      //                     'Search',
      //                     style: TextStyle(
      //                       color: _currentIndex == 1
      //                           ? Colors.amber[500]
      //                           : Colors.grey,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             MaterialButton(
      //               minWidth: 1,
      //               onPressed: () {
      //                 Navigator.pushNamed(context, 'QRScannerPage');
      //                 setState(() {
      //                   _currentIndex = 2;
      //                 });
      //                 // Navigator.pushNamed(context, 'createPostViewRoute');
      //               },
      //               padding: const EdgeInsets.only(left: 50, right: 0),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: <Widget>[
      //                   Icon(
      //                     LineIcons.qrcode,
      //                     color: _currentIndex == 2
      //                         ? Colors.amber[500]
      //                         : Colors.grey,
      //                   ),
      //                   Text(
      //                     'Scan',
      //                     style: TextStyle(
      //                       color: _currentIndex == 2
      //                           ? Colors.amber[500]
      //                           : Colors.grey,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),

// ///////////

//       //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.amber.shade800,
//           onPressed: () {
//             Navigator.of(context).push(CupertinoPageRoute(
//                 builder: (BuildContext context) => CreatePost()));
//           }

//           //  },
//           ),
    );
  }

  void getLinks() async {
    await FirebaseFirestore.instance
        .collection('Cards')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (value) {
        Links.clear();
        Links = value.data()!['Links'];
        Links.removeWhere((key, value) => value == '');
      },
    );
  }
}
