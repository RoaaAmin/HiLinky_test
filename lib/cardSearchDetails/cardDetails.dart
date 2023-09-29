import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hilinky_test/screens/tabs/followedScreen/followedScreen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/profilePage/ProfilePage.dart';
import 'CardDetailsData.dart';

class CardDetails extends StatefulWidget {
  final String? postedByUID;

  CardDetails({Key? key, this.postedByUID}) : super(key: key);

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> cardsDocs = [];
  List<DocumentSnapshot<Map<String, dynamic>>> postsDocs = [];
  List<CardDetailsData> savedCards = [];
  bool postsFetched = false;
  DocumentSnapshot<Map<String, dynamic>>? userData;
  String? specifiedUserID;
  Map<String, dynamic> Links = {};

  void getLinks() async {
    await FirebaseFirestore.instance
        .collection('Cards')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (value) {
        Links.clear();
        setState(() {
          Links = value.data()!['Links'];
        });
        Links.removeWhere((key, value) => value == '');
      },
    );
  }

// Function to save the current card
  void saveCard() {
    CardDetailsData cardData = CardDetailsData(
      firstName: FirstName,
      lastName: LastName,
      position: Position,
      companyName: CompanyName,
      links: Links,
    );

    setState(() {
      savedCards.add(cardData);
    });
  }

  String cardId = '';

  void getId() async {
    FirebaseFirestore.instance
        .collection('Cards')
        .doc(widget.postedByUID)
        .get()
        .then((value) {
      setState(() {
        cardId = value.data()!['cardId'];
      });
    });
  }

  @override
  void initState() {
    getId();
    getLinks();
    getFollowers();
    print('print widget postedByUID 11 : ${widget.postedByUID}'); // empty
    super.initState();
    if (widget.postedByUID == '' || widget.postedByUID == null) {
      specifiedUserID = FirebaseAuth.instance.currentUser!.uid;
    } else {
      specifiedUserID = widget.postedByUID;
    }
    getUserData();
    getCardInfo();
    getUserInfo();
    print('print widget postedByUID 22 : ${widget.postedByUID}'); // not empty
  }

  var following = [];

  void getFollowers() async {
    final id = await FirebaseAuth.instance.currentUser!.uid;
    var user =
        await FirebaseFirestore.instance.collection('Users').doc(id).get();

    following = user.data()!['following'];
  }

  void makeFollow() async {
    final id = await FirebaseAuth.instance.currentUser!.uid;
    var user =
        await FirebaseFirestore.instance.collection('Users').doc(id).get();
    following = user.data()!['following'];
    following.add(specifiedUserID);

    var fire = await FirebaseFirestore.instance.collection('Users').doc(id);

    setState(() {
      fire.update({'following': following});
    });
  }

  void unFollow() async {
    final id = await FirebaseAuth.instance.currentUser!.uid;
    var user =
        await FirebaseFirestore.instance.collection('Users').doc(id).get();
    following = user.data()!['following'];
    following.remove(specifiedUserID);

    var fire = await FirebaseFirestore.instance.collection('Users').doc(id);

    setState(() {
      fire.update({'following': following});
    });
  }

  var FirstName = '';
  var LastName = '';
  var Position = '';
  var CompanyName = '';
  var uniqueUserName = '';

  void getCardInfo() async {
    var user = await FirebaseFirestore.instance
        .collection('Cards')
        .doc(specifiedUserID)
        .get();
    if (user.exists) {
      print("Card Data: ${user.data()}");
      setState(() {
        FirstName = user.data()!['FirstName'];
        LastName = user.data()!['LastName'];
        Position = user.data()!['Position'];
        CompanyName = user.data()!['CompanyName'];
        Links = user.data()!['Links'];
      });
    } else {
      print("Card data not found");
    }
  }

  void getUserInfo() async {
    var user = await FirebaseFirestore.instance
        .collection('Users')
        .doc(specifiedUserID)
        .get();
    if (user.exists) {
      print("User Data: ${user.data()}");
      setState(() {
        uniqueUserName = user.data()!['uniqueUserName'];
      });
    } else {
      print("User data not found");
    }
  }

  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(specifiedUserID)
        .get()
        .then((value) {
      setState(() {
        userData = value;
      });
    });
  }

  //icons
  Map<String, FaIcon> l = {
    'linkedin': const FaIcon(FontAwesomeIcons.linkedin),
    'facebook': const FaIcon(FontAwesomeIcons.facebook),
    'twitter': const FaIcon(FontAwesomeIcons.twitter, color: Colors.white),
    'github': const FaIcon(FontAwesomeIcons.github),
    'instagram': const FaIcon(FontAwesomeIcons.instagram),
  };

  @override
  Widget build(BuildContext context) {
    List<String> keys = Links.keys.toList();
    List<dynamic> values = Links.values.toList();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Card(
                child: SingleChildScrollView(
                  child: Container(
                    color: Color(0xffF8F8F8),
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
// image: DecorationImage(
//   image: NetworkImage(UserProfileImage),
//   fit: BoxFit.cover,
//   alignment: Alignment.center,
// ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blueGrey
                                                .withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '$FirstName ' + '$LastName',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '$Position - ' + '$CompanyName',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
// Add social media icons here
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 40,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: Links.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.orange,
                                                          Colors.deepOrange
                                                        ],
                                                        end: Alignment.topLeft,
                                                        begin: Alignment
                                                            .bottomRight),
                                                  ),
                                                  width: 35,
                                                  height: 35,
                                                  child: Center(
                                                    child: IconButton(
                                                      isSelected: true,
                                                      iconSize: 20,
                                                      onPressed: () {
                                                        final Uri url =
                                                            Uri.parse(
                                                                values[index]);
                                                        _launchUrl(url);
                                                      },
                                                      icon: Icon(
                                                          l[keys[index]]!.icon),
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
                                  following.contains(specifiedUserID)
                                      ? ElevatedButton(
                                          onPressed: unFollow,
                                          child: const Text(
                                              'you already follow him'))
                                      : ElevatedButton(
                                          onPressed: makeFollow,
                                          child: const Text('follow'),
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
              ),
              SizedBox(
                width: 150,
                height: 150,
                child: QrImageView(
                  data: cardId,
                  version: QrVersions.auto,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      saveCard();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FollowedScreen(savedCards: savedCards),
                        ),
                      );
                    },
                    child: Text('Save'),
                  ),
                  SizedBox(width: 10), // Add some spacing between the buttons
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              postedByUID: widget.postedByUID,
                            ),
                          ));
                    },
                    child: Text('View Profile'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
