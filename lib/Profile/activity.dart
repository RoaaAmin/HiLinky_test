import 'package:flutter/material.dart';
import 'package:hilinky_test/Profile/profile.dart';
import 'package:hilinky_test/components/context.dart';

import 'Activity_tabs/tabs.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Activity"),
            leading: IconButton(
                onPressed: () {
                  context.pushPage( profiletest());
                },
                icon: const Icon(Icons.arrow_back_ios))),
        body: const tabs());
  }
}
