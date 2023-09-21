import 'package:flutter/material.dart';
import 'package:hilinky_test/Profile/Activity_tabs/post_design.dart';

import '../../screens/my_card/myCard.dart';

class CardsList extends StatelessWidget {
  const CardsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        post_design(
          name: 'star',
          username: "@star000",
          profileImage: "assets/images/avatary.png",
          image: "assets/images/HilinkyLogo.png",
        ),
        post_design(
          name: 'test',
          username: "@test333",
          profileImage: "assets/images/avatary.png",
          image: "assets/images/HilinkyLogo.png",
        ),
        post_design(
          name: 'maali',
          username: "@maali",
          profileImage: "assets/images/avatary.png",
          image: "assets/images/HilinkyLogo.png",
        ),
      ],
    );
  }
}
