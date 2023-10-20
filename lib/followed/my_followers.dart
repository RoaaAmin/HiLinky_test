
import 'package:flutter/material.dart';
import 'package:hilinky_test/followed/followed_list.dart';

class MyFollowers extends StatefulWidget {
  const MyFollowers({super.key});

  @override
  State<MyFollowers> createState() => _MyFollowersState();
}

class _MyFollowersState extends State<MyFollowers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("MyFollowers"),
        //   leading: const Icon(Icons.arrow_back_ios),
        // ),

        body: ListView(
      children:  [Followed_list()],
    ));
  }
}
