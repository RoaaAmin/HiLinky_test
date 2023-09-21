import 'package:flutter/material.dart';
import 'package:hilinky_test/Profile/Activity_tabs/card_list.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({super.key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
          // appBar: AppBar(
          //   title: const Text("MyPosts"),
          //   leading: const Icon(Icons.arrow_back_ios),
          // ),

          body: ListView(
        children: const [CardsList()],
      )),
    );
  }
}
