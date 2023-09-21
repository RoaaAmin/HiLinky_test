import 'package:flutter/material.dart';

class post_design extends StatelessWidget {
  const post_design(
      {super.key,
      required this.name,
      required this.username,
      required this.profileImage,
      required this.image});

  final String name, username, profileImage, image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        elevation: 3,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                trailing: CircleAvatar(
                  backgroundImage: AssetImage(profileImage),
                ),
                title: Text(
                  name,
                  textAlign: TextAlign.end,
                ),
                subtitle: Text(
                  username,
                  textAlign: TextAlign.end,
                ),
              ),
              const Text(
                "Hello Linky",
                textAlign: TextAlign.start,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image(
                    image: AssetImage(image),
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border),
                  Text("  5676       "),
                  Icon(Icons.insert_comment_outlined),
                  Text("  5676       "),
                  Icon(Icons.ios_share_rounded),
                  Text("  5676        "),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
