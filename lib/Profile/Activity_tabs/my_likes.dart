import 'package:flutter/material.dart';

import 'card_list.dart';

class MyLikes extends StatefulWidget {
  const MyLikes({super.key});

  @override
  State<MyLikes> createState() => _MyLikesState();
}

class _MyLikesState extends State<MyLikes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
          // appBar: AppBar(
          //   title: const Text("MyLikes"),
          //   leading: const Icon(Icons.arrow_back_ios),
          // ),

          body: ListView(
       children: const [CardsList()],
      )),
    );
  }
}
