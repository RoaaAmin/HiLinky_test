import 'package:flutter/material.dart';

class followed extends StatefulWidget {
  const followed({super.key});

  @override
  State<followed> createState() => _followedState();
}

class _followedState extends State<followed> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Followed")),
    );
  }
}
