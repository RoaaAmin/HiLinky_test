import 'package:flutter/material.dart';

class f extends StatelessWidget {
  const f({
    super.key,
    required this.texty,
    required this.icony,
    required this.colory,
  });

  final String texty;
  final Icon icony;
  final Color colory;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 120,
      height: 100,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colory,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icony,
          Text(
            texty,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
