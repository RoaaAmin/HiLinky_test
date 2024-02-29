import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final String postId;

  const LikeButton({required this.postId});

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    // Fetch initial like status and count when the widget initializes
    fetchLikeStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border_outlined,
            color: isLiked ? Colors.red : null,
          ),
          onPressed: () {
            setState(() {
              // Toggle the like status
              isLiked = !isLiked;

              // Update the like count
              likeCount = isLiked ? likeCount + 1 : likeCount - 1;
            });

            // Update like status in Firestore
            updateLikeStatus(isLiked);
          },
        ),
        Text('$likeCount'),
      ],
    );
  }

  // Fetch initial like status and count from Firestore
  void fetchLikeStatus() async {
    try {
      // Get current user ID
      String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;

      if (currentUserUid != null) {
        // Reference to the document containing the like status
        DocumentSnapshot<Map<String, dynamic>> likeDoc = await FirebaseFirestore
            .instance
            .collection('Likes')
            .doc(widget.postId)
            .collection('Users')
            .doc(currentUserUid)
            .get();

        // Check if the user has liked the post
        setState(() {
          isLiked = likeDoc.exists;
        });

        // Get the total like count
        QuerySnapshot<Map<String, dynamic>> likesQuery = await FirebaseFirestore
            .instance
            .collection('Likes')
            .doc(widget.postId)
            .collection('Users')
            .get();

        setState(() {
          likeCount = likesQuery.size;
        });
      }
    } catch (e) {
      print('Error fetching like status: $e');
    }
  }

  // Update like status in Firestore
  void updateLikeStatus(bool isLiked) async {
    try {
      // Get current user ID
      String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;

      if (currentUserUid != null) {
        // Reference to the like document for the current user
        DocumentReference likeDocRef = FirebaseFirestore
            .instance
            .collection('Likes')
            .doc(widget.postId)
            .collection('Users')
            .doc(currentUserUid);

        if (isLiked) {
          // Set the like status to true
          await likeDocRef.set({'liked': true});
        } else {
          // Delete the like status document
          await likeDocRef.delete();
        }
      }
    } catch (e) {
      print('Error updating like status: $e');
    }
  }
}
