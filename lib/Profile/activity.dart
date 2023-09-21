import 'package:flutter/material.dart';

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
          leading: const Icon(Icons.arrow_back_ios),
        ),
        body:  tabs());
  }
}
