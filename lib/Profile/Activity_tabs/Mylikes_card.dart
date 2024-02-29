import 'package:flutter/material.dart';
import 'package:hilinky_test/Profile/Activity_tabs/post_design.dart';

import '../../screens/my_card/myCard.dart';
import 'likes_post.dart';

class MyLikes_Card extends StatelessWidget {
  const MyLikes_Card({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        LikesPost(
          name: 'star',
          username: "@star000",
          profileImage: "assets/images/avatary.png",
          image: "assets/images/HilinkyLogo.png",
        ),
        LikesPost(
          name: 'test',
          username: "@test333",
          profileImage: "assets/images/avatary.png",
          image: "assets/images/HilinkyLogo.png",
        ),
        LikesPost(
          name: 'maali',
          username: "@maali",
          profileImage: "assets/images/avatary.png",
          image: "assets/images/HilinkyLogo.png",
        ),
      ],
    );
  }
}
