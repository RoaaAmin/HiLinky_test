import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../reply/replyScreen.dart';

//
class CommentPage extends StatefulWidget {
  final String PostId; // Pass the postId when navigating to this page

  CommentPage({required this.PostId});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  var UserProfileImage;

  void getLinks() async {
    await FirebaseFirestore.instance
        .collection('Cards')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (value) {
        setState((){
          UserProfileImage = value.data()!['ImageURL'];
          print(UserProfileImage);
        });
      },
    );
  }

  var FirstName = '';
  var LastName = '';
  var Position = '';
  var CompanyName = '';
  var uniqueUserName = '';

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
    getLinks();
    getCardInfo();
    super.initState();
  }

  final TextEditingController _commentController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _commentsCollection => _firestore
      .collection('Comments')
      .doc(widget.PostId)
      .collection('comments');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment Section'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _commentsCollection.orderBy('date').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator(); // Show loading indicator while fetching data
                }
                final comments = snapshot.data!.docs
                    .map((doc) => Comment.fromSnapshot(doc))
                    .toList();
                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Container(
                      // color: Color.fromRGBO(211, 237, 250, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                    maxRadius: 20,
                                    backgroundImage:
                                        NetworkImage(UserProfileImage ?? "")),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  //  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$FirstName $LastName",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      "$CompanyName $Position",
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  DateFormat('MMM dd, yyyy - hh:mm a')
                                      .format(comment.date),
                                  style: TextStyle(fontSize: 12),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    deleteComment(comment.id);
                                  },
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                comment.text,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => ReplyScreen(
                                              commentId: comment.id,
                                              postId: widget.PostId,
                                            ),
                                          ));
                                        },
                                        child: Text(
                                          "Replay",
                                          style: TextStyle(color: Colors.blue),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          // context.pushPage( home2());
                                        },
                                        child: Text(
                                          "View All Replies",
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.blue),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                    // return Column(
                    //   children: [
                    //     ListTile(
                    //       title: Text(comment.text),
                    //       subtitle: Text(
                    //         DateFormat('MMM dd, yyyy - hh:mm a').format(comment.date),
                    //       ),
                    //       trailing: IconButton(
                    //         icon: Icon(Icons.delete),
                    //         onPressed: () {
                    //           deleteComment(comment.id);
                    //         },
                    //       ),
                    //     ),
                    //     // Add a "Reply" button under each comment
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         // Navigate to the ReplyScreen with the comment.id
                    //         Navigator.of(context).push(MaterialPageRoute(
                    //           builder: (context) => ReplyScreen(
                    //             commentId: comment.id,
                    //             postId: widget.PostId, // Pass the postId to the ReplyScreen
                    //           ),
                    //         ));
                    //       },
                    //       child: Text('Reply'),
                    //     ),
                    //   ],
                    // );
                  },
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    addComment();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addComment() async {
    String newCommentText = _commentController.text.trim();
    if (newCommentText.isNotEmpty) {
      await _commentsCollection.add({
        'text': newCommentText,
        "PostedByUID": FirebaseAuth.instance.currentUser!.uid,
        'date': Timestamp.now(),
        'replies': [],
      });
      _commentController.clear();
    }
  }

  void deleteComment(String commentId) async {
    await _commentsCollection.doc(commentId).delete();
  }
}

class Comment {
  final String id;
  final String text;
  final DateTime date;
  final String PostId; // Add postId
  final List<Reply> replies;

  Comment({
    required this.id,
    required this.text,
    required this.date,
    required this.PostId,
    required this.replies,
  });

  factory Comment.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final replyDocs = data['replies'] as List<dynamic>;
    final List<Reply> replies =
        replyDocs.map((replyData) => Reply.fromSnapshot(replyData)).toList();
    return Comment(
      id: snapshot.id,
      text: data['text'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      PostId: data['PostId'] ?? '',
      // Get postId from Firestore
      replies: replies,
    );
  }
}
