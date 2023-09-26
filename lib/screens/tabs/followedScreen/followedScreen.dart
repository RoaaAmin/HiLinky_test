import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../cardSearchDetails/CardDetailsData.dart';

class FollowedScreen extends StatefulWidget {
  final List<CardDetailsData> savedCards;
  final String? postedByUID;

  FollowedScreen({required this.savedCards, this.postedByUID});

  @override
  State<FollowedScreen> createState() => _FollowedScreenState();
}

class _FollowedScreenState extends State<FollowedScreen> {
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
  @override
  void initState() {
    getLinks();
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
        title: Text('Followed Cards'),
      ),
      body: ListView.builder(
        itemCount: widget.savedCards.length,
        itemBuilder: (context, index) {
          final cardData = widget.savedCards[index];
          return Card(
            // Customize card UI here
            child: Column(
              children: <Widget>[
                // Display card details using cardData
                Text('First Name: ${cardData.firstName}'),
                Text('Last Name: ${cardData.lastName}'),
                Text('Position: ${cardData.position}'),
                Text('Company Name: ${cardData.companyName}'),
                // Add social media icons
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
              ],
            ),
          );
        },
      ),
    );
  }

}
Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
