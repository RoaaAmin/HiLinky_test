import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _commentController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _commentsCollection = FirebaseFirestore.instance.collection('comments');

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
              stream: _commentsCollection.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator(); // Show loading indicator while fetching data
                }

                final comments = snapshot.data!.docs.map((doc) => Comment.fromSnapshot(doc)).toList();

                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return ListTile(
                      title: Text(comment.text),
                      subtitle: Text(
                        DateFormat('MMM dd, yyyy - hh:mm a').format(comment.date),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteComment(comment.id);
                        },
                      ),
                    );
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
        'date': Timestamp.now(),
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

  Comment({
    required this.id,
    required this.text,
    required this.date,
  });

  factory Comment.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Comment(
      id: snapshot.id,
      text: data['text'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
    );
  }
}
