import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Comment/CommentPage.dart';
import '../../feeds/LikeButton.dart';

class post_design extends StatefulWidget {
  final String? postedByUID;
  const post_design(
      {super.key,
      required this.profileImage,
      this.postedByUID, required this.name, required this.username, required this.image});

  final String name, username, profileImage, image;

  @override
  State<post_design> createState() => _post_designState();
}

class _post_designState extends State<post_design> {
  List<DocumentSnapshot<Map<String, dynamic>>> postsDocs = [];
  bool postsFetched = false;
  DocumentSnapshot<Map<String, dynamic>>? userData;
  String? specifiedUserID;
  @override
  void initState() {
    super.initState();
    if (widget.postedByUID == '' || widget.postedByUID == null) {
      specifiedUserID = FirebaseAuth.instance.currentUser!.uid;
    } else {
      specifiedUserID = widget.postedByUID;
    }
    getUserData();
    getUserInfo();
  }
  getPosts() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('Posts')
         .where('PostedByUID', isEqualTo: specifiedUserID)
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
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(specifiedUserID)
        .get()
        .then((value) {
      setState(() {
        userData = value;
        getPosts();
      });
    });
  }
  var uniqueUserName = '';
  var sUserName = '';

  void getUserInfo() async {
    var user = await FirebaseFirestore.instance
        .collection('Users')
        .doc(specifiedUserID)
        .get();
    if (user.exists) {
      print("User Data: ${user.data()}");
      setState(() {
        uniqueUserName = user.data()!['uniqueUserName'];
        sUserName = user.data()! ['sUserName'];
      });
    } else {
      print("User data not found");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          flowList(context),
        ],
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
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(widget.profileImage),
                      ),
                      title: Text(
                        '$sUserName',
                        textAlign: TextAlign.start,
                      ),
                      subtitle: Text(
                        '@$uniqueUserName',
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Text(
                      '${postsDocs[i].data()!['Description']}',
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              postsDocs[i].data()!['ImageURL'],
                              height: 250,
                              width: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(height: 22,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LikeButton(
                          postId: postsDocs[i].data()!['PostId'],
                        ),
                        Text("       "),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommentPage(
                                      PostId:
                                      postsDocs[i].data()!['PostId'],
                                    )),
                              );
                            },
                            child: Icon(Icons.insert_comment_outlined)),
                        Text("  5676       "),
                        Icon(Icons.ios_share_rounded),
                        Text("  5676        "),
                      ],
                    ),
                    // Add your like, comment, and share buttons here if needed.
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return Center(
       //   child: CircularProgressIndicator(backgroundColor: Colors.transparent),
        );
      }
    } else {
      return Center(
      //  child: CircularProgressIndicator(backgroundColor: Colors.transparent),
      );
    }
  }

}
