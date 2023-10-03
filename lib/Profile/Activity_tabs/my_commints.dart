import 'package:flutter/material.dart';
import 'package:hilinky_test/Profile/Activity_tabs/com.dart';

class MyCommints extends StatelessWidget {
  const MyCommints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: const [
        com(),
        com(),
        com(),
      ],
    ));
  }
}

