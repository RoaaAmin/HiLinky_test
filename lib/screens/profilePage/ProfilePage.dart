import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../feeds/Comment/CommentPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
  getUserData() async {
    await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      setState(() {
        userData = value;
        getPosts();
      });
    });
  }


  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
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
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),

                          ),
                        ),
                       SizedBox(height: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                             Text(
                              'Your Text', // Replace with the user's name
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                              },
                              child: Text('Button 1'),
                            ),

                          ],
                        ),
                        // Add social media icons here
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.facebook),
                              onPressed: () {
                                // Handle Facebook icon press
                              },
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              flowList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget flowList(BuildContext context) {
    if (postsDocs != null) {
      if (postsDocs.length != 0) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 75),
          itemCount: postsDocs.length,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 110,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFF495592),
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: NetworkImage(
                                    postsDocs[i].data()!['ImageURL']),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Color(0xFF495592).withOpacity(0.9),
                    ),
                    Row(
                      children: [

                        Text(
                          '${postsDocs[i].data()!['Description']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),



                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommentPage()),
                                );
                              },
                              child: Icon(Icons.comment),
                            ),
                            IconButton(
                              icon: Icon(Icons.thumb_up),
                              onPressed: () {
                                // Handle like action
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {
                                // Handle share action
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return Center(
            child: CircularProgressIndicator(backgroundColor: Colors.transparent));
      }
    } else {
      return Center(
          child: CircularProgressIndicator(backgroundColor: Colors.transparent));
    }
  }
}
