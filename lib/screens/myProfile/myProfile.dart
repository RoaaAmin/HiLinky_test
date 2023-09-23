import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key, required this.Links}) : super(key: key);

  Map<String, dynamic> Links;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List<DocumentSnapshot<Map<String, dynamic>>> postsDocs = [];
  bool postsFetched = false;
  DocumentSnapshot<Map<String, dynamic>>? userData;

  getPosts() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUID = user.uid;

      await FirebaseFirestore.instance
          .collection('Posts')
          .where('PostedByUID', isEqualTo: userUID)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          setState(() {
            postsDocs = value.docs.toList();
            postsFetched = true;
          });
          postsDocs.sort((a, b) =>
              b.data()!['TimeStamp'].compareTo(a.data()!['TimeStamp']));
        }
      });
    }
  }

  var FirstName = '';
  var LastName = '';
  var Position = '';
  var CompanyName = '';
  var uniqueUserName = '';

  void getUserInfo() async {
    var user = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      uniqueUserName = user.data()!['uniqueUserName'];
    });
  }

  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        userData = value;
        getPosts();
      });
    });
  }

  void getCardInfo() async {
    await FirebaseFirestore.instance
        .collection('Cards')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (value) {
        setState(() {
          FirstName = value.data()!['FirstName'];
          LastName = value.data()!['LastName'];
          Position = value.data()!['Position'];
          CompanyName = value.data()!['CompanyName'];
        });
      },
    );
  }

  @override
  void initState() {
    getCardInfo();
    getUserData();
    getUserInfo();
    super.initState();
  }

//icons
  Map<String, FaIcon> l = {
    'linkedin': const FaIcon(FontAwesomeIcons.linkedin),
    'facebook': const FaIcon(FontAwesomeIcons.facebook),
    'twitter': const FaIcon(FontAwesomeIcons.twitter,color: Colors.white),
    'github': const FaIcon(FontAwesomeIcons.github),
    'instagram': const FaIcon(FontAwesomeIcons.instagram),
  };

  @override
  Widget build(BuildContext context) {
    List<String> keys = widget.Links.keys.toList();
    List<dynamic> values = widget.Links.values.toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xffF8F8F8),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 300.0,
                  ),
                  Container(
                    height: 150.0,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 130.0,
                            width: 130.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,

                              ///
                              // image: DecorationImage(
                              //   image: NetworkImage(staticUserProfileImage),
                              //   fit: BoxFit.cover,
                              //   alignment: Alignment.center,
                              // ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '$FirstName ' + '$LastName',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '$Position - ' + '$CompanyName',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print(widget.Links);
                                // Navigator.of(context).pushReplacement(
                                //     CupertinoPageRoute(
                                //         builder: (BuildContext context) =>
                                //             EditUserProfile()));
                              },
                              child: const Text('Edit my profile'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: widget.Links.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.orange,
                                                Colors.deepOrange
                                              ],
                                              end: Alignment.topLeft,
                                              begin: Alignment.bottomRight),
                                        ),
                                        width: 35,
                                        height: 35,
                                        child: Center(
                                          child: IconButton(
                                            isSelected: true,
                                            iconSize: 20,
                                            onPressed: () {
                                              final Uri url =
                                                  Uri.parse(values[index]);
                                              _launchUrl(url);
                                            },
                                            icon: Icon(l[keys[index]]!.icon),
                                              color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
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
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
