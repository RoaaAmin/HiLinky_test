import 'package:flutter/material.dart';
import 'package:hilinky_test/HELP/f.dart';

class f_list extends StatelessWidget {
  const f_list({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        f(
            texty: "Getting Started",
            icony: Icon(Icons.notifications),
            colory: Colors.red),
        f(
            texty: "NFC cards",
            icony: Icon(Icons.notifications),
            colory: Colors.blue),
        f(
            texty: "Getting Started",
            icony: Icon(Icons.notifications),
            colory: Colors.transparent),
        f(
            texty: "Payment Meth…",
            icony: Icon(Icons.notifications),
            colory: Colors.brown),
        f(
            texty: "Getting Started",
            icony: Icon(Icons.notifications),
            colory: Colors.deepOrange),
      ],
    );
  }
}
