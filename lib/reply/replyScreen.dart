import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
//
class ReplyScreen extends StatefulWidget {
  final String commentId;
  final String postId;

  ReplyScreen({required this.commentId, required this.postId});

  @override
  _ReplyScreenState createState() => _ReplyScreenState();
}

class _ReplyScreenState extends State<ReplyScreen> {
  final TextEditingController _replyController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _repliesCollection => _firestore
      .collection('Comments')
      .doc(widget.postId)
      .collection('comments')
      .doc(widget.commentId)
      .collection('replies');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Replies'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _repliesCollection.orderBy('date').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                final replies =
                snapshot.data!.docs.map((doc) => Reply.fromSnapshot(doc)).toList();

                return ListView.builder(
                  itemCount: replies.length,
                  itemBuilder: (context, index) {
                    final reply = replies[index];
                    return ListTile(
                      title: Text(reply.text),
                      subtitle: Text(
                        DateFormat('MMM dd, yyyy - hh:mm a').format(reply.date),
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
                    controller: _replyController,
                    decoration: InputDecoration(
                      hintText: 'Add a reply...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    addReply();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addReply() async {
    String newReplyText = _replyController.text.trim();
    if (newReplyText.isNotEmpty) {
      await _repliesCollection.add({
        'text': newReplyText,
        'date': Timestamp.now(),
      });
      _replyController.clear();
    }
  }
}

class Reply {
  final String id;
  final String text;
  final DateTime date;

  Reply({
    required this.id,
    required this.text,
    required this.date,
  });

  factory Reply.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Reply(
      id: snapshot.id,
      text: data['text'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
    );
  }
}
