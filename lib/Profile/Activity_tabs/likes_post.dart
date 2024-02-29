import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Comment/CommentPage.dart';
import '../../feeds/LikeButton.dart';

class LikesPost extends StatefulWidget {
  final String? postedByUID;

  const LikesPost({
    Key? key,
    required this.profileImage,
    this.postedByUID,
    required this.name,
    required this.username,
    required this.image,
  }) : super(key: key);

  final String name, username, profileImage, image;

  @override
  State<LikesPost> createState() => _LikesPostState();
}

class _LikesPostState extends State<LikesPost> {
  List<DocumentSnapshot<Map<String, dynamic>>> postsDocs = [];
  bool postsFetched = false;

  @override
  void initState() {
    super.initState();
    fetchLikedPosts();
  }

  fetchLikedPosts() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        QuerySnapshot<Map<String, dynamic>> likesSnapshot =
        await FirebaseFirestore.instance
            .collection('Likes')
            .where('Users', isEqualTo: user.uid)
            .get();

        if (likesSnapshot.docs.isNotEmpty) {
          List<String> postIds = likesSnapshot.docs
              .map((doc) => doc['postId'] as String)
              .toList();
          await fetchPosts(postIds);
        } else {
          setState(() {
            postsFetched = true;
          });
        }
      } catch (e) {
        print('Error fetching liked posts: $e');
      }
    }
  }

  fetchPosts(List<String> postIds) async {
    try {
      QuerySnapshot<Map<String, dynamic>> postsSnapshot =
      await FirebaseFirestore.instance
          .collection('Posts')
          .where(FieldPath.documentId, whereIn: postIds)
          .get();

      if (postsSnapshot.docs.isNotEmpty) {
        setState(() {
          postsDocs = postsSnapshot.docs;
          postsFetched = true;
        });
      } else {
        setState(() {
          postsFetched = true;
        });
      }
    } catch (e) {
      print('Error fetching posts: $e');
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
    if (!postsFetched) {
      return Center(child: CircularProgressIndicator());
    } else if (postsDocs.isEmpty) {
      return Center(child: Text('No liked posts found'));
    } else {
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
                      widget.username,
                      textAlign: TextAlign.start,
                    ),
                    subtitle: Text(
                      '@${widget.name}',
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Text(
                    '${postsDocs[i]['Description']}',
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            postsDocs[i]['ImageURL'],
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
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LikeButton(
                        postId: postsDocs[i].id,
                      ),
                      Text("       "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentPage(
                                PostId: postsDocs[i].id,
                              ),
                            ),
                          );
                        },
                        child: Icon(Icons.insert_comment_outlined),
                      ),
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
    }
  }
}
