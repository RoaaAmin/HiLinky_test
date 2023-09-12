import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> comments = []; // List to store comments
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment Section'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  title: Text(comment.text),
                  subtitle: Text(
                      DateFormat('MMM dd, yyyy - hh:mm a').format(comment.date)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteComment(index);
                    },
                  ),
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
                    controller: commentController,
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

  void addComment() {
    String newCommentText = commentController.text.trim();
    if (newCommentText.isNotEmpty) {
      setState(() {
        Comment newComment = Comment(
          text: newCommentText,
          date: DateTime.now(),
        );
        comments.add(newComment);
        commentController.clear();
      });
    }
  }

  void deleteComment(int index) {
    setState(() {
      comments.removeAt(index);
    });
  }
}

class Comment {
  final String text;
  final DateTime date;

  Comment({
    required this.text,
    required this.date,
  });
}
