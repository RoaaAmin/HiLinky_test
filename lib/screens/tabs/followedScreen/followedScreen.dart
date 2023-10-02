import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hilinky_test/screens/profilePage/ProfilePage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../cardSearchDetails/cardDetails.dart';

class FollowedScreen extends StatefulWidget {
  String? postedByUID;

  @override
  State<FollowedScreen> createState() => _FollowedScreenState();
}

class _FollowedScreenState extends State<FollowedScreen> {
  List<DocumentSnapshot<Map<String, dynamic>>> cardsDocs = [];
  bool myCardFetched = false;

  var following = [];

  Future getFollowing() async {
    print('get foloooooowing');
    final id = await FirebaseAuth.instance.currentUser!.uid;
    var user =
        await FirebaseFirestore.instance.collection('Users').doc(id).get();
    setState(() {
      following = user.data()!['followedCards'];
    });
    print('-----------------------------------------------------------');
    print(following.length);
    getId();
    await getLinks();
    await getMyCards(following);
  }

  Map<String, dynamic> Links = {};

  getLinks() async {
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

  getMyCards(data) async {
    print('card is commmmmming');
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if(following.isNotEmpty){
        for (var i = 0; i < following.length; i++) {

          await FirebaseFirestore.instance
              .collection('Cards')
              .where('PostedByUID', isEqualTo: data[i])
              .get()
              .then((value) async {
            if (value.docs.isNotEmpty) {
              print('theeeeeeeeen');
              setState(() {
                cardsDocs = cardsDocs + value.docs.toList();
                myCardFetched = true;
              });
              cardsDocs.sort((a, b) =>
                  b.data()!['TimeStamp'].compareTo(a.data()!['TimeStamp']));
            }
          });
        }
      }

    }
  }

  String cardId = '';

  void getId() async {
    if(following.isNotEmpty){
      for (var i = 0; i < following.length; i++) {
        await FirebaseFirestore.instance
            .collection('Cards')
            .doc(following[i])
            .get()
            .then((value) {
          setState(() {
            cardId = value.data()!['cardId'];
            widget.postedByUID = cardId;
          });
        });
      }
    }

  }

  @override
  void initState() {
    getFollowing();
    super.initState();
  }

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

    final deviceWidth = MediaQuery.of(context).size.width;
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Color(0xff390B33),
      overlayOpacity: 0.80,
      overlayWidget: Center(
        child: SizedBox(
          height: 125,
          child: LoadingIndicator(
            indicatorType: Indicator.ballPulse,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: cardsDocs.isEmpty
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            cardsDocs.isEmpty
                ? Center(child: Text('you haven\'t save any card'))
                : Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10, top: 10, bottom: 75),
                      itemCount: cardsDocs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () async {
                            print(
                                'FLOWLIST ID -> ${cardsDocs[i].data()!['PostedByUID']}');
                            print('FLOWLIST CardID -> ${cardsDocs[i].id}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardDetails(
                                  postedByUID:
                                      cardsDocs[i].data()!['PostedByUID'],
                                ),

                                // ProfilePage(postedByUID: cardsDocs[i].data()!['PostedByUID'],
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                elevation: 3,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(40.0),
                                      child: Card(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.all(Radius.circular(10)),
                                        ),
                                        elevation: 3,
                                        //color: const Color.fromARGB(255, 255, 255, 255),
                                        child: Stack(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            Image(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/images/bigbig.png"),
                                              //    height: 190,
                                              // width: context.width,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CircleAvatar(
                                                    maxRadius: 30,
                                                    backgroundImage: NetworkImage(
                                                        cardsDocs[i]
                                                            .data()!['ImageURL']),
                                                  ),
                                                  const SizedBox(
                                                    width: 40,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(cardsDocs[i]
                                                              .data()!['FirstName']),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(cardsDocs[i]
                                                              .data()!['LastName']),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(cardsDocs[i]
                                                              .data()!['Position']),
                                                          Text('  -  '),
                                                          Text(cardsDocs[i].data()![
                                                                  'CompanyName'] ??
                                                              ''),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SizedBox(
                                                            height: 40,
                                                            child: ListView.builder(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              shrinkWrap: true,
                                                              itemCount: Links.length,
                                                              itemBuilder:
                                                                  (context, index) {
                                                                return Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        gradient: LinearGradient(
                                                                            colors: [
                                                                              Colors
                                                                                  .orange,
                                                                              Colors
                                                                                  .deepOrange
                                                                            ],
                                                                            end: Alignment
                                                                                .topLeft,
                                                                            begin: Alignment
                                                                                .bottomRight),
                                                                      ),
                                                                      width: 35,
                                                                      height: 35,
                                                                      child: Center(
                                                                        child:
                                                                            IconButton(
                                                                          isSelected:
                                                                              true,
                                                                          iconSize:
                                                                              20,
                                                                          onPressed:
                                                                              () {
                                                                            final Uri
                                                                                url =
                                                                                Uri.parse(
                                                                                    values[index]);
                                                                            _launchUrl(
                                                                                url);
                                                                          },
                                                                          icon: Icon(
                                                                              l[keys[index]]!
                                                                                  .icon),
                                                                          color: Colors
                                                                              .white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 15,
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
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
                                            following.contains(
                                                cardsDocs[i].data()!['PostedByUID'])
                                                ? ElevatedButton(
                                              onPressed: () => unFollow(i),
                                              child: const Text('already saved'),
                                            )
                                                : ElevatedButton(
                                              onPressed: () => follow(i),
                                              child: Text('Save'),
                                            ),
                                            SizedBox(width: 10),
                                            // Add some spacing between the buttons
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ProfilePage(
                                                        postedByUID: cardsDocs[i]
                                                            .data()!['PostedByUID'],
                                                      ),
                                                    ));
                                              },
                                              child: Text('View Profile'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),

                            ],
                          ),
                        );
                      },
                    ),
                ),
          ],
        ),
      ),
    );
  }

  void follow(i) async {
    following.add(cardsDocs[i].data()!['PostedByUID']);
    print('add to local');
    var fire = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    setState(() {
      fire.update({'followedCards': following});

    });
  }

  void unFollow(i) async {
    following.remove(cardsDocs[i].data()!['PostedByUID']);

    var fire = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    setState(() {
      fire.update({'followedCards': following});
      
    });
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
